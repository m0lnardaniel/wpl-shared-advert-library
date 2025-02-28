<?php

use SharedAdvertLibrary\Library\Bootstrap;

require_once dirname(__FILE__) . '/library/bootstrap.php';
return (new Bootstrap())->getQueueService();

