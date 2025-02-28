<?php

return [
  'database' => [
    'host' => 'mysql',
    'username' => 'app',
    'password' => 'app',
    'database' => 'app',
    'charset' => 'utf8'
  ],
  'queue' => [
    'batch-size' => 1,
    'dry-run' => true
  ]
];