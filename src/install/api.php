<?php

class advert_api {
  /**
   * @param int $advertId
   *
   * @return bool
   */
  static function sync(int $advertId): bool {
    $data = self::collectData($advertId);
    if (sizeof($data) == 0)
      return false;

    return self::addJobToQueue($advertId, 'sync', $data);
  }

  /**
   * @param int $advertId
   *
   * @return bool
   */
  static function syncDelete(int $advertId): bool {
    return self::addJobToQueue($advertId, 'delete', null);
  }


  /**
   * @param int $advertId
   * @param string $action
   * @param array|null $data
   *
   * @return bool
   */
  private static function addJobToQueue(int $advertId, string $action, array $data = null): bool {
    if (env('advert-sharing') !== true)
      return false;

    try {
      $file = (env('advert-queue-file'))
        ?: LIBRARY . '../shared-advert-library/import.php';

      if (!file_exists($file))
        return false;

      $queueService = require_once $file;
      if (is_object($queueService) === false)
        return false;

      if (is_callable([$queueService, 'addJob']) === false)
        return false;

      $queueService->addJob(env('advert-site-id'), $advertId, $action, $data);

      return true;
    } catch (Exception $e) {
      return false;
    }
  }

  /**
   * @param int $advertId
   *
   * @return array
   */
  static private function collectData(int $advertId): array {
    $response = [];
    $q = db_query("SELECT * FROM `advert` WHERE `advert_id`='$advertId' LIMIT 1");
    $advert = db_result($q);
    if (!$advert)
      return [];

    unset($advert['remote_site'], $advert['remote_id'], $advert['advert_id'], $advert['site_id'], $advert['user_id'], $advert['extra4']);
    $response['advert'] = $advert;
    $group = $advert['group'];

    if (in_array($group, ['car', 'job', 'property'])) {
      $q = db_query("SELECT * FROM `$group` WHERE `advert_id`=$advertId");
      $response[$group] = db_result($q);
      unset($response[$group][$group . '_id'], $response[$group]['advert_id']);

      $featureTable = $group . '_features';
      $response[$featureTable] = [];
      $q = db_query("SELECT `feature_id` FROM `" . $featureTable . "` WHERE `" . $group . "_id` = $advertId");
      while ($row = db_result($q))
        $response[$featureTable][] = $row['feature_id'];
    }

    return $response;
  }
}

