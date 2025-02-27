<?php

class advert_api {
  protected static $token = ';uA$zide8EtngbeRXs/}/8k;En/6EE73vqgVo&rN';

  /**
   * Collect Data
   *
   * @param [int] $advertId
   *
   * @return array
   */
  static function collectData($advertId) {
    $response = [];
    $q = db_query("SELECT * FROM `advert` WHERE `advert_id`='$advertId' LIMIT 1");
    $advert = db_result($q);
    $group = $advert['group'];
    unset($advert['remote_site'], $advert['remote_id'], $advert['advert_id'], $advert['site_id'], $advert['user_id'], $advert['extra4']);

    $response['site'] = env('advert-site-id');
    $response['id'] = $advertId;
    $response['advert'] = $advert;
    $response['group'] = $group;

    if (in_array($group, ['car', 'job', 'property'])) {
      $q = db_query("SELECT * FROM `$group` WHERE `advert_id`=$advertId");
      $response[$group] = db_result($q);
      unset($response[$group][$group . '_id'], $response[$group]['advert_id']);

      $response['features'] = [];
      $q = db_query("SELECT `feature_id` FROM `" . $group . "_features` WHERE `" . $group . "_id` = $advertId");
      while ($row = db_result($q))
        $response['features'][] = $row['feature_id'];
    }

    return $response;
  }

  /**
   * Sync advert data
   *
   * @param [int] $advertId
   *
   * @return bool|string
   */
  static function sync($advertId) {
    $data = self::collectData($advertId);
    if (!$data)
      return false;

    $data['token'] = self::$token;

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    foreach (env('advert-sites') as $site) {
      curl_setopt($ch, CURLOPT_URL, sprintf("https://%s/api/import", $site));
      curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
        'data' => json_encode($data)
      ]));
      $result = curl_exec($ch);
    }
    curl_close($ch);

    return $result;
  }


  /**
   * Sync delete advert
   *
   * @param [int] $advertId
   *
   * @return bool|string
   */
  static function syncDelete($advertId) {
    $data = [
      'site' => env('advert-site-id'),
      'id' => $advertId,
      'token' => self::$token,
      'delete' => true
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_setopt($ch, CURLOPT_POST, 1);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    foreach (env('advert-sites') as $site) {
      curl_setopt($ch, CURLOPT_URL, sprintf("https://%s/api/delete", $site));
      curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
        'data' => json_encode($data)
      ]));
      $result = curl_exec($ch);
    }
    curl_close($ch);

    return $result;
  }


  /**
   * Import data
   *
   * @param [array] $data
   *
   * @return void
   */
  static function import($data) {
    try {

      $data = json_decode($data['data'], true);

      if ($data['token'] != self::$token)
        throw new Exception('Wrong token');

      if (!$data['site'])
        throw new Exception('Missing `site` variable');

      if (!$data['id'])
        throw new Exception('Missing `id` variable');

      if (!$data['advert'])
        throw new Exception('Missing `advert` variable');

      if (!in_array($data['group'], env('advert-groups')))
        throw new Exception('Wrong group value');

      $group = $data['group'];
      if (in_array($group, ['job', 'car', 'property'])) {
        $categoryId = (env(sprintf('category-%s', $data['group'])));
        $data['advert']['subcategory_id'] = ($categoryId)
          ? self::categoryId($categoryId, $data[$group]['category_id'])
          : null;
      }

      // update
      if (self::exists($data))
        self::update($data);

      // create
      else
        self::create($data);

    } catch (Exception $e) {
      // print_r($e->getMessage());
      return false;
    }
  }


  /**
   * Create category Id
   *
   * @param [int] $mainId
   * @param [int] $subId
   *
   * @return string
   */
  static function categoryId($mainId, $subId) {
    return sprintf('1%02d%02d', $mainId, $subId);
  }

  /**
   * Exists advert
   *
   * @param [array] $data
   *
   * @return bool
   */
  protected static function exists($data) {
    $site = $data['site'];
    $id = $data['id'];

    $q = db_query("SELECT COUNT(*) FROM `advert` WHERE remote_site='$site' AND remote_id='$id'");
    return (db_result($q, 0) > 0)
      ? true
      : false;
  }

  /**
   * Create advert
   *
   * @param [array] $data
   *
   * @return void
   */
  protected static function create($data) {
    $group = $data['group'];
    $advert = $data['advert'];
    $advert['remote_site'] = $data['site'];
    $advert['remote_id'] = $data['id'];

    if (!$advert['subcategory_id'])
      unset($advert['subcategory_id']);

    if (!$advert['city_id'])
      unset($advert['city_id']);

    $advertId = self::_create('advert', $advert);
    if (in_array($group, ['job', 'car', 'property'])) {
      $item = $data[$group];
      $item[$group . '_id'] = $item['advert_id'] = $advertId;
      self::_create($group, $item);
      self::features($group, $advertId, $data['features']);
    }
  }

  /**
   * Create one advert
   *
   * @param [string] $table
   * @param [array] $data
   *
   * @return int
   */
  protected static function _create($table, $data) {
    $keys = $values = $params = [];
    foreach ($data as $key => $value) {
      $keys[] = $key;
      if ($value == null) {
        $params[] = 'NULL';
      }
      else {
        $params[] = "'%s'";
        $values[] = $value;
      }
    }

    $command =
      "INSERT INTO `" . $table . "` (`" . implode('`, `', $keys) . "`) VALUES (" . implode(", ", $params) . ")";
    db_query($command, $values);
    return db_insert_id();
  }


  /**
   * Update advert
   *
   * @param [array] $data
   *
   * @return void
   */
  protected static function update($data) {
    $site = $data['site'];
    $id = $data['id'];
    $group = $data['group'];
    $advert = $data['advert'];

    $q = db_query("SELECT `advert_id` FROM `advert` WHERE remote_site='$site' AND remote_id='$id'");
    $advertId = db_result($q, 0);
    self::_update('advert', $advert, $advertId);

    if (in_array($group, ['job', 'car', 'property'])) {
      $item = $data[$group];
      self::_update($group, $item, $advertId);
      self::features($group, $advertId, $data['features']);
    }
  }

  /**
   * Advert Id
   *
   * @param [string] $table
   * @param [array] $data
   * @param [int] $advertId
   *
   * @return void
   */
  protected static function _update($table, $data, $advertId) {
    $keys = $values = [];
    foreach ($data as $key => $value) {
      if ($value == null) {
        $keys[] = "`$key` = NULL";
      }
      else {
        $keys[] = "`$key` = '%s'";
        $values[] = $value;
      }
    }

    $command = "UPDATE `$table` SET " . implode(', ', $keys) . " WHERE `advert_id`='" . $advertId . "' LIMIT 1";
    db_query($command, $values);
  }


  /**
   * Sync features
   *
   * @param [string] $group
   * @param [int] $advertId
   * @param [int] $features
   *
   * @return void
   */
  protected static function features($group, $advertId, $features) {
    $table = $group . '_features';
    $pk = $group . '_id';
    db_query("DELETE FROM `$table` WHERE `$pk`='$advertId'");

    foreach ((array)$features as $featureId)
      db_query("INSERT INTO `$table` (`$pk`, `feature_id`) VALUES ('$advertId', '$featureId')");
  }


  /**
   * Delete advert
   *
   * @param [array] $data
   *
   * @return void
   */
  static function delete($data) {
    try {

      $data = json_decode($data['data'], true);

      if ($data['token'] != self::$token)
        throw new Exception('Wrong token');

      if (!$data['site'])
        throw new Exception('Missing `site` variable');

      if (!$data['id'])
        throw new Exception('Missing `id` variable');

      $site = $data['site'];
      $id = $data['id'];

      db_query("DELETE FROM `advert` WHERE remote_site='$site' AND remote_id='$id'");

    } catch (Exception $e) {
      // print_r($e->getMessage());
      return false;
    }
  }


  /**
   * Save Images
   *
   * @return void
   */
  static function saveImages() {
    $q = db_query("SELECT advert_id FROM advert");
    while ($item = db_result($q))
      advert_service::saveImages($item['advert_id']);
  }

}

