<?php

class QueueService {
  private PDO $pdo;

  public function __construct(PDO $pdo) {
    $this->pdo = $pdo;
  }

  // get how many jobs are in the queue
  public function getQueueCount(): int {
    $stmt = $this->pdo->prepare("SELECT COUNT(*) FROM `queue_jobs`");
    $stmt->execute();
    return $stmt->fetchColumn();
  }
  public function getJobs(): PDOStatement {
    $stmt = $this->pdo->query("SELECT * FROM `queue_jobs` ORDER BY `id` LIMIT 100");
    $stmt->setFetchMode(PDO::FETCH_CLASS, QueueJob::class);
    return $stmt;
  }

  public function finishJob(QueueJob $job) {
    $stmt = $this->pdo->prepare("DELETE FROM `queue_jobs` WHERE `id` = :id");
    $stmt->execute(['id' => $job->id]);
  }

  public function lock() {
    file_put_contents('queue.lock', 'locked');
  }

  public function unlock() {
    unlink('queue.lock');
  }

  public function isLocked() {
    return file_exists('queue.lock');
  }
}

class QueueJob {
  public int $id;
  public string $site_id;
  public int $advert_id;
  public string $action;
  public ?string $data = null;
  public string $created_at;
}