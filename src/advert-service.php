<?php

class AdvertService {
  private PDO $pdo;
  private LogService $logService;

  public function __construct(PDO $pdo) {
    $this->pdo = $pdo;

    require_once 'log-service.php';
    $this->logService = new LogService($pdo);
  }

  public function processJob(QueueJob $job): bool {
    try {
      // Set the request for the log service
      $this->logService->setRequest($job);

      // Find the site
      $site = $this->findSiteByName($job->site_id);
      // Find the target sites
      $targetSites = $this->getTargetSites($site);

      // Check if there are any target sites
      if (sizeof($targetSites) === 0) {
        throw new Exception('No target sites found');
      }

      if ($job->action === 'delete') {
        $this->runDeletion($site, $job->advert_id, $targetSites);
      }
      else if ($job->action === 'sync') {
        $advert = new Advert($site, $job->advert_id, $job);
        $this->runSynchronization($advert, $targetSites);
      }

      return true;
    } catch (Exception $e) {
      $this->logService->add($e);
      return false;
    }
  }

  public function findSiteByName(string $name) {
    $stmt = $this->pdo->prepare('SELECT * FROM `sites` WHERE `name` = :name AND `active` = 1');
    $stmt->execute(['name' => $name]);
    $site = $stmt->fetchObject(Site::class);
    if (!$site) {
      throw new Exception('Site not found');
    }
    return $site;
  }

  private function runSynchronization(Advert $advert, array $targetSites) {
    // narrow down the target sites based on the group
    $targetSites = array_filter($targetSites, function ($target) use ($advert) {
      return $target->{$advert->group};
    });

    // Check if there are any target sites
    if (sizeof($targetSites) === 0) {
      throw new Exception('No target sites found');
    }

    foreach ($targetSites as $targetSite) {
      try {
        // Prepare the data
        if ($targetSite->manageAllGroups())
          $advert->updateSubCategoryByMapping();

        // Check if the advert exists in the target site
        if ($this->checkAdvertExistInRemote($advert, $targetSite)) {
          $targetAdvertId = $this->findAdvertIdInRemoteTable($advert, $targetSite);
          $this->updateItemInRemoteTable($targetSite, $advert->getTableName(), $targetAdvertId, $advert->data);
          if ($advert->isSpecialGroup()) {
            // create job, car, property item in the right table
            $this->updateItemInRemoteTable($targetSite, $advert->group, $targetAdvertId,
              $advert->getUpdatedGroupData($targetAdvertId));
            // create features
            $this->syncFeaturesInRemoteTable($targetSite, $advert->group, $targetAdvertId, $advert->featuresData);
          }
        }
        else {
          // Check if the advert is in progress, if so, skip
          if ($advert->isInprogress()) {
            continue;
          }

          $targetAdvertId = $this->createItemInRemoteTable($targetSite, $advert->getTableName(), $advert->data);
          if ($advert->isSpecialGroup()) {
            // create job, car, property item in the right table
            $this->createItemInRemoteTable($targetSite, $advert->group, $advert->getUpdatedGroupData($targetAdvertId));
            // create features
            $this->syncFeaturesInRemoteTable($targetSite, $advert->group, $targetAdvertId, $advert->featuresData);
          }
        }
      } catch (Exception $e) {
        $this->logService->add($e);
      }
    }
  }

  private function runDeletion(Site $site, int $advertId, array $targetSites) {
    foreach ($targetSites as $targetSite) {
      try {
        $cmd = sprintf("DELETE FROM `%s`.`advert` WHERE remote_site=:site AND remote_id=:id", $targetSite->db_table);
        $stmt = $this->pdo->prepare($cmd);
        $stmt->execute(['site' => $targetSite->name, 'id' => $advertId]);
      } catch (Exception $e) {
        $this->logService->add($e);
      }
    }
  }

  private function getCollectionIdsBySite(Site $site): array {
    $cmd =
      "SELECT `collection_id` FROM `site_collections` JOIN `collections` ON `collections`.`id` = `site_collections`.`collection_id` AND `collections`.`active` = 1 WHERE `site_id` = :site_id";
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['site_id' => $site->id]);
    return $stmt->fetchAll(PDO::FETCH_COLUMN);
  }

  private function getAllSitesByCollections(array $collectionIds): array {
    $stmt =
      $this->pdo->prepare('SELECT DISTINCT `sites`.* FROM `sites` JOIN `site_collections` ON `site_collections`.`site_id` = `sites`.`id` AND `site_collections`.`collection_id` IN (' .
        implode(',', $collectionIds) . ') WHERE `sites`.`active` = 1');
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_CLASS, Site::class);
  }

  private function getTargetSites(Site $site): array {
    $collectionIds = $this->getCollectionIdsBySite($site);
    $targetSites = $this->getAllSitesByCollections($collectionIds);
    return array_filter($targetSites, function ($target) use ($site) {
      return $target->id !== $site->id;
    });
  }

  private function checkAdvertExistInRemote(Advert $advert, Site $target): bool {
    $cmd = sprintf("SELECT EXISTS(SELECT 1 FROM `%s`.`advert` WHERE `remote_site`=:site AND `remote_id`=:id LIMIT 1)",
      $target->db_table);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['site' => $advert->site->name, 'id' => $advert->id]);
    return $stmt->fetchColumn() == '1';
  }

  private function createItemInRemoteTable(Site $target, string $table, array $data): ?int {
    $cmd = $this->createCommand($target->db_table, $table, $data);
    $this->pdo->prepare($cmd)
      ->execute(array_values($data));
    return $this->pdo->lastInsertId();
  }

  private function createCommand(string $dbName, string $table, array $data) {
    $keys = array_keys($data);
    $columns = '`' . implode('`, `', $keys) . '`';
    $placeholders = implode(", ", array_fill(0, count($data), "?"));
    return sprintf("INSERT INTO `%s`.`%s` (%s) VALUES (%s)", $dbName, $table, $columns, $placeholders);
  }

  private function updateItemInRemoteTable(Site $target, string $table, int $id, array $data) {
    $cmd = $this->updateCommand($target->db_table, $table, $data);
    $data['id'] = $id;
    $this->pdo->prepare($cmd)
      ->execute($data);
  }

  private function updateCommand(string $dbName, string $table, array $data) {
    $setPart = implode(', ', array_map(fn($key) => "`$key` = :$key", array_keys($data)));
    return sprintf("UPDATE `%s`.`%s` SET %s WHERE `advert_id`=:id", $dbName, $table, $setPart);
  }

  private function syncFeaturesInRemoteTable(Site $target, string $group, int $advertId, array $features) {
    $tableName = $group . '_features';
    $pkName = $group . '_id';

    // Delete all features for the advert
    $cmd = sprintf("DELETE FROM `%s`.`%s` WHERE `%s`=:id", $target->db_table, $tableName, $pkName);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['id' => $advertId]);

    // Insert new features
    $cmd =
      sprintf("INSERT INTO `%s`.`%s` (`%s`, `feature_id`) VALUES (:id, :feature_id)", $target->db_table, $tableName,
        $pkName);
    $stmt = $this->pdo->prepare($cmd);
    foreach ($features as $featureId) {
      $stmt->execute(['id' => $advertId, 'feature_id' => $featureId]);
    }
  }

  private function findAdvertIdInRemoteTable(Advert $advert, Site $target): ?int {
    $cmd = sprintf("SELECT `advert_id` FROM `%s`.`advert` WHERE `remote_site`=:site AND `remote_id`=:id LIMIT 1",
      $target->db_table);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['site' => $advert->site->name, 'id' => $advert->id]);
    return $stmt->fetchColumn();
  }
}

class Site {
  public int $id;
  public string $name;
  public string $db_table;
  public bool $basic;
  public bool $car;
  public bool $job;
  public bool $property;
  public bool $active;
  public string $created_at;
  public string $updated_at;

  public function manageAllGroups() {
    return $this->basic && $this->car && $this->job && $this->property;
  }
}

class Advert {
  const GROUPS = ['basic', 'car', 'job', 'property'];
  const CATEGORIES = ['car' => 2, 'job' => 1, 'property' => 17];
  public Site $site;
  public int $id;
  public array $data;
  public ?array $groupData;
  public ?array $featuresData;
  public string $group;

  /**
   * @throws Exception
   */
  public function __construct(Site $site, int $advertId, QueueJob $job) {
    $data = json_decode($job->data, true);
    $this->site = $site;
    $this->id = $advertId;
    $this->data = $data['advert'];
    $this->data['remote_site'] = $site->name;
    $this->data['remote_id'] = $advertId;
    $this->group = $this->data['group'];

    // Check if the group exists
    if (!in_array($this->group, self::GROUPS)) {
      throw new Exception('Wrong group value');
    }

    if ($this->isSpecialGroup()) {
      $this->groupData = (array)$data[$this->group] ?? [];
      $this->featuresData = (array)$data[$this->group . '_features'] ?? [];
    }

    // Check if the subCategoryId exists
    if (!$this->data['subcategory_id'])
      unset($this->data['subcategory_id']);

    // Check if the cityId exists
    if (!$this->data['city_id'])
      unset($this->data['city_id']);
  }

  public function getTableName() {
    return 'advert';
  }

  public function isSpecialGroup(): bool {
    return in_array($this->group, ['job', 'car', 'property']);
  }

  public function isInprogress(): bool {
    return $this->data['status'] === 'inprogress';
  }

  public function getUpdatedGroupData(int $targetAdvertId): array {
    $groupData = $this->groupData;
    $groupData[$this->group . '_id'] = $groupData['advert_id'] = $targetAdvertId;
    return $groupData;
  }

  public function updateSubCategoryByMapping() {
    $subCategoryId = (array_key_exists($this->group, self::CATEGORIES))
      ? sprintf('1%02d%02d', self::CATEGORIES[$this->group], $this->groupData['category_id'])
      : null;

    if ($subCategoryId) {
      $this->data['subcategory_id'] = $subCategoryId;
    }
  }
}
