<?php

namespace SharedAdvertLibrary;

use PDO;
use SharedAdvertLibrary\Library\AdvertProcessor;
use SharedAdvertLibrary\Library\Bootstrap;
use SharedAdvertLibrary\Library\QueueJob;

// This script is used to re-run any errored jobs in the queue_errors table
// It will loop through each errored job, re-process it and then delete it from the queue_errors table
// This script is intended to be run manually when needed

try {
  require_once dirname(__FILE__) . '/library/bootstrap.php';
  $app = new Bootstrap();

  $pdo = $app->getPDO();
  $stmt = $pdo->query("SELECT DISTINCT `request` FROM `queue_errors`");

  while ($error = $stmt->fetch()) {
    print '<br />';
    $request = json_decode($error->request, true);
    $job = new QueueJob();
    $job->id = $request['id'];
    $job->site_id = $request['site_id'];
    $job->advert_id = $request['advert_id'];
    $job->action = $request['action'];
    $job->data = $request['data'];
    $job->created_at = $request['created_at'];
    print_r($job);

    $advertProcessor = new AdvertProcessor($app->getPDO(), $job);
    $advertProcessor->run();

    $stmtDel = $pdo->prepare("DELETE FROM `queue_errors` WHERE `request` = :request");
    $stmtDel->execute(['request' => $error->request]);
    print ' - Deleted job<br />';
  }

} catch (\Exception $e) {
  $logFile = dirname(__FILE__) . '/log.txt';
  file_put_contents($logFile, $e->getMessage() . "\n", FILE_APPEND);
}