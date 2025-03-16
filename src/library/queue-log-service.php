<?php

namespace SharedAdvertLibrary\Library;

use PDO;

class QueueLogService {
  private PDO $pdo;
  private QueueJob $job;
  private int $startedAtMicrotime;
  private string $startedAt;
  private int $targets = 0;
  private int $succeeded = 0;
  private int $failed = 0;

  public function __construct(PDO $pdo, QueueJob $job) {
    $this->pdo = $pdo;
    $this->job = $job;
    $this->startedAt = date('Y-m-d H:i:s');
    $this->startedAtMicrotime = microtime(true);
  }

  public function setTargets(int $targets): void {
    $this->targets = $targets;
  }

  public function failed(): void {
    $this->add('failed');
  }

  public function done(): void {
    $this->add('successful');
  }

  public function increaseSucceeded() {
    $this->succeeded++;
  }

  public function increaseFailed() {
    $this->failed++;
  }

  public function add(string $status): void {
    $cmd =
      'INSERT INTO `queue_logs` (`site_id`, `advert_id`, `action`, `targets`, `succeeded`, `failed`, `status`, `duration`, `created_at`, `started_at`, `finished_at`) 
        VALUES (:site_id, :advert_id, :action, :targets, :succeeded, :failed, :status, :duration, :created_at, :started_at, :finished_at)';
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute([
      'site_id' => $this->job->site_id,
      'advert_id' => $this->job->advert_id,
      'action' => $this->job->action,
      'targets' => $this->targets,
      'succeeded' => $this->succeeded,
      'failed' => $this->failed,
      'status' => $status,
      'duration' => microtime(true) - $this->startedAtMicrotime,
      'created_at' => $this->job->created_at,
      'started_at' => $this->startedAt,
      'finished_at' => date('Y-m-d H:i:s'),
    ]);
  }
}