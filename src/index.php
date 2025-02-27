<?php

print '<pre>';
require_once 'bootstrap.php';
$app = new bootstrap();

// Check if the queue is locked
if ($app->getQueueService()
  ->isLocked()) {
  //  die('Queue is locked');
}

// Check if there are any jobs in the queue
if ($app->getQueueService()
    ->getQueueCount() === 0) {
  die('No jobs in the queue');
}

// Lock the queue
$app->getQueueService()
  ->lock();

// Get the jobs from the queue
$statement = $app->getQueueService()
  ->getJobs();
/** @var QueueJob $job */
while ($job = $statement->fetch()) {
  print_r($job);
  $app->getAdvertService()->processJob($job);

  // Finish the job
  // $app->getQueueService()->finishJob($job);
}

// Unlock the queue
$app->getQueueService()
  ->unlock();
