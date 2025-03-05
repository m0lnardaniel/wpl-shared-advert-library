<?php

namespace SharedAdvertLibrary;

use PDO;
use SharedAdvertLibrary\Library\Bootstrap;

require_once dirname(__FILE__) . '/library/bootstrap.php';
$app = new bootstrap();

$rootPath = '/var/www/html/';
$newApiFile = dirname(__FILE__) . '/install/api.php';
$cfgPattern = "/'advert\-sites'\s*=>\s*\[[\s\S]*?\]/s";
$cfgReplacement = "'advert-sharing' => true";
$indexReplacement = "
// AdvertApi
if (bm_system_url::first() == 'api')
  bm_template::registerParam('layout', bm_system_url::actual());

";

$stmt = $app->getPDO()->query('SELECT * FROM `sites`');
$stmt->setFetchMode(PDO::FETCH_OBJ);

while ($site = $stmt->fetch()) {
  print $site->name;

  /*
   * Check if the site folder exists
   */
  $sitePath = $rootPath . $site->name;
  printMsg(file_exists($sitePath), 'path', 'path');

  /*
   * Check if the index.php file exists
   */
  $indexFile = $sitePath . '/index.php';
  printMsg(file_exists($indexFile), 'index', 'index');
  if (file_exists($indexFile)) {
    $index = file_get_contents($indexFile);
    file_put_contents($indexFile, str_replace($indexReplacement, "", $index));
  }

  /*
   * Check if the api.php file exists
   */
  $apiFile = $sitePath . '/plugins/advert/api.php';
  printMsg(file_exists($apiFile), 'api', 'api');
  if (file_exists($apiFile)) {
    printMsg(copy($newApiFile, $apiFile), 'copy', 'copy');
  }

  /*
   * Check if the config file exists
   */
  $cfgFile = $sitePath . '/config/local.php';
  printMsg(file_exists($cfgFile), 'config', 'config');

  if (file_exists($apiFile)) {
    $cfg = file_get_contents($cfgFile);
    $cfgResponse = file_put_contents($cfgFile, preg_replace($cfgPattern, $cfgReplacement, $cfg));
    printMsg($cfgResponse !== false, 'replace', 'replace');
  }

  /*
   * Check if the application file exists
   */
  $applicationFile = $sitePath . '/config/application.php';
  printMsg(file_exists($applicationFile), 'application', 'application');

  if (file_exists($apiFile)) {
    $application = file_get_contents($applicationFile);
    $applicationResponse = file_put_contents($applicationFile, preg_replace($cfgPattern, "", $application));
    printMsg($applicationResponse !== false, 'replace', 'replace');
  }


  /*
   * Check if the sites folder exists
   */
  $sitesFolder = $sitePath . '/sites';
  printMsg(file_exists($sitesFolder), 'sites', 'sites');

  if (file_exists($sitesFolder)) {
    $sitesFolders = array_filter(scandir($sitesFolder), function ($item) use ($sitesFolder) {
      return is_dir($sitesFolder . DIRECTORY_SEPARATOR . $item) && !in_array($item, ['.', '..', 'admin']);
    });

    foreach ($sitesFolders as $folder) {
      $folderPath = $sitesFolder . DIRECTORY_SEPARATOR . $folder . '/api';
      if (file_exists($folderPath) && file_exists($folderPath . '/delete.php') &&
        file_exists($folderPath . '/import.php') && file_exists($folderPath . '/save-images.php')) {
        printMsg(true, $folder, $folder);
        unlink($folderPath . '/delete.php');
        unlink($folderPath . '/import.php');
        unlink($folderPath . '/save-images.php');
        unlink($folderPath . '/_info.php');
        printMsg(rmdir($folderPath), 'remove', 'remove');
      }
    }
  }
  print '<br/>';
}

function printMsg(bool $bool, $msgYes, $msgNo) {
  print ($bool)
    ? ' - <span style="color:green;">' . $msgYes . '</span>'
    : ' - <strong style="color:red;">' . $msgNo . '</strong>';
}