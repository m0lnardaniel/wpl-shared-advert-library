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

$stmt = $app->getPDO()->query('SELECT * FROM `sites`');
$stmt->setFetchMode(PDO::FETCH_OBJ);

while ($site = $stmt->fetch()) {
  print $site->name;

  $sitePath = $rootPath . $site->name;
  printMsg(file_exists($sitePath), 'path', 'path');

  $apiFile = $sitePath . '/plugins/advert/api.php';
  printMsg(file_exists($apiFile), 'api', 'api');
  if (file_exists($apiFile)) {
//    printMsg(copy($newApiFile, $apiFile), 'copy', 'copy');
  }

  $cfgFile = $sitePath . '/config/local.php';
  printMsg(file_exists($cfgFile), 'config', 'config');

  if (file_exists($apiFile)) {
//    $cfg = file_get_contents($cfgFile);
//    $cfgResponse = file_put_contents($cfgFile, preg_replace($cfgPattern, $cfgReplacement, $cfg));
//    printMsg($cfgResponse !== false, 'replace', 'replace');
  }

  $applicationFile = $sitePath . '/config/application.php';
  printMsg(file_exists($applicationFile), 'application', 'application');

  if (file_exists($apiFile)) {
//    $application = file_get_contents($applicationFile);
//    $applicationResponse = file_put_contents($applicationFile, preg_replace($cfgPattern, "", $application));
//    printMsg($applicationResponse !== false, 'replace', 'replace');
  }
  print '<br/>';
}

function printMsg(bool $bool, $msgYes, $msgNo) {
  print ($bool)
    ? ' - <span style="color:green;">'.$msgYes.'</span>'
    : ' - <strong style="color:red;">'.$msgNo.'</strong>';
}