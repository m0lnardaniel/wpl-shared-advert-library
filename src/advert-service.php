<?php

class AdvertService {
  private PDO $pdo;
  private array $groups = ['basic', 'car', 'job', 'property'];
  private array $categories = ['car' => 2, 'job' => 1, 'property' => 17];

  public function __construct(PDO $pdo) {
    $this->pdo = $pdo;
  }

  public function processJob(QueueJob $job): bool {
    try {
      $site = $this->findSiteByName($job->site_id);
      $targetSites = $this->getTargetSites($site);

      // Check if there are any target sites
      if (sizeof($targetSites) === 0) {
        throw new Exception('No target sites found');
      }

      if ($job->action === 'delete') {
        $this->runDeletion($site, $job->advert_id, $targetSites);
      }
      else if ($job->action === 'sync') {
        $advertData = json_decode($job->data, true);
        $this->runSynchronization($site, $job->advert_id, $advertData, $targetSites);
      }

      return true;
    } catch (Exception $e) {
      print $e->getMessage();
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

  private function runSynchronization(Site $site, int $advertId, array $data, array $targetSites) {
    $data['advert']['remote_site'] = $site->name;
    $data['advert']['remote_id'] = $advertId;
    $group = $data['advert']['group'];

    // Check if the group exists
    if (!in_array($group, $this->groups)) {
      throw new Exception('Wrong group value');
    }

    // narrow down the target sites based on the group
    $targetSites = array_filter($targetSites, function ($target) use ($group) {
      return $target->{$group};
    });

    // Check if there are any target sites
    if (sizeof($targetSites) === 0) {
      throw new Exception('No target sites found');
    }

    $subCategoryId = (array_key_exists($group, $this->categories))
      ? sprintf('1%02d%02d', $this->categories[$group], $data[$group]['category_id'])
      : null;

    foreach ($targetSites as $targetSite) {
      $advertData = $groupData = $featuresData = [];
      $targetAdvertId = null;
      try {
        $advertData = $data['advert'];
        if ($targetSite->manageAllGroups()) {
          $advertData['subcategory_id'] = $subCategoryId;
        }
        if (!$advertData['subcategory_id'])
          unset($advertData['subcategory_id']);

        if (!$advertData['city_id'])
          unset($advertData['city_id']);

        if ($this->checkAdvertExistInRemote($site, $advertId, $targetSite)) {
          $targetAdvertId = $this->findAdvertIdInRemoteTable($targetSite, $site, $advertId);
          $this->updateItemInRemoteTable($targetSite, 'advert', $targetAdvertId, $advertData);
          if (in_array($group, ['job', 'car', 'property'])) {
            // create job, car, property item in the right table
            $groupData = $data[$group];
            $groupData[$group . '_id'] = $groupData['advert_id'] = $targetAdvertId;
            $this->updateItemInRemoteTable($targetSite, $group, $targetAdvertId, $groupData);

            // create features
            $featuresData = (array)$data[$group . '_features'] ?? [];
            $this->syncFeaturesInRemoteTable($targetSite, $group, $targetAdvertId, $featuresData);
          }
        }
        else {
          $targetAdvertId = $this->createItemInRemoteTable($targetSite, 'advert', $advertData);
          if (in_array($group, ['job', 'car', 'property'])) {
            // create job, car, property item in the right table
            $groupData = $data[$group];
            $groupData[$group . '_id'] = $groupData['advert_id'] = $targetAdvertId;
            $this->createItemInRemoteTable($targetSite, $group, $groupData);

            // create features
            $featuresData = (array)$data[$group . '_features'] ?? [];
            $this->syncFeaturesInRemoteTable($targetSite, $group, $targetAdvertId, $featuresData);
          }
        }
      } catch (Exception $e) {
        print $e->getMessage() . '<br>';
        // TODO: Log the error
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
        // TODO: Log the error
      }
    }
  }

  private function getCollectionIdsBySite(Site $site): array {
    $stmt =
      $this->pdo->prepare('SELECT `collection_id` FROM `site_collections` JOIN `collections` ON `collections`.`id` = `site_collections`.`collection_id` AND `collections`.`active` = 1 WHERE `site_id` = :site_id');
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

  private function checkAdvertExistInRemote(Site $site, int $advertId, Site $targetSite): bool {
    $cmd = sprintf("SELECT EXISTS(SELECT 1 FROM `%s`.`advert` WHERE `remote_site`=:site AND `remote_id`=:id LIMIT 1)",
      $targetSite->db_table);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['site' => $site->name, 'id' => $advertId]);
    return $stmt->fetchColumn() == '1';
  }

  private function createItemInRemoteTable(Site $targetSite, string $table, array $data): ?int {
    $cmd = $this->createCommand($targetSite->db_table, $table, $data);
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

  private function updateItemInRemoteTable(Site $targetSite, string $table, int $id, array $data) {
    $cmd = $this->updateCommand($targetSite->db_table, $table, $data);
    $data['id'] = $id;
    $this->pdo->prepare($cmd)->execute($data);
  }

  private function updateCommand(string $dbName, string $table, array $data) {
    $setPart = implode(', ', array_map(fn($key) => "`$key` = :$key", array_keys($data)));
    return sprintf("UPDATE `%s`.`%s` SET %s WHERE `advert_id`=:id", $dbName, $table, $setPart);
  }

  private function syncFeaturesInRemoteTable(Site $targetSite, string $group, int $advertId, array $features) {
    $tableName = $group . '_features';
    $pkName = $group . '_id';

    // Delete all features for the advert
    $cmd = sprintf("DELETE FROM `%s`.`%s` WHERE `%s`=:id", $targetSite->db_table, $tableName, $pkName);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['id' => $advertId]);

    // Insert new features
    $cmd =
      sprintf("INSERT INTO `%s`.`%s` (`%s`, `feature_id`) VALUES (:id, :feature_id)", $targetSite->db_table, $tableName,
        $pkName);
    $stmt = $this->pdo->prepare($cmd);
    foreach ($features as $featureId) {
      $stmt->execute(['id' => $advertId, 'feature_id' => $featureId]);
    }
  }

  private function findAdvertIdInRemoteTable(Site $targetSite, Site $site, int $advertId): ?int {
    $cmd = sprintf("SELECT `advert_id` FROM `%s`.`advert` WHERE `remote_site`=:site AND `remote_id`=:id LIMIT 1",
      $targetSite->db_table);
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute(['site' => $site->name, 'id' => $advertId]);
    return $stmt->fetchColumn();
  }
}

class Advert {
  public Site $site;
  public int $advertId;
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