<?php

class QueueService {
  private PDO $pdo;
  private array $config;

  public function __construct(PDO $pdo, array $config) {
    $this->pdo = $pdo;
    $this->config = $config;
  }

  // get how many jobs are in the queue
  public function getQueueCount(): int {
    $stmt = $this->pdo->prepare("SELECT COUNT(*) FROM `queue_jobs`");
    $stmt->execute();
    return $stmt->fetchColumn();
  }

  public function addJob(string $siteId, int $advertId, string $action, array $data = null) {
    $cmd = "INSERT INTO `queue_jobs` (`site_id`, `advert_id`, `action`, `data`, `created_at`) VALUES (:site_id, :advert_id, :action, :data, NOW())";
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute([
      'site_id' => $siteId,
      'advert_id' => $advertId,
      'action' => $action,
      'data' => json_encode($data)
    ]);
  }

  public function getJobs(): PDOStatement {
    $stmt = $this->pdo->query("SELECT * FROM `queue_jobs` ORDER BY `id` LIMIT " . $this->config['batch-size']);
    $stmt->setFetchMode(PDO::FETCH_CLASS, QueueJob::class);
    return $stmt;
  }

  public function finishJob(QueueJob $job) {
    if ($this->config['dry-run'] === true)
      return;

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