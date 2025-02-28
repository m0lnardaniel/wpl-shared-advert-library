# ************************************************************
# Sequel Ace SQL dump
# Version 20085
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 11.6.2-MariaDB-ubu2404)
# Database: app
# Generation Time: 2025-02-28 08:06:39 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table advert
# ------------------------------------------------------------

DROP TABLE IF EXISTS `advert`;

CREATE TABLE `advert` (
  `advert_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group` enum('basic','job','car','property') DEFAULT 'job',
  `remote_site` varchar(255) DEFAULT NULL,
  `remote_id` int(10) unsigned DEFAULT NULL,
  `site_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `subcategory_id` int(10) unsigned DEFAULT NULL,
  `city_id` int(10) unsigned DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `lifetime` smallint(5) unsigned NOT NULL DEFAULT 30,
  `price` float(20,2) unsigned DEFAULT 0.00,
  `url` varchar(250) DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `friendly_id` varchar(250) DEFAULT NULL,
  `text` text NOT NULL,
  `name` varchar(250) NOT NULL,
  `email` varchar(250) NOT NULL,
  `hidden_email` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `phone` varchar(100) DEFAULT NULL,
  `images` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `expired_at` date DEFAULT NULL,
  `extra1_expired_at` datetime DEFAULT NULL,
  `extra2_expired_at` datetime DEFAULT NULL,
  `extra3_expired_at` datetime DEFAULT NULL,
  `extra4` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `status` enum('inprogress','allowed','denied') NOT NULL DEFAULT 'inprogress',
  PRIMARY KEY (`advert_id`),
  UNIQUE KEY `remote` (`remote_site`,`remote_id`),
  KEY `subcategory_id` (`subcategory_id`),
  KEY `city_id` (`city_id`),
  KEY `title` (`title`),
  KEY `name` (`name`),
  KEY `active` (`active`),
  KEY `user_id` (`user_id`),
  KEY `expired` (`expired_at`),
  KEY `friendly_id` (`friendly_id`),
  KEY `site_id` (`site_id`),
  KEY `extra1_expired_at` (`extra1_expired_at`),
  KEY `extra2_expired_at` (`extra2_expired_at`),
  KEY `extra3_expired_at` (`extra3_expired_at`),
  KEY `extra4` (`extra4`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

LOCK TABLES `advert` WRITE;
/*!40000 ALTER TABLE `advert` DISABLE KEYS */;

INSERT INTO `advert` (`advert_id`, `group`, `remote_site`, `remote_id`, `site_id`, `user_id`, `subcategory_id`, `city_id`, `address`, `zip`, `lifetime`, `price`, `url`, `title`, `friendly_id`, `text`, `name`, `email`, `hidden_email`, `phone`, `images`, `created_at`, `updated_at`, `expired_at`, `extra1_expired_at`, `extra2_expired_at`, `extra3_expired_at`, `extra4`, `active`, `status`)
VALUES
	(31,'property','webhirdetesek.hu',108,NULL,NULL,11702,3148,'Zrinyi u. 22','9000',90,22000000.00,'https://google.com','Lorem ipsum name','lorem_ipsum_name','lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum ','Pest Buda','webesreklam@gmail.com',0,'221133','[{\"tmb\":\"https://webhirdetesek.hu/upload/images/20241204/00464_01_tmb.jpg\",\"large\":\"https://webhirdetesek.hu/upload/images/20241204/00464_01_large.jpg\"}]','2025-02-26 14:05:39','2025-02-26 14:09:26','2025-05-27',NULL,NULL,NULL,0,1,'inprogress');

/*!40000 ALTER TABLE `advert` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table car
# ------------------------------------------------------------

DROP TABLE IF EXISTS `car`;

CREATE TABLE `car` (
  `car_id` int(10) unsigned NOT NULL,
  `advert_id` int(10) unsigned DEFAULT NULL,
  `type` enum('buy','sell') DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `fuel_id` int(10) unsigned DEFAULT NULL,
  `construction_id` int(10) unsigned DEFAULT NULL,
  `document_id` int(10) unsigned DEFAULT NULL,
  `valid_id` int(10) unsigned DEFAULT NULL,
  `state_id` int(10) unsigned DEFAULT NULL,
  `mileage` int(10) unsigned DEFAULT NULL,
  `make` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `year` varchar(50) DEFAULT NULL,
  `cm3` int(10) unsigned DEFAULT NULL,
  `performance` int(10) unsigned DEFAULT NULL,
  `gearshift` varchar(100) DEFAULT NULL,
  `color` varchar(100) DEFAULT NULL,
  `doors` int(10) unsigned DEFAULT NULL,
  `places` int(10) unsigned DEFAULT NULL,
  `technical_examination` varchar(50) DEFAULT NULL,
  `description1` text DEFAULT NULL,
  `description2` text DEFAULT NULL,
  `description3` text DEFAULT NULL,
  `description4` text DEFAULT NULL,
  PRIMARY KEY (`car_id`),
  UNIQUE KEY `advert_id` (`advert_id`),
  KEY `type` (`type`),
  KEY `comfort_level_id` (`fuel_id`),
  KEY `construction_id` (`construction_id`),
  KEY `floor_id` (`document_id`),
  KEY `furnishing_id` (`valid_id`),
  KEY `state_id` (`state_id`),
  KEY `category_id` (`category_id`),
  KEY `mileage` (`mileage`),
  KEY `make` (`make`),
  KEY `model` (`model`),
  KEY `year` (`year`),
  KEY `cm3` (`cm3`),
  KEY `performance` (`performance`),
  KEY `gearshift` (`gearshift`),
  KEY `color` (`color`),
  KEY `doors` (`doors`),
  KEY `places` (`places`),
  KEY `technical_examination` (`technical_examination`),
  CONSTRAINT `car_ibfk_1` FOREIGN KEY (`advert_id`) REFERENCES `advert` (`advert_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;



# Dump of table car_features
# ------------------------------------------------------------

DROP TABLE IF EXISTS `car_features`;

CREATE TABLE `car_features` (
  `car_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`car_id`,`feature_id`),
  KEY `car_features_ibfk_2` (`feature_id`),
  CONSTRAINT `car_features_ibfk_1` FOREIGN KEY (`car_id`) REFERENCES `car` (`car_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;



# Dump of table collections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `collections`;

CREATE TABLE `collections` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `active` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;

INSERT INTO `collections` (`id`, `name`, `active`, `created_at`, `updated_at`)
VALUES
	(1,'Alapértelmezett hirdetési oldalak',1,'2025-02-27 12:46:05','2025-02-27 13:19:55'),
	(2,'Teszt',1,'2025-02-27 13:25:38','2025-02-27 13:31:38');

/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table job
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job`;

CREATE TABLE `job` (
  `job_id` int(10) unsigned NOT NULL,
  `advert_id` int(10) unsigned DEFAULT NULL,
  `type` enum('job-search','job-offer') DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `nature_id` int(10) unsigned DEFAULT NULL,
  `education_id` int(10) unsigned DEFAULT NULL,
  `experience_id` int(10) unsigned DEFAULT NULL,
  `language_id` int(10) unsigned DEFAULT NULL,
  `price_payment_claim` tinyint(3) unsigned DEFAULT NULL,
  `price_performance` tinyint(3) unsigned DEFAULT NULL,
  PRIMARY KEY (`job_id`),
  UNIQUE KEY `advert_id` (`advert_id`),
  KEY `type` (`type`),
  KEY `nature_id` (`nature_id`),
  KEY `education_id` (`education_id`),
  KEY `experience_id` (`experience_id`),
  KEY `language_id` (`language_id`),
  KEY `location_id` (`location_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `job_ibfk_1` FOREIGN KEY (`advert_id`) REFERENCES `advert` (`advert_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;



# Dump of table job_features
# ------------------------------------------------------------

DROP TABLE IF EXISTS `job_features`;

CREATE TABLE `job_features` (
  `job_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`job_id`,`feature_id`),
  KEY `property_features_ibfk_2` (`feature_id`),
  CONSTRAINT `job_features_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;



# Dump of table logs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `logs`;

CREATE TABLE `logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) DEFAULT NULL,
  `payload` text DEFAULT NULL,
  `request` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_at` (`created_at`),
  KEY `message` (`message`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;



# Dump of table property
# ------------------------------------------------------------

DROP TABLE IF EXISTS `property`;

CREATE TABLE `property` (
  `property_id` int(10) unsigned NOT NULL,
  `advert_id` int(10) unsigned DEFAULT NULL,
  `type` enum('for-sale','for-rent') DEFAULT NULL,
  `category_id` int(10) unsigned DEFAULT NULL,
  `age_id` int(10) unsigned DEFAULT NULL,
  `comfort_level_id` int(10) unsigned DEFAULT NULL,
  `construction_id` int(10) unsigned DEFAULT NULL,
  `floor_id` int(10) unsigned DEFAULT NULL,
  `furnishing_id` int(10) unsigned DEFAULT NULL,
  `heating_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `orientation_id` int(10) unsigned DEFAULT NULL,
  `ownership_id` int(10) unsigned DEFAULT NULL,
  `state_id` int(10) unsigned DEFAULT NULL,
  `size` int(10) unsigned DEFAULT NULL,
  `bedrooms` int(10) unsigned DEFAULT NULL,
  `half_bedrooms` int(10) unsigned DEFAULT NULL,
  `livingrooms` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`property_id`),
  UNIQUE KEY `advert_id` (`advert_id`),
  KEY `type` (`type`),
  KEY `age_id` (`age_id`),
  KEY `comfort_level_id` (`comfort_level_id`),
  KEY `construction_id` (`construction_id`),
  KEY `floor_id` (`floor_id`),
  KEY `furnishing_id` (`furnishing_id`),
  KEY `heating_id` (`heating_id`),
  KEY `location_id` (`location_id`),
  KEY `orientation_id` (`orientation_id`),
  KEY `ownership_id` (`ownership_id`),
  KEY `state_id` (`state_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `property_ibfk_1` FOREIGN KEY (`advert_id`) REFERENCES `advert` (`advert_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

LOCK TABLES `property` WRITE;
/*!40000 ALTER TABLE `property` DISABLE KEYS */;

INSERT INTO `property` (`property_id`, `advert_id`, `type`, `category_id`, `age_id`, `comfort_level_id`, `construction_id`, `floor_id`, `furnishing_id`, `heating_id`, `location_id`, `orientation_id`, `ownership_id`, `state_id`, `size`, `bedrooms`, `half_bedrooms`, `livingrooms`)
VALUES
	(31,31,'for-sale',2,3,3,3,3,2,4,2,2,2,3,120,3,1,2);

/*!40000 ALTER TABLE `property` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table property_features
# ------------------------------------------------------------

DROP TABLE IF EXISTS `property_features`;

CREATE TABLE `property_features` (
  `property_id` int(10) unsigned NOT NULL,
  `feature_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`property_id`,`feature_id`),
  KEY `property_features_ibfk_2` (`feature_id`),
  CONSTRAINT `property_features_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_hungarian_ci;

LOCK TABLES `property_features` WRITE;
/*!40000 ALTER TABLE `property_features` DISABLE KEYS */;

INSERT INTO `property_features` (`property_id`, `feature_id`)
VALUES
	(31,2),
	(31,3),
	(31,5),
	(31,6);

/*!40000 ALTER TABLE `property_features` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table queue_jobs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `queue_jobs`;

CREATE TABLE `queue_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `site_id` varchar(100) NOT NULL,
  `advert_id` int(10) unsigned NOT NULL,
  `action` varchar(20) NOT NULL,
  `data` text NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `advert_id` (`advert_id`),
  KEY `action` (`action`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

LOCK TABLES `queue_jobs` WRITE;
/*!40000 ALTER TABLE `queue_jobs` DISABLE KEYS */;

INSERT INTO `queue_jobs` (`id`, `site_id`, `advert_id`, `action`, `data`, `created_at`)
VALUES
	(2,'webhirdetesek.hu',108,'delete','NULL','2025-02-26 15:54:54'),
	(3,'webhirdetesek.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 16:04:39'),
	(4,'webhirdetesek.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 17:27:37'),
	(5,'ingatlanhirdetoje.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 17:31:13'),
	(6,'ingatlanhirdetoje.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 17:32:29'),
	(7,'ingatlanhirdetoje.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 18:10:18'),
	(8,'ingatlanhirdetoje.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 14:09:26\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"inprogress\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 18:11:22'),
	(9,'ingatlanhirdetoje.hu',107,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3149\",\"address\":\"Kossuth u 2\",\"zip\":\"2000\",\"lifetime\":\"90\",\"price\":\"15000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"webesreklam@gmail.com\",\"friendly_id\":\"webesreklamgmailcom\",\"text\":\"lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"222222\",\"images\":null,\"created_at\":\"2025-02-26 13:59:20\",\"updated_at\":\"2025-02-26 18:21:52\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"allowed\"},\"property\":null,\"property_features\":[]}','2025-02-26 18:21:53'),
	(10,'ingatlanhirdetoje.hu',108,'sync','{\"advert\":{\"group\":\"property\",\"subcategory_id\":null,\"city_id\":\"3148\",\"address\":\"Zrinyi u. 22\",\"zip\":\"9000\",\"lifetime\":\"90\",\"price\":\"22000000.00\",\"url\":\"https:\\/\\/google.com\",\"title\":\"Lorem ipsum name\",\"friendly_id\":\"lorem_ipsum_name\",\"text\":\"lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum lorem ipsum loremipsum \",\"name\":\"Pest Buda\",\"email\":\"webesreklam@gmail.com\",\"hidden_email\":\"0\",\"phone\":\"221133\",\"images\":\"[{\\\"tmb\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_tmb.jpg\\\",\\\"large\\\":\\\"https:\\/\\/webhirdetesek.hu\\/upload\\/images\\/20241204\\/00464_01_large.jpg\\\"}]\",\"created_at\":\"2025-02-26 14:05:39\",\"updated_at\":\"2025-02-26 18:22:12\",\"expired_at\":\"2025-05-27\",\"extra1_expired_at\":null,\"extra2_expired_at\":null,\"extra3_expired_at\":null,\"active\":\"1\",\"status\":\"allowed\"},\"property\":{\"type\":\"for-sale\",\"category_id\":\"2\",\"age_id\":\"3\",\"comfort_level_id\":\"3\",\"construction_id\":\"3\",\"floor_id\":\"3\",\"furnishing_id\":\"2\",\"heating_id\":\"4\",\"location_id\":\"2\",\"orientation_id\":\"2\",\"ownership_id\":\"2\",\"state_id\":\"3\",\"size\":\"120\",\"bedrooms\":\"3\",\"half_bedrooms\":\"1\",\"livingrooms\":\"2\"},\"property_features\":[\"2\",\"3\",\"5\",\"6\"]}','2025-02-26 18:22:12');

/*!40000 ALTER TABLE `queue_jobs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table site_collections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `site_collections`;

CREATE TABLE `site_collections` (
  `site_id` int(10) unsigned NOT NULL,
  `collection_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`site_id`,`collection_id`),
  KEY `collection_id` (`collection_id`),
  CONSTRAINT `site_collections_ibfk_1` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `site_collections_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

LOCK TABLES `site_collections` WRITE;
/*!40000 ALTER TABLE `site_collections` DISABLE KEYS */;

INSERT INTO `site_collections` (`site_id`, `collection_id`)
VALUES
	(1,1),
	(363,1);

/*!40000 ALTER TABLE `site_collections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `db_table` varchar(100) NOT NULL,
  `basic` tinyint(1) NOT NULL DEFAULT 0,
  `car` tinyint(1) NOT NULL DEFAULT 0,
  `job` tinyint(1) NOT NULL DEFAULT 0,
  `property` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) unsigned DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `basic` (`basic`),
  KEY `car` (`car`),
  KEY `job` (`job`),
  KEY `property` (`property`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `name`, `db_table`, `basic`, `car`, `job`, `property`, `active`, `created_at`, `updated_at`)
VALUES
	(1,'test','app',1,1,1,1,1,'2025-02-27 12:30:11','2025-02-27 14:41:10'),
	(2,'allashirdetoje.hu','rh39896_allashirdetoje',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(3,'allaskinalata.hu','rh39896_allaskinalata',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(4,'allaskinalatok.hu','rh39896_allaskinalatok',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(5,'allasokhirdetoje.hu','rh39896_allasokhirdetoje',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(6,'allasokorszagszerte.hu','rh39896_allasokorszagszerte',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(7,'allastkereskinal.hu','rh39896_allastkereskinal',0,0,1,0,1,'2025-02-27 12:30:11','2025-02-27 14:38:33'),
	(8,'abadszalokiapro.hu','rh39896_abadszalokiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(9,'abonyihirdeto.hu','rh39896_abonyihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(10,'acshirdetoje.hu','rh39896_acshirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(11,'adonyhirdetoje.hu','rh39896_adonyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(12,'ajkaiapro.hu','rh39896_ajkaiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(13,'albertirsaihirdeto.hu','rh39896_albertirsaihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(14,'algyohirdetoje.hu','rh39896_algyohirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(15,'angyalfoldhirdetoje.hu','rh39896_angyalfoldhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(16,'aproajanlo.hu','rh39896_aproajanlo',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(17,'aprohirdetoje.hu','rh39896_aprohirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(18,'asotthalomhirdetoje.hu','rh39896_asotthalomhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(19,'aszodhirdetoje.hu','rh39896_aszodhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(20,'aszodihirdeto.hu','rh39896_aszodihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(21,'babolnahirdetoje.hu','rh39896_babolnahirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(22,'bacsalmashirdetoje.hu','rh39896_bacsalmashirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(23,'bacskiskuniapro.hu','rh39896_bacskiskuniapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(24,'badacsonytomajiapro.hu','rh39896_badacsonytomajiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(25,'bajahirdetoje.hu','rh39896_bajahirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(26,'balassagyarmatiapro.hu','rh39896_balassagyarmatiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(27,'balatonalmadihirdetoje.hu','rh39896_balatonalmadihirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(28,'balatonboglarhirdetoje.hu','rh39896_balatonboglarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(29,'balatonfoldvariapro.hu','rh39896_balatonfoldvariapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(30,'balatonfuredhirdetoje.hu','rh39896_balatonfuredhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(31,'balatonfuzfohirdetoje.hu','rh39896_balatonfuzfohirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(32,'balatonkeneseihirdeto.hu','rh39896_balatonkeneseihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(33,'balatonlellehirdetoje.hu','rh39896_balatonlellehirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(34,'balmazujvaroshirdetoje.hu','rh39896_balmazujvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(35,'baranyaiapro.hu','rh39896_baranyaiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(36,'barcshirdetoje.hu','rh39896_barcshirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(37,'batonyterenyeihirdeto.hu','rh39896_batonyterenyeihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(38,'battonyaihirdeto.hu','rh39896_battonyaihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(39,'bekescsabahirdetoje.hu','rh39896_bekescsabahirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(40,'bekeshirdetoje.hu','rh39896_bekeshirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(41,'bekesmegyeiapro.hu','rh39896_bekesmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(42,'belapatfalvaiapro.hu','rh39896_belapatfalvaiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(43,'beledhirdetoje.hu','rh39896_beledhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(44,'berettyoujfaluiapro.hu','rh39896_berettyoujfaluiapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(45,'berhidahirdetoje.hu','rh39896_berhidahirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(46,'biatorbagyhirdetoje.hu','rh39896_biatorbagyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(47,'bicskeihirdeto.hu','rh39896_bicskeihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(48,'bodajkhirdetoje.hu','rh39896_bodajkhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(49,'bolyhirdetoje.hu','rh39896_bolyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(50,'bonyhadhirdetoje.hu','rh39896_bonyhadhirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(51,'borsodabaujapro.hu','rh39896_borsodabaujapro',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(52,'bp12kerulethirdetoje.hu','rh39896_bp12kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(53,'bp15kerulethirdetoje.hu','rh39896_bp15kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(54,'bp15keruletihirdeto.hu','rh39896_bp15keruletihirdeto',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(55,'bp16kerulethirdetoje.hu','rh39896_bp16kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(56,'bp18kerulethirdetoje.hu','rh39896_bp18kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(57,'bp1kerulethirdetoje.hu','rh39896_bp1kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(58,'bp2kerulethirdetoje.hu','rh39896_bp2kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:19','2025-02-27 14:38:33'),
	(59,'bp3kerulethirdetoje.hu','rh39896_bp3kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(60,'bp5kerulethirdetoje.hu','rh39896_bp5kerulethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(61,'bp6keruletihirdeto.hu','rh39896_bp6keruletihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(62,'budafokhirdetoje.hu','rh39896_budafokhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(63,'budakalaszhirdetoje.hu','rh39896_budakalaszhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(64,'budakeszihirdetoje.hu','rh39896_budakeszihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(65,'budaorshirdetoje.hu','rh39896_budaorshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(66,'budapesthirdetoje.hu','rh39896_budapesthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(67,'budapestikereskinal.hu','rh39896_budapestikereskinal',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(68,'bukhirdetoje.hu','rh39896_bukhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(69,'cegledhirdetoje.hu','rh39896_cegledhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(70,'celldomolkihirdeto.hu','rh39896_celldomolkihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(71,'csanadpalotaiapro.hu','rh39896_csanadpalotaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(72,'csepelhirdetoje.hu','rh39896_csepelhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(73,'csepregihirdeto.hu','rh39896_csepregihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(74,'csomorhirdetoje.hu','rh39896_csomorhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(75,'csongradhirdetoje.hu','rh39896_csongradhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(76,'csongradmegyeiapro.hu','rh39896_csongradmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(77,'csopakhirdetoje.hu','rh39896_csopakhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(78,'csornahirdetoje.hu','rh39896_csornahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(79,'csurgohirdetoje.hu','rh39896_csurgohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(80,'dabashirdetoje.hu','rh39896_dabashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(81,'debrecenhirdetoje.hu','rh39896_debrecenhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(82,'debreceniapro.hu','rh39896_debreceniapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(83,'delegyhazahirdetoje.hu','rh39896_delegyhazahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(84,'derecskehirdetoje.hu','rh39896_derecskehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(85,'devecserhirdetoje.hu','rh39896_devecserhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(86,'diosdhirdetoje.hu','rh39896_diosdhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(87,'diosdihirdeto.hu','rh39896_diosdihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(88,'domaszekhirdetoje.hu','rh39896_domaszekhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(89,'dombovarhirdetoje.hu','rh39896_dombovarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(90,'doroghirdetoje.hu','rh39896_doroghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(91,'dunafoldvarihirdeto.hu','rh39896_dunafoldvarihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(92,'dunaharasztihirdetoje.hu','rh39896_dunaharasztihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(93,'dunakeszihirdetoje.hu','rh39896_dunakeszihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(94,'dunaujvaroshirdetoje.hu','rh39896_dunaujvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(95,'dunavarsanyiapro.hu','rh39896_dunavarsanyiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(96,'edelenyhirdetoje.hu','rh39896_edelenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(97,'egerhirdetoje.hu','rh39896_egerhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(98,'egriaprohirdeto.hu','rh39896_egriaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(99,'enyinghirdetoje.hu','rh39896_enyinghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(100,'ercsihirdetoje.hu','rh39896_ercsihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(101,'erdhirdetoje.hu','rh39896_erdhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(102,'erdiapro.hu','rh39896_erdiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(103,'erdokerteshirdetoje.hu','rh39896_erdokerteshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(104,'erzsebetvaroshirdetoje.hu','rh39896_erzsebetvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(105,'erzsebetvarosiapro.hu','rh39896_erzsebetvarosiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(106,'esztergomhirdetoje.hu','rh39896_esztergomhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(107,'fejermegyeiapro.hu','rh39896_fejermegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(108,'ferencvaroshirdetoje.hu','rh39896_ferencvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(109,'fertodhirdetoje.hu','rh39896_fertodhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(110,'fertoszentmiklosiapro.hu','rh39896_fertoszentmiklosiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(111,'fonyodhirdetoje.hu','rh39896_fonyodhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(112,'fonyodihirdeto.hu','rh39896_fonyodihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(113,'fothirdetoje.hu','rh39896_fothirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(114,'fuzesabonyihirdeto.hu','rh39896_fuzesabonyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(115,'gardonyhirdetoje.hu','rh39896_gardonyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(116,'godhirdetoje.hu','rh39896_godhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(117,'godollohirdetoje.hu','rh39896_godollohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(118,'gyalhirdetoje.hu','rh39896_gyalhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(119,'gyenesdiasiapro.hu','rh39896_gyenesdiasiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(120,'gyogyitoelelmiszerek.hu','rh39896_gyogyitoelelmiszerek',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(121,'gyomrohirdetoje.hu','rh39896_gyomrohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(122,'gyongyoshirdetoje.hu','rh39896_gyongyoshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(123,'gyongyospataihirdeto.hu','rh39896_gyongyospataihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(124,'gyorhirdetoje.hu','rh39896_gyorhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(125,'gyoriapro.hu','rh39896_gyoriapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(126,'gyormosoniapro.hu','rh39896_gyormosoniapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(127,'gyulahirdetoje.hu','rh39896_gyulahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(128,'hajdubihariapro.hu','rh39896_hajdubihariapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(129,'hajduboszormenyihirdeto.hu','rh39896_hajduboszormenyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(130,'hajdudorogihirdeto.hu','rh39896_hajdudorogihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(131,'hajduhadhazihirdeto.hu','rh39896_hajduhadhazihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(132,'hajdunanashirdetoje.hu','rh39896_hajdunanashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(133,'hajdusamsonihirdeto.hu','rh39896_hajdusamsonihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(134,'hajduszoboszloiapro.hu','rh39896_hajduszoboszloiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(135,'hajoshirdetoje.hu','rh39896_hajoshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(136,'halasztelekhirdetoje.hu','rh39896_halasztelekhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(137,'harkanyhirdetoje.hu','rh39896_harkanyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(138,'harkanyihirdeto.hu','rh39896_harkanyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(139,'hatvanhirdetoje.hu','rh39896_hatvanhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(140,'hegyeshalomihirdeto.hu','rh39896_hegyeshalomihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(141,'helveciahirdetoje.hu','rh39896_helveciahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(142,'herendhirdetoje.hu','rh39896_herendhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(143,'heveshirdetoje.hu','rh39896_heveshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(144,'hevesmegyeiapro.hu','rh39896_hevesmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(145,'hevizhirdetoje.hu','rh39896_hevizhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(146,'hirdess1evre.hu','rh39896_hirdess1evre',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(147,'hirdetoje.hu','rh39896_hirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(148,'hodmezovasarhelyiapro.hu','rh39896_hodmezovasarhelyiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(149,'hodmezovasarhelyihirdeto.hu','rh39896_hodmezovasarhelyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(150,'horthirdetoje.hu','rh39896_horthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(151,'isaszeghirdetoje.hu','rh39896_isaszeghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(152,'izsakhirdetoje.hu','rh39896_izsakhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(153,'janoshalmaiapro.hu','rh39896_janoshalmaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(154,'janoshazahirdetoje.hu','rh39896_janoshazahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(155,'janossomorjaiapro.hu','rh39896_janossomorjaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(156,'jaszapatihirdeto.hu','rh39896_jaszapatihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(157,'jaszarokszallasiapro.hu','rh39896_jaszarokszallasiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(158,'jaszberenyhirdetoje.hu','rh39896_jaszberenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(159,'jasznagykuniapro.hu','rh39896_jasznagykuniapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(160,'jozsefvaroshirdetoje.hu','rh39896_jozsefvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(161,'jozsefvarosihirdeto.hu','rh39896_jozsefvarosihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(162,'kalhirdetoje.hu','rh39896_kalhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(163,'kalocsahirdetoje.hu','rh39896_kalocsahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(164,'kaposvarhirdetoje.hu','rh39896_kaposvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(165,'kapuvarhirdetoje.hu','rh39896_kapuvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(166,'karcaghirdetoje.hu','rh39896_karcaghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(167,'kazincbarcikahirdetoje.hu','rh39896_kazincbarcikahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(168,'kecelhirdetoje.hu','rh39896_kecelhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(169,'kecskemethirdetoje.hu','rh39896_kecskemethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(170,'kecskemetiapro.hu','rh39896_kecskemetiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(171,'kerekegyhazaiapro.hu','rh39896_kerekegyhazaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(172,'kerepeshirdetoje.hu','rh39896_kerepeshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(173,'keszthelyhirdetoje.hu','rh39896_keszthelyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(174,'kisberhirdetoje.hu','rh39896_kisberhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(175,'kiskorehirdetoje.hu','rh39896_kiskorehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(176,'kiskoroshirdetoje.hu','rh39896_kiskoroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(177,'kiskunfelegyhaziapro.hu','rh39896_kiskunfelegyhaziapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(178,'kiskunhalashirdetoje.hu','rh39896_kiskunhalashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(179,'kiskunlachazaiapro.hu','rh39896_kiskunlachazaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(180,'kiskunmajsahirdetoje.hu','rh39896_kiskunmajsahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(181,'kispesthirdetoje.hu','rh39896_kispesthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(182,'kistarcsahirdetoje.hu','rh39896_kistarcsahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(183,'kistelekhirdetoje.hu','rh39896_kistelekhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(184,'kisujszallasihirdeto.hu','rh39896_kisujszallasihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(185,'kisvardahirdetoje.hu','rh39896_kisvardahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(186,'kobanyahirdetoje.hu','rh39896_kobanyahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(187,'kobanyaihirdeto.hu','rh39896_kobanyaihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(188,'komaromhirdetoje.hu','rh39896_komaromhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(189,'komarommegyeiapro.hu','rh39896_komarommegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(190,'komlohirdetoje.hu','rh39896_komlohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(191,'kormendhirdetoje.hu','rh39896_kormendhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(192,'koszeghirdetoje.hu','rh39896_koszeghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(193,'kozarmislenyihirdeto.hu','rh39896_kozarmislenyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(194,'kunhegyeshirdetoje.hu','rh39896_kunhegyeshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(195,'kunszentmiklosiapro.hu','rh39896_kunszentmiklosiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(196,'labatlanhirdetoje.hu','rh39896_labatlanhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(197,'lajosmizsehirdetoje.hu','rh39896_lajosmizsehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(198,'lakitelekhirdetoje.hu','rh39896_lakitelekhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(199,'lebenyhirdetoje.hu','rh39896_lebenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(200,'lentihirdetoje.hu','rh39896_lentihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(201,'letenyehirdetoje.hu','rh39896_letenyehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(202,'lorincihirdetoje.hu','rh39896_lorincihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(203,'maglodhirdetoje.hu','rh39896_maglodhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(204,'makohirdetoje.hu','rh39896_makohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(205,'marcalihirdetoje.hu','rh39896_marcalihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(206,'martfuhirdetoje.hu','rh39896_martfuhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(207,'martonvasarhirdetoje.hu','rh39896_martonvasarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(208,'mateszalkahirdetoje.hu','rh39896_mateszalkahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(209,'melykuthirdetoje.hu','rh39896_melykuthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(210,'mezohegyesihirdeto.hu','rh39896_mezohegyesihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(211,'mezokovesdhirdetoje.hu','rh39896_mezokovesdhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(212,'mezoturhirdetoje.hu','rh39896_mezoturhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(213,'mindszenthirdetoje.hu','rh39896_mindszenthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(214,'miskolchirdetoje.hu','rh39896_miskolchirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(215,'miskolciaprohirdeto.hu','rh39896_miskolciaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(216,'mogyorodihirdeto.hu','rh39896_mogyorodihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(217,'mohacshirdetoje.hu','rh39896_mohacshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(218,'mohacsiaprohirdeto.hu','rh39896_mohacsiaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(219,'monorhirdetoje.hu','rh39896_monorhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(220,'morahalomhirdetoje.hu','rh39896_morahalomhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(221,'morhirdetoje.hu','rh39896_morhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(222,'mosonmagyarovarihirdeto.hu','rh39896_mosonmagyarovarihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(223,'nadudvarhirdetoje.hu','rh39896_nadudvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(224,'nagyatadhirdetoje.hu','rh39896_nagyatadhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(225,'nagykallohirdetoje.hu','rh39896_nagykallohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(226,'nagykanizsahirdetoje.hu','rh39896_nagykanizsahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(227,'nagykatahirdetoje.hu','rh39896_nagykatahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(228,'nagykoroshirdetoje.hu','rh39896_nagykoroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(229,'nagykovacsihirdeto.hu','rh39896_nagykovacsihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(230,'nagymarosihirdeto.hu','rh39896_nagymarosihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(231,'nagyredeihirdeto.hu','rh39896_nagyredeihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(232,'nogradmegyeiapro.hu','rh39896_nogradmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(233,'nyergesujfaluhirdetoje.hu','rh39896_nyergesujfaluhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(234,'nyirbatorihirdeto.hu','rh39896_nyirbatorihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(235,'nyiregyhazahirdetoje.hu','rh39896_nyiregyhazahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(236,'nyiregyhaziapro.hu','rh39896_nyiregyhaziapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(237,'ocsahirdetoje.hu','rh39896_ocsahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(238,'onlinehirdetoje.hu','rh39896_onlinehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(239,'orbottyanhirdetoje.hu','rh39896_orbottyanhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(240,'orbottyanihirdeto.hu','rh39896_orbottyanihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(241,'oriszentpeterihirdeto.hu','rh39896_oriszentpeterihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(242,'orkenyhirdetoje.hu','rh39896_orkenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(243,'oroshazahirdetoje.hu','rh39896_oroshazahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(244,'oroszlanyhirdetoje.hu','rh39896_oroszlanyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(245,'ozdiapro.hu','rh39896_ozdiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(246,'pakshirdetoje.hu','rh39896_pakshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(247,'pannonhalmahirdetoje.hu','rh39896_pannonhalmahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(248,'papahirdetoje.hu','rh39896_papahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(249,'pasztohirdetoje.hu','rh39896_pasztohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(250,'pecelhirdetoje.hu','rh39896_pecelhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(251,'pecshirdetoje.hu','rh39896_pecshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(252,'pecsiaprohirdeto.hu','rh39896_pecsiaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(253,'pecsvaradhirdetoje.hu','rh39896_pecsvaradhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(254,'pesterzsebethirdetoje.hu','rh39896_pesterzsebethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(255,'pestmegyeiapro.hu','rh39896_pestmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(256,'petervasarahirdetoje.hu','rh39896_petervasarahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(257,'petfurdoihirdeto.hu','rh39896_petfurdoihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(258,'piliscsabahirdetoje.hu','rh39896_piliscsabahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(259,'pilishirdetoje.hu','rh39896_pilishirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(260,'pilisvorosvariapro.hu','rh39896_pilisvorosvariapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(261,'polgardihirdetoje.hu','rh39896_polgardihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(262,'pomazhirdetoje.hu','rh39896_pomazhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(263,'puspokladanyihirdeto.hu','rh39896_puspokladanyihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(264,'pusztaszabolcsiapro.hu','rh39896_pusztaszabolcsiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(265,'putnokhirdetoje.hu','rh39896_putnokhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(266,'racalmashirdetoje.hu','rh39896_racalmashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(267,'rackevehirdetoje.hu','rh39896_rackevehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(268,'rakosmentehirdetoje.hu','rh39896_rakosmentehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(269,'rakosmenteiapro.hu','rh39896_rakosmenteiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(270,'retsaghirdetoje.hu','rh39896_retsaghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(271,'salgotarjanhirdetoje.hu','rh39896_salgotarjanhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(272,'salgotarjaniapro.hu','rh39896_salgotarjaniapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(273,'sandorfalvaiapro.hu','rh39896_sandorfalvaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(274,'sarbogardhirdetoje.hu','rh39896_sarbogardhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(275,'sarkadhirdetoje.hu','rh39896_sarkadhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(276,'sarospatakihirdeto.hu','rh39896_sarospatakihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(277,'sarvarhirdetoje.hu','rh39896_sarvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(278,'satoraljaujhelyiapro.hu','rh39896_satoraljaujhelyiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(279,'sikloshirdetoje.hu','rh39896_sikloshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(280,'siofokhirdetoje.hu','rh39896_siofokhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(281,'soltvadkertiapro.hu','rh39896_soltvadkertiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(282,'solymarhirdetoje.hu','rh39896_solymarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(283,'somogyiapro.hu','rh39896_somogyiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(284,'sopronhirdetoje.hu','rh39896_sopronhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(285,'soproniaprohirdeto.hu','rh39896_soproniaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(286,'soroksarhirdetoje.hu','rh39896_soroksarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(287,'soskuthirdetoje.hu','rh39896_soskuthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(288,'sulysaphirdetoje.hu','rh39896_sulysaphirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(289,'sumeghirdetoje.hu','rh39896_sumeghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(290,'szabadbattyaniapro.hu','rh39896_szabadbattyaniapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(291,'szabadszallasiapro.hu','rh39896_szabadszallasiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(292,'szabolcsmegyeiapro.hu','rh39896_szabolcsmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(293,'szarvashirdetoje.hu','rh39896_szarvashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(294,'szazhalombattaiapro.hu','rh39896_szazhalombattaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(295,'szecsenyhirdetoje.hu','rh39896_szecsenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(296,'szegedhirdetoje.hu','rh39896_szegedhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(297,'szegedvilaga.hu','rh39896_szegedvilaga',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(298,'szeghalomhirdetoje.hu','rh39896_szeghalomhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(299,'szegvarhirdetoje.hu','rh39896_szegvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(300,'szekesfehervariapro.hu','rh39896_szekesfehervariapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(301,'szekesfehervariaprohirdeto.hu','rh39896_szekesfehervariaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(302,'szekszardhirdetoje.hu','rh39896_szekszardhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(303,'szentendrehirdetoje.hu','rh39896_szentendrehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(304,'szenteshirdetoje.hu','rh39896_szenteshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(305,'szentgotthardiapro.hu','rh39896_szentgotthardiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(306,'szentlorinchirdetoje.hu','rh39896_szentlorinchirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(307,'szerencshirdetoje.hu','rh39896_szerencshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(308,'szigethalomhirdetoje.hu','rh39896_szigethalomhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(309,'szigetszentmiklosiapro.hu','rh39896_szigetszentmiklosiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(310,'szigetvarihirdeto.hu','rh39896_szigetvarihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(311,'szobhirdetoje.hu','rh39896_szobhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(312,'szolnokhirdetoje.hu','rh39896_szolnokhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(313,'szolnokiaprohirdeto.hu','rh39896_szolnokiaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(314,'szombathelyiapro.hu','rh39896_szombathelyiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(315,'tamasihirdetoje.hu','rh39896_tamasihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(316,'tapolcahirdetoje.hu','rh39896_tapolcahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(317,'tatabanyahirdetoje.hu','rh39896_tatabanyahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(318,'tatabanyaiapro.hu','rh39896_tatabanyaiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(319,'tatahirdetoje.hu','rh39896_tatahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(320,'tathirdetoje.hu','rh39896_tathirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(321,'teglashirdetoje.hu','rh39896_teglashirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(322,'terezvaroshirdetoje.hu','rh39896_terezvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(323,'tethirdetoje.hu','rh39896_tethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(324,'tiszacsegeiapro.hu','rh39896_tiszacsegeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(325,'tiszafoldvarhirdetoje.hu','rh39896_tiszafoldvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(326,'tiszafuredhirdetoje.hu','rh39896_tiszafuredhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(327,'tiszakecskehirdetoje.hu','rh39896_tiszakecskehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(328,'tiszaujvaroshirdetoje.hu','rh39896_tiszaujvaroshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(329,'tiszavasvarihirdeto.hu','rh39896_tiszavasvarihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(330,'tokajihirdeto.hu','rh39896_tokajihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(331,'tokolhirdetoje.hu','rh39896_tokolhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(332,'tolnahirdetoje.hu','rh39896_tolnahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(333,'tolnamegyeiapro.hu','rh39896_tolnamegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(334,'tompahirdetoje.hu','rh39896_tompahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(335,'torokbalinthirdetoje.hu','rh39896_torokbalinthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(336,'torokbalintihirdetoje.hu','rh39896_torokbalintihirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(337,'torokszentmiklosiapro.hu','rh39896_torokszentmiklosiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(338,'totkomloshirdetoje.hu','rh39896_totkomloshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(339,'turkevehirdetoje.hu','rh39896_turkevehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(340,'ujbudahirdetoje.hu','rh39896_ujbudahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(341,'ujbudaihirdeto.hu','rh39896_ujbudaihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(342,'ujfehertohirdetoje.hu','rh39896_ujfehertohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(343,'ujpesthirdetoje.hu','rh39896_ujpesthirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(344,'ujpestihirdeto.hu','rh39896_ujpestihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(345,'ullohirdetoje.hu','rh39896_ullohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(346,'vachirdetoje.hu','rh39896_vachirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(347,'vamospercshirdetoje.hu','rh39896_vamospercshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(348,'varpalotahirdetoje.hu','rh39896_varpalotahirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(349,'vasarosnamenyhirdetoje.hu','rh39896_vasarosnamenyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(350,'vasmegyeiapro.hu','rh39896_vasmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(351,'vasvarhirdetoje.hu','rh39896_vasvarhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(352,'vecseshirdetoje.hu','rh39896_vecseshirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(353,'vecsesiaprohirdeto.hu','rh39896_vecsesiaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(354,'velencehirdetoje.hu','rh39896_velencehirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(355,'veresegyhazhirdetoje.hu','rh39896_veresegyhazhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(356,'veresegyhaziapro.hu','rh39896_veresegyhaziapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(357,'verpelethirdetoje.hu','rh39896_verpelethirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(358,'veszpremhirdetoje.hu','rh39896_veszpremhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(359,'veszpremiaprohirdeto.hu','rh39896_veszpremiaprohirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(360,'veszpremmegyeiapro.hu','rh39896_veszpremmegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(361,'villanyhirdetoje.hu','rh39896_villanyhirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(362,'visegradihirdeto.hu','rh39896_visegradihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(363,'webhirdetesek.hu','rh39896_webhirdetesek',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(364,'zalaegerszeghirdetoje.hu','rh39896_zalaegerszeghirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(365,'zalakarosihirdeto.hu','rh39896_zalakarosihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(366,'zalakomariapro.hu','rh39896_zalakomariapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(367,'zalalovohirdetoje.hu','rh39896_zalalovohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(368,'zalamegyeiapro.hu','rh39896_zalamegyeiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(369,'zalaszentgrotiapro.hu','rh39896_zalaszentgrotiapro',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(370,'zamardihirdeto.hu','rh39896_zamardihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(371,'zirchirdetoje.hu','rh39896_zirchirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(372,'zuglohirdetoje.hu','rh39896_zuglohirdetoje',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(373,'zugloihirdeto.hu','rh39896_zugloihirdeto',1,1,1,1,1,'2025-02-27 12:33:20','2025-02-27 14:38:33'),
	(374,'hirdess300hirdetoportalon.hu','rh39896_hirdess300hirdetoportalon',1,1,1,1,1,'2025-02-27 12:44:02','2025-02-27 14:38:33'),
	(375,'hirdess300aprohirdeton.hu','rh39896_hirdess300aprohirdeton',1,1,1,1,1,'2025-02-27 12:44:02','2025-02-27 14:38:33'),
	(376,'hirdess300aprohirdetoben.hu','rh39896_hirdess300aprohirdetoben',1,1,1,1,1,'2025-02-27 12:44:02','2025-02-27 14:38:33');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
