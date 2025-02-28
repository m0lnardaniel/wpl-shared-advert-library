<?php

class LogService {
  private PDO $pdo;

  private QueueJob $job;

  public function __construct(PDO $pdo, QueueJob $job) {
    $this->pdo = $pdo;
    $this->job = $job;
  }

  public function add(Exception $exception): void {
    $cmd =
      'INSERT INTO `logs` (`message`, `payload`, `request`, `created_at`) VALUES (:message, :payload, :request, NOW())';
    $stmt = $this->pdo->prepare($cmd);
    $stmt->execute([
      'message' => $exception->getMessage(),
      'payload' => json_encode([
        'file' => $exception->getFile(),
        'line' => $exception->getLine()
      ]),
      'request' => json_encode($this->job),
    ]);
  }
}