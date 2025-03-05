<?php

namespace SharedAdvertLibrary;

use SharedAdvertLibrary\Library\AdvertProcessor;
use SharedAdvertLibrary\Library\Bootstrap;
use SharedAdvertLibrary\Library\QueueJob;

try {
  require_once dirname(__FILE__) . '/library/bootstrap.php';
  $app = new Bootstrap();

  // Check if the queue is locked
  if ($app->getQueueService()->isLocked()) {
    die('Queue is locked');
  }

  // Check if there are any jobs in the queue
  if ($app->getQueueService()->getQueueCount() === 0) {
    die('No jobs in the queue');
  }

  // Lock the queue
  $app->getQueueService()->lock();

  // Get the jobs from the queue
  $statement = $app->getQueueService()->getJobs();

  /** @var QueueJob $job */
  while ($job = $statement->fetch()) {
    $advertProcessor = new AdvertProcessor($app->getPDO(), $job);
    $advertProcessor->run();

    // Finish the job
    $app->getQueueService()->finishJob($job);
  }

  // Unlock the queue
  $app->getQueueService()->unlock();
} catch (\Exception $e) {
  $logFile = dirname(__FILE__) . '/log.txt';
  file_put_contents($logFile, $e->getMessage() . "\n", FILE_APPEND);
}