<?php

namespace SharedAdvertLibrary\Library;

use PDO;
use PDOException;

class Bootstrap {
  private PDO $pdo;
  private QueueService $queueService;
  private array $env = [];

  private string $path;

  public function __construct() {
    $this->loadEnvironmentVariables();
    $this->initDatabase();
    $this->initQueueService();
    $this->initAdvertService();
  }

  /**
   * @param string $path
   *
   * @return mixed|null
   */
  public function env(string $path) {
    $keys = explode('.', $path);
    $array = $this->env;
    foreach ($keys as $key) {
      if (!isset($array[$key])) {
        return null;
      }
      $array = $array[$key];
    }

    return $array;
  }

  public function getPDO(): PDO {
    return $this->pdo;
  }

  public function getQueueService(): QueueService {
    return $this->queueService;
  }

  private function loadEnvironmentVariables() {
    $this->env = require_once dirname(__FILE__) . '/../env.php';
  }

  private function initDatabase() {
    try {
      $dsn = sprintf("mysql:host=%s;dbname=%s;charset=%s", $this->env('database.host'), $this->env('database.database'),
        $this->env('database.charset'));
      $username = $this->env('database.username');
      $password = $this->env('database.password');
      $this->pdo = new PDO($dsn, $username, $password, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
        PDO::ATTR_EMULATE_PREPARES => false
      ]);
    } catch (PDOException $e) {
      die("Connection error: " . $e->getMessage());
    }
  }

  private function initQueueService() {
    require_once dirname(__FILE__) . '/queue-service.php';
    $this->queueService = new QueueService($this->pdo, $this->env('queue'));
  }

  private function initAdvertService() {
    require_once dirname(__FILE__) . '/advert-processor.php';
    require_once dirname(__FILE__) . '/queue-error-service.php';
    require_once dirname(__FILE__) . '/queue-log-service.php';
  }
}