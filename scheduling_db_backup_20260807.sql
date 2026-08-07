-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: scheduling_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `scheduling_db`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `scheduling_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `scheduling_db`;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_code` varchar(255) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `lecture_hours` int(11) NOT NULL DEFAULT 0,
  `lab_hours` int(11) NOT NULL DEFAULT 0,
  `units` int(11) NOT NULL DEFAULT 0,
  `course_category` enum('major','minor') NOT NULL,
  `room_type_required` enum('lecture','laboratory','field','online') NOT NULL DEFAULT 'lecture',
  `year_level` enum('1','2','3','4') NOT NULL,
  `semester` enum('1st','2nd','summer') NOT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_course_code_department_id_unique` (`course_code`,`department_id`),
  KEY `courses_department_status_index` (`department_id`,`status`),
  KEY `courses_category_status_index` (`course_category`,`status`),
  CONSTRAINT `courses_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'IT 101','Introduction To Computing',2,1,3,'major','laboratory','1','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(2,'IT 102','Computer Programming 1',2,1,3,'major','laboratory','1','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(3,'IT 103','Integrated Applications Software',2,1,3,'major','laboratory','1','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(4,'IT 104','Information Technology Fundamentals',3,0,3,'major','lecture','1','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:48:16'),(5,'ROTC/CWTS 101','Basic Army Science/CWTS',3,0,3,'minor','lecture','1','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:47:54'),(6,'PATH FIT 1','Movement Competency Training',2,0,2,'minor','lecture','1','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(7,'IT 105','Computer Programming 2',2,1,3,'major','laboratory','1','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 03:46:15'),(8,'IT 106','Digital Logic Design',2,1,3,'major','laboratory','1','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 03:46:27'),(9,'IT 107','Application Development & Emerging Technologies',2,1,3,'major','laboratory','1','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:27:27'),(10,'GEC 2','Readings in Philippine History',3,0,3,'minor','lecture','1','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(11,'ROTC/CWTS 102','Reserved Officer Training Corps/CWTS',3,0,3,'minor','lecture','1','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 04:01:24'),(12,'PATH FIT 2','Fitness Training',2,0,2,'minor','lecture','1','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(13,'IT 108','Data Structures & Algorithms',2,1,3,'major','laboratory','2','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:27:41'),(14,'IT 109','Fundamentals of Database Systems',2,1,3,'major','laboratory','2','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:37:46'),(15,'IT 110','Object Oriented Programming (OOP)',2,1,3,'major','laboratory','2','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:38:11'),(16,'IT 111','Social Issues & Professional Issues',3,0,3,'major','lecture','2','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:38:45'),(17,'IT 112','Information Management 1',3,0,3,'major','lecture','2','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:40:03'),(18,'GEC 3','The Contemporary World',3,0,3,'minor','lecture','2','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(19,'PATH FIT 3','Dance Sports-Dual/Group/Outdoor',2,0,2,'minor','lecture','2','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(20,'IT 113','Event-Driven Programming',2,1,3,'major','laboratory','2','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:40:14'),(21,'IT 114','Integrative Programming & Technologies 1',2,1,3,'major','laboratory','2','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:40:22'),(22,'IT 115','Human Computer Interaction 1',2,1,3,'major','laboratory','2','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:40:32'),(23,'IT 116','Advanced Database System',2,1,3,'major','laboratory','2','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:40:38'),(24,'IT 117','Quantitative Methods (Modeling & Simulation)',2,1,3,'major','laboratory','2','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:46:54'),(25,'GEC 4','Mathematics in the Modern World',3,0,3,'minor','lecture','2','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(26,'GEE 6','Art Appreciation',3,0,3,'minor','lecture','2','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 04:51:38'),(27,'GEC 6','Ethics',3,0,3,'minor','lecture','2','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(28,'PATH FIT 4','Team Sports',2,0,2,'minor','lecture','2','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(29,'IT 118','Human Computer Interaction 2',2,1,3,'major','laboratory','2','summer',6,'active','2026-08-04 03:40:57','2026-08-04 04:47:04'),(30,'IT 119','System Integration & Architecture 1',2,1,3,'major','laboratory','2','summer',6,'active','2026-08-04 03:40:57','2026-08-04 04:49:02'),(31,'IT Elec 1','System Analysis and Design (SAD)',3,0,3,'major','lecture','2','summer',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(32,'IT 120','Research 1 (Methods of Research in Computing)',3,0,3,'major','lecture','3','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:49:33'),(33,'IT 121','Information Management 2',3,0,3,'major','lecture','3','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:49:45'),(34,'IT 122','Integrative Programming & Technologies 2',2,1,3,'major','laboratory','3','1st',6,'active','2026-08-04 03:40:57','2026-08-04 04:49:56'),(35,'IT 123','Information Assurance & Security 1',2,1,3,'major','laboratory','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:59:20'),(36,'IT Elec 2','Computer Graphics',2,1,3,'major','laboratory','3','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(37,'GEC 7','Science, Technology and Society',3,0,3,'minor','lecture','3','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 04:53:59'),(38,'GEC 8','Science, Technology and Society',3,0,3,'minor','lecture','3','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(39,'GEC 9','Life and Works of Rizal',3,0,3,'minor','lecture','1','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-06 05:33:04'),(40,'GEC 10','Technopreneurship (The Entrepreneurial Mind)',3,0,3,'minor','lecture','3','1st',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(41,'IT 124','Networking 1',2,1,3,'major','laboratory','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:58:26'),(42,'IT 125','Capstone Project 1',3,0,3,'major','lecture','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:58:26'),(43,'IT 126','System Integration & Architecture 2',2,1,3,'major','laboratory','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:58:26'),(44,'IT 127','Platform Technologies',3,0,3,'major','lecture','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:58:26'),(45,'IT 128','Web Systems & Technologies',3,0,3,'major','lecture','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 03:41:16'),(46,'IT Elec 3','Computer-Aided Design (Cad)',2,1,3,'major','laboratory','3','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 04:58:26'),(47,'GEE 1','Environmental Science',3,0,3,'minor','lecture','1','1st',NULL,'active','2026-08-04 03:40:57','2026-08-06 05:10:30'),(48,'GEE 2','Gender & Society',3,0,3,'minor','lecture','3','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(49,'GEE 10','Entrepreneurial Management',3,0,3,'minor','lecture','3','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(50,'GEE 11','Phil Indigenous Communities & Peace Studies Education',3,0,3,'minor','lecture','3','2nd',NULL,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(51,'IT Elec 4','Fundamentals of Data Warehousing & Data Mining',3,0,3,'major','lecture','3','summer',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(52,'IT Elec 5','Multimedia System',2,1,3,'major','laboratory','3','summer',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(53,'IT Elec 6','Management Information System (MIS)',3,0,3,'major','lecture','3','summer',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(54,'IT 129','System Administration and Maintenance',2,1,3,'major','laboratory','4','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(55,'IT 130','Information Assurance & Security 2',2,1,3,'major','laboratory','4','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(56,'IT 131','Networking 2',2,1,3,'major','laboratory','4','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(57,'IT 132','Web Systems and Technologies',2,1,3,'major','laboratory','4','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(58,'IT 133','Capstone Project 2',3,0,3,'major','lecture','4','1st',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(59,'Prac 401','Practicum (486 hours)',6,0,6,'major','lecture','4','2nd',6,'active','2026-08-04 03:40:57','2026-08-04 03:40:57'),(60,'GEC 1','Understanding the Self',3,0,3,'minor','lecture','1','1st',NULL,'active','2026-08-04 03:47:05','2026-08-06 05:10:30'),(61,'GEC 5','Purposive Communication',3,0,3,'minor','lecture','3','1st',NULL,'active','2026-08-04 04:53:59','2026-08-04 04:53:59'),(62,'GEE 9','Technopreneurship (the Entrepreneurial Mind)',3,0,3,'minor','lecture','3','1st',NULL,'active','2026-08-04 04:53:59','2026-08-04 04:53:59'),(63,'GEE 8','Ethics',3,0,3,'minor','lecture','2','2nd',NULL,'active','2026-08-04 04:55:13','2026-08-04 04:55:13'),(64,'GEE 4','Living in IT Era',3,0,3,'minor','lecture','1','1st',6,'active','2026-08-04 04:58:26','2026-08-06 05:10:30'),(65,'GEE 7','Gender & Society',3,0,3,'minor','lecture','3','2nd',6,'active','2026-08-04 04:58:26','2026-08-04 05:00:04'),(66,'GEE 10','Entrepreneurial Management',3,0,3,'minor','lecture','3','2nd',6,'active','2026-08-04 04:58:26','2026-08-04 04:59:52'),(67,'GEE 11','Phil. Indigenous Communities & Peace Studies Education',3,0,3,'minor','lecture','3','2nd',6,'active','2026-08-04 04:58:26','2026-08-04 04:59:57'),(68,'NSTP 1','Civic Welfare Training Service',3,0,3,'minor','lecture','1','1st',2,'active','2026-08-06 05:08:26','2026-08-06 05:36:51'),(69,'BAC 100','Basic Finance',3,0,3,'major','lecture','1','1st',2,'active','2026-08-06 05:27:32','2026-08-06 05:27:32'),(70,'BAC 101','Basic Micro Economic',3,0,3,'major','lecture','1','1st',2,'active','2026-08-06 05:27:32','2026-08-06 05:27:32'),(71,'PMC 101','Advanced Accounting 1',3,0,3,'major','lecture','1','1st',2,'active','2026-08-06 05:27:32','2026-08-06 05:27:32'),(72,'NSTP 2','Civic Welfare Training Services',3,0,3,'minor','lecture','1','2nd',NULL,'active','2026-08-06 05:33:04','2026-08-06 05:33:04'),(73,'CBMC 101','Math of Investment',3,0,3,'major','lecture','1','2nd',2,'active','2026-08-06 05:33:04','2026-08-06 05:33:04'),(74,'BAC 102','Macro Economics',3,0,3,'major','lecture','1','2nd',2,'active','2026-08-06 05:33:04','2026-08-06 05:33:04'),(75,'PMC 102','Partnership & Corporation',3,0,3,'major','lecture','1','2nd',2,'active','2026-08-06 05:33:04','2026-08-06 05:33:04'),(76,'IT 104','Integrative Application Software',3,0,3,'minor','lecture','1','2nd',NULL,'active','2026-08-06 05:33:04','2026-08-06 05:33:04');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curricula`
--

DROP TABLE IF EXISTS `curricula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curricula` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `curriculum_version` varchar(255) DEFAULT NULL,
  `academic_year` varchar(255) DEFAULT NULL,
  `effective_school_year` varchar(255) NOT NULL,
  `status` enum('draft','active','archived') NOT NULL DEFAULT 'draft',
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curricula_code_unique` (`code`),
  KEY `curricula_department_id_foreign` (`department_id`),
  CONSTRAINT `curricula_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curricula`
--

LOCK TABLES `curricula` WRITE;
/*!40000 ALTER TABLE `curricula` DISABLE KEYS */;
INSERT INTO `curricula` VALUES (1,'BS in Information Technology',6,'CMO 25 S.2015','1','2026-2027','2020-2021','active',NULL,'2026-08-04 03:36:49','2026-08-04 05:08:10'),(2,'BS in Business Administration',2,'CMO 17 S.2017','1','2026-2027','2019-2020','active',NULL,'2026-08-06 05:04:29','2026-08-06 05:34:24');
/*!40000 ALTER TABLE `curricula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curriculum_course`
--

DROP TABLE IF EXISTS `curriculum_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curriculum_course` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `curriculum_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `year_level` tinyint(3) unsigned NOT NULL,
  `semester` tinyint(3) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `curriculum_course_curriculum_id_course_id_unique` (`curriculum_id`,`course_id`),
  KEY `curriculum_course_course_id_foreign` (`course_id`),
  CONSTRAINT `curriculum_course_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `curriculum_course_curriculum_id_foreign` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_course`
--

LOCK TABLES `curriculum_course` WRITE;
/*!40000 ALTER TABLE `curriculum_course` DISABLE KEYS */;
INSERT INTO `curriculum_course` VALUES (1,1,1,1,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(2,1,2,1,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(3,1,3,1,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(5,1,5,1,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(6,1,6,1,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(7,1,7,1,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(8,1,8,1,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(10,1,10,1,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(11,1,11,1,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(12,1,12,1,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(18,1,18,2,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(19,1,19,2,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(20,1,20,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(21,1,21,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(22,1,22,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(23,1,23,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(25,1,25,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(28,1,28,2,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(29,1,29,2,3,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(33,1,33,3,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(34,1,34,3,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(51,1,51,3,3,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(52,1,52,3,3,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(53,1,53,3,3,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(54,1,54,4,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(55,1,55,4,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(56,1,56,4,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(57,1,57,4,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(58,1,58,4,1,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(59,1,59,4,2,'2026-08-04 03:40:57','2026-08-04 03:40:57'),(60,1,4,1,2,'2026-08-04 03:45:50','2026-08-04 03:45:50'),(61,1,60,1,1,'2026-08-04 03:47:05','2026-08-04 03:47:05'),(62,1,9,2,1,'2026-08-04 04:26:39','2026-08-04 04:26:39'),(63,1,13,2,1,'2026-08-04 04:26:49','2026-08-04 04:26:49'),(64,1,14,2,1,'2026-08-04 04:27:59','2026-08-04 04:27:59'),(65,1,15,2,1,'2026-08-04 04:28:08','2026-08-04 04:28:08'),(66,1,16,2,1,'2026-08-04 04:28:15','2026-08-04 04:28:15'),(67,1,17,2,2,'2026-08-04 04:39:42','2026-08-04 04:39:42'),(68,1,24,2,3,'2026-08-04 04:41:23','2026-08-04 04:41:23'),(69,1,31,2,3,'2026-08-04 04:47:27','2026-08-04 04:47:27'),(70,1,30,3,1,'2026-08-04 04:47:48','2026-08-04 04:47:48'),(71,1,32,3,1,'2026-08-04 04:49:33','2026-08-04 04:49:33'),(72,1,36,3,1,'2026-08-04 04:50:30','2026-08-04 04:50:30'),(73,1,61,3,1,'2026-08-04 04:53:59','2026-08-04 04:53:59'),(74,1,37,3,1,'2026-08-04 04:53:59','2026-08-04 04:53:59'),(75,1,39,3,1,'2026-08-04 04:53:59','2026-08-04 04:53:59'),(76,1,62,3,1,'2026-08-04 04:53:59','2026-08-04 04:53:59'),(77,1,26,2,2,'2026-08-04 04:55:13','2026-08-04 04:55:13'),(78,1,63,2,2,'2026-08-04 04:55:13','2026-08-04 04:55:13'),(79,1,41,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(80,1,42,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(81,1,43,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(82,1,44,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(83,1,46,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(84,1,64,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(85,1,65,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(86,1,66,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(87,1,67,3,2,'2026-08-04 04:58:26','2026-08-04 04:58:26'),(88,1,35,3,2,'2026-08-04 04:59:20','2026-08-04 04:59:20'),(89,2,6,1,1,'2026-08-06 05:08:26','2026-08-06 05:08:26'),(90,2,68,1,1,'2026-08-06 05:08:26','2026-08-06 05:08:26'),(91,2,60,1,1,'2026-08-06 05:10:30','2026-08-06 05:10:30'),(92,2,47,1,1,'2026-08-06 05:10:30','2026-08-06 05:10:30'),(93,2,64,1,1,'2026-08-06 05:10:30','2026-08-06 05:10:30'),(94,2,69,1,1,'2026-08-06 05:27:32','2026-08-06 05:27:32'),(95,2,70,1,1,'2026-08-06 05:27:32','2026-08-06 05:27:32'),(96,2,71,1,1,'2026-08-06 05:27:32','2026-08-06 05:27:32'),(97,2,72,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(98,2,12,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(99,2,10,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(100,2,39,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(101,2,73,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(102,2,74,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(103,2,75,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04'),(104,2,76,1,2,'2026-08-06 05:33:04','2026-08-06 05:33:04');
/*!40000 ALTER TABLE `curriculum_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `department_code` varchar(255) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departments_department_name_unique` (`department_name`),
  UNIQUE KEY `departments_department_code_unique` (`department_code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'College of Arts and Sciences','CAS',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(2,'College of Business Administration','CBA',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(3,'College of Criminal Justice and Public Safety','CCJPS',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(4,'College of Education','CED',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(5,'College of Hospitality Management','CHM',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(6,'College of Information Technology','CIT',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(7,'College of Library and Information Science','CLIS',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32'),(8,'College of Midwifery','CM',NULL,'2026-08-04 03:35:32','2026-08-04 03:35:32');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `employment_type` enum('full-time','part-time') NOT NULL,
  `max_units` int(11) NOT NULL DEFAULT 21,
  `overload_units` int(11) NOT NULL DEFAULT 0,
  `deload_units` int(11) NOT NULL DEFAULT 0,
  `probono_units` int(11) NOT NULL DEFAULT 0,
  `department_id` bigint(20) unsigned NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faculties_department_status_index` (`department_id`,`status`),
  CONSTRAINT `faculties_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,'Alan','Turing',NULL,'full-time',21,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(2,'Grace','Hopper',NULL,'full-time',21,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(3,'Ada','Lovelace',NULL,'full-time',21,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(4,'Donald','Knuth',NULL,'full-time',21,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(5,'Margaret','Hamilton',NULL,'full-time',21,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(6,'Katherine','Johnson',NULL,'part-time',12,0,0,0,6,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(7,'Marie','Curie',NULL,'full-time',21,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(8,'Albert','Einstein',NULL,'full-time',21,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(9,'Rosalind','Franklin',NULL,'full-time',21,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(10,'Jose','Rizal',NULL,'full-time',21,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(11,'Fe','Del Mundo',NULL,'full-time',21,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35'),(12,'Socrates','Reyes',NULL,'part-time',12,0,0,0,1,'active','2026-08-04 03:35:35','2026-08-04 03:35:35');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_availabilities`
--

DROP TABLE IF EXISTS `faculty_availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculty_availabilities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `faculty_id` bigint(20) unsigned NOT NULL,
  `day_index` tinyint(4) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faculty_availabilities_faculty_id_foreign` (`faculty_id`),
  CONSTRAINT `faculty_availabilities_faculty_id_foreign` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_availabilities`
--

LOCK TABLES `faculty_availabilities` WRITE;
/*!40000 ALTER TABLE `faculty_availabilities` DISABLE KEYS */;
INSERT INTO `faculty_availabilities` VALUES (1,6,0,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(2,6,1,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(3,6,2,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(4,6,3,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(5,6,4,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(6,6,5,'07:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(7,6,6,'07:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(8,12,0,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(9,12,1,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(10,12,2,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(11,12,3,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(12,12,4,'17:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(13,12,5,'07:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35'),(14,12,6,'07:00:00','19:00:00','2026-08-04 03:35:35','2026-08-04 03:35:35');
/*!40000 ALTER TABLE `faculty_availabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_10_091418_create_personal_access_tokens_table',1),(5,'2026_06_10_121404_create_departments_table',1),(6,'2026_06_10_135126_create_permission_tables',1),(7,'2026_06_12_104133_create_rooms_table',1),(8,'2026_06_13_013305_create_faculties_table',1),(9,'2026_06_13_022536_create_courses_table',1),(10,'2026_06_14_092200_create_terms_table',1),(11,'2026_06_16_130518_create_sections_table',1),(12,'2026_06_22_121623_create_schedules_table',1),(13,'2026_07_17_000001_create_schedule_recommendations_table',1),(14,'2026_07_17_000002_create_scheduling_audit_logs_table',1),(15,'2026_07_20_000001_create_system_notifications_table',1),(16,'2026_07_20_000002_add_scheduling_performance_indexes',1),(17,'2026_07_22_123221_create_curricula_table',1),(18,'2026_07_22_130355_curriculum_course',1),(19,'2026_08_02_000000_create_schedule_splits_table',1),(20,'2026_08_03_070913_create_faculty_availabilities_table',1),(21,'2026_08_04_102646_fix_courses_unique_per_department',1),(22,'2026_08_05_000001_allow_online_schedules_without_rooms',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (6,'App\\Models\\User',3,'wicars-token','892532e7cbf4a6925a13c15191fc12c9be85c40c499b9358a0adb5ca676bbbef','[\"*\"]','2026-08-04 06:11:10',NULL,'2026-08-04 05:31:53','2026-08-04 06:11:10'),(7,'App\\Models\\User',7,'wicars-token','ff90e9fd7590427fa6f48f7e487730658e71ffdea75d8bc50117fd642316299c','[\"*\"]','2026-08-04 15:22:23',NULL,'2026-08-04 14:22:27','2026-08-04 15:22:23'),(8,'App\\Models\\User',7,'wicars-token','bf9e3b404db891b84c4e33bed21b44032f90b64c5fed2d351079339fde0be713','[\"*\"]','2026-08-04 18:13:35',NULL,'2026-08-04 18:10:26','2026-08-04 18:13:35'),(10,'App\\Models\\User',7,'wicars-token','777219479ac68bc11b13d8f247763d5d9e9103f981334bcad71ef3627fad8998','[\"*\"]','2026-08-05 01:20:33',NULL,'2026-08-05 01:19:25','2026-08-05 01:20:33'),(12,'App\\Models\\User',7,'wicars-token','7e5f9c344bcfbaec464fce2e3856ae52f659b6bf3c64bb29818c62ac9dcfe352','[\"*\"]','2026-08-05 06:37:25',NULL,'2026-08-05 06:01:15','2026-08-05 06:37:25'),(13,'App\\Models\\User',7,'wicars-token','09d5af74277fce3159f72894116c87dbc27296b2df0410866d93222683a17cc5','[\"*\"]','2026-08-05 19:42:20',NULL,'2026-08-05 18:21:33','2026-08-05 19:42:20'),(16,'App\\Models\\User',3,'wicars-token','87db015e6f651ed37c96cd4362f118fdbfbc8bdde839a610134682c37777c248','[\"*\"]','2026-08-06 06:57:52',NULL,'2026-08-06 05:34:03','2026-08-06 06:57:52');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(255) NOT NULL,
  `building` varchar(255) DEFAULT NULL,
  `room_type` enum('lecture','laboratory','online','field') NOT NULL,
  `status` enum('available','not available') NOT NULL DEFAULT 'available',
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rooms_room_code_unique` (`room_code`),
  KEY `rooms_department_id_foreign` (`department_id`),
  CONSTRAINT `rooms_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'NEE 201','NEE Building','lecture','available',1,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(2,'NEE 202','NEE Building','lecture','available',1,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(3,'NEE 203','NEE Building','lecture','available',1,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(4,'BA 201','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(5,'BA 202','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(6,'BA 203','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(7,'BA 204','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(8,'BA 205','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(9,'BA 206','Building 1','lecture','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(10,'BA Simulation','Building 1','laboratory','available',2,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(11,'Educ 101','Building 2','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(12,'Educ 102','Building 2','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(13,'Educ 103','Building 2','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(14,'Educ 104','Building 2','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(15,'NEE 301','NEE Building','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(16,'NEE 302','NEE Building','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(17,'NEE 303','NEE Building','lecture','available',4,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(18,'HM 201','Building 3','lecture','available',5,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(19,'HM 202','Building 3','lecture','available',5,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(20,'HM 203','Building 3','lecture','available',5,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(21,'HM 204','Building 3','lecture','available',5,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(22,'HM Simulation','Building 3','laboratory','available',5,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(23,'IT 105','Building 4','lecture','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(24,'NEE 204','NEE Building','lecture','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(25,'CompLab1','Building 4','laboratory','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(26,'CompLab2','Building 4','laboratory','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(27,'CompLab3','Building 4','laboratory','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(28,'CompLab4','Building 4','laboratory','available',6,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(29,'Lib Bldg','Building 5','lecture','available',7,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(30,'Educ 105','Building 2','lecture','available',7,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(31,'NEE 304','NEE Building','lecture','available',7,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(32,'GF','Building 5','lecture','available',7,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(33,'NEE 101','NEE Building','lecture','available',8,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(34,'NEE 102','NEE Building','lecture','available',8,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(35,'NEE 103','NEE Building','lecture','available',8,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(36,'NEE 104','NEE Building','lecture','available',8,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(37,'ONLINE',NULL,'online','available',NULL,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(38,'FIELD',NULL,'field','available',NULL,'2026-08-04 03:35:35','2026-08-04 03:35:35');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_recommendations`
--

DROP TABLE IF EXISTS `schedule_recommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_recommendations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `requested_by` bigint(20) unsigned DEFAULT NULL,
  `accepted_by` bigint(20) unsigned DEFAULT NULL,
  `rejected_by` bigint(20) unsigned DEFAULT NULL,
  `rank` int(10) unsigned NOT NULL DEFAULT 1,
  `score` int(11) NOT NULL DEFAULT 0,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `input_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`input_payload`)),
  `recommended_schedules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`recommended_schedules`)),
  `rejection_reason` text DEFAULT NULL,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_recommendations_term_id_foreign` (`term_id`),
  KEY `schedule_recommendations_requested_by_foreign` (`requested_by`),
  KEY `schedule_recommendations_accepted_by_foreign` (`accepted_by`),
  KEY `schedule_recommendations_rejected_by_foreign` (`rejected_by`),
  KEY `recommendations_department_status_created_index` (`department_id`,`status`,`created_at`),
  KEY `recommendations_section_status_index` (`section_id`,`status`),
  CONSTRAINT `schedule_recommendations_accepted_by_foreign` FOREIGN KEY (`accepted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedule_recommendations_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_recommendations_rejected_by_foreign` FOREIGN KEY (`rejected_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedule_recommendations_requested_by_foreign` FOREIGN KEY (`requested_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedule_recommendations_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedule_recommendations_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_recommendations`
--

LOCK TABLES `schedule_recommendations` WRITE;
/*!40000 ALTER TABLE `schedule_recommendations` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_recommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_splits`
--

DROP TABLE IF EXISTS `schedule_splits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_splits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` bigint(20) unsigned NOT NULL,
  `split_group_id` char(36) DEFAULT NULL,
  `meeting_type` enum('lecture','laboratory') DEFAULT NULL,
  `meeting_index` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedule_splits_schedule_id_foreign` (`schedule_id`),
  KEY `schedule_splits_split_group_id_index` (`split_group_id`),
  CONSTRAINT `schedule_splits_schedule_id_foreign` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_splits`
--

LOCK TABLES `schedule_splits` WRITE;
/*!40000 ALTER TABLE `schedule_splits` DISABLE KEYS */;
INSERT INTO `schedule_splits` VALUES (1,1,'19f144c4-ae37-47f9-b6e2-b762c09b02ba','laboratory',1,'2026-08-04 05:09:40','2026-08-04 05:09:40'),(2,7,'19f144c4-ae37-47f9-b6e2-b762c09b02ba','lecture',2,'2026-08-04 05:09:40','2026-08-04 05:09:40'),(3,12,'96a50aa3-0a11-463d-8110-17a36baceba0','laboratory',1,'2026-08-04 05:11:09','2026-08-04 05:11:09'),(4,14,'96a50aa3-0a11-463d-8110-17a36baceba0','lecture',2,'2026-08-04 05:11:09','2026-08-04 05:11:09'),(9,43,'228b4f8b-6c26-497c-97cb-a43f72eaabc2','lecture',2,'2026-08-04 18:13:15','2026-08-04 18:13:36'),(10,49,'228b4f8b-6c26-497c-97cb-a43f72eaabc2','laboratory',1,'2026-08-04 18:13:15','2026-08-04 18:13:36'),(11,2,'def31dbd-c456-4997-abc6-9e6373671a4c','laboratory',1,'2026-08-05 18:24:30','2026-08-05 18:24:30'),(12,50,'def31dbd-c456-4997-abc6-9e6373671a4c','lecture',2,'2026-08-05 18:24:30','2026-08-05 18:24:30');
/*!40000 ALTER TABLE `schedule_splits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedules`
--

DROP TABLE IF EXISTS `schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `faculty_id` bigint(20) unsigned DEFAULT NULL,
  `room_id` bigint(20) unsigned DEFAULT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `mode` enum('on-site','online','field') NOT NULL DEFAULT 'on-site',
  `is_hybrid` tinyint(1) NOT NULL DEFAULT 0,
  `preferred_pattern` varchar(20) DEFAULT NULL,
  `status` enum('draft','completed','submitted','approved_by_dean','rejected_by_dean','approved','faculty_assignment','finalized','rejected','revision') NOT NULL DEFAULT 'draft',
  `rejection_reason` text DEFAULT NULL,
  `reviewed_by_dean` bigint(20) unsigned DEFAULT NULL,
  `reviewed_at_dean` timestamp NULL DEFAULT NULL,
  `approved_by_vpaa` bigint(20) unsigned DEFAULT NULL,
  `approved_at_vpaa` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schedules_section_id_foreign` (`section_id`),
  KEY `schedules_course_id_foreign` (`course_id`),
  KEY `schedules_faculty_id_foreign` (`faculty_id`),
  KEY `schedules_department_id_foreign` (`department_id`),
  KEY `schedules_reviewed_by_dean_foreign` (`reviewed_by_dean`),
  KEY `schedules_approved_by_vpaa_foreign` (`approved_by_vpaa`),
  KEY `schedules_term_department_status_index` (`term_id`,`department_id`,`status`),
  KEY `schedules_room_conflict_index` (`term_id`,`room_id`,`day`,`start_time`,`end_time`),
  KEY `schedules_faculty_conflict_index` (`term_id`,`faculty_id`,`day`,`start_time`,`end_time`),
  KEY `schedules_section_conflict_index` (`term_id`,`section_id`,`day`,`start_time`,`end_time`),
  KEY `schedules_section_course_index` (`term_id`,`section_id`,`course_id`),
  KEY `schedules_room_id_foreign` (`room_id`),
  CONSTRAINT `schedules_approved_by_vpaa_foreign` FOREIGN KEY (`approved_by_vpaa`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedules_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_faculty_id_foreign` FOREIGN KEY (`faculty_id`) REFERENCES `faculties` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedules_reviewed_by_dean_foreign` FOREIGN KEY (`reviewed_by_dean`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `schedules_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `schedules_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
INSERT INTO `schedules` VALUES (1,1,1,2,NULL,26,6,'Monday','16:00:00','19:00:00','on-site',0,'days:0-1','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-04 05:28:15'),(2,1,1,3,NULL,25,6,'Tuesday','13:00:00','16:00:00','on-site',0,'days:1-2','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-05 18:24:30'),(3,1,1,60,NULL,23,6,'Wednesday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-04 05:28:15'),(4,1,1,6,NULL,38,6,'Thursday','13:00:00','15:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-04 05:28:15'),(5,1,1,1,NULL,27,6,'Friday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-04 05:28:15'),(6,1,1,5,NULL,38,6,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:08:26','2026-08-04 05:28:15'),(7,1,1,2,NULL,37,6,'Tuesday','16:00:00','18:00:00','online',0,'days:0-1','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:09:40','2026-08-04 05:28:15'),(8,1,2,6,NULL,38,6,'Monday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(9,1,2,60,NULL,24,6,'Monday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(10,1,2,2,NULL,27,6,'Wednesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(11,1,2,5,NULL,38,6,'Saturday','10:00:00','13:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(12,1,2,3,NULL,25,6,'Thursday','10:00:00','13:00:00','on-site',0,'days:3-2','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(13,1,2,1,NULL,26,6,'Friday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:10:43','2026-08-04 05:28:45'),(14,1,2,3,NULL,26,6,'Wednesday','10:00:00','12:00:00','on-site',0,'days:3-2','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:11:09','2026-08-04 05:28:45'),(28,1,3,6,NULL,38,6,'Monday','09:00:00','11:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(29,1,3,1,NULL,27,6,'Tuesday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(30,1,3,3,NULL,25,6,'Wednesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(31,1,3,2,NULL,25,6,'Thursday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(32,1,3,60,NULL,23,6,'Friday','10:00:00','11:30:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(33,1,3,60,NULL,23,6,'Tuesday','10:00:00','11:30:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(34,1,3,5,NULL,38,6,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 05:21:05','2026-08-04 05:28:49'),(42,1,4,6,NULL,38,6,'Tuesday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:42','2026-08-04 18:12:42'),(43,1,4,3,NULL,NULL,6,'Thursday','13:00:00','15:00:00','online',0,'days:1-3','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:42','2026-08-04 18:13:36'),(44,1,4,2,NULL,25,6,'Tuesday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:42','2026-08-04 18:12:42'),(45,1,4,60,NULL,23,6,'Friday','13:00:00','14:30:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:43','2026-08-04 18:12:43'),(46,1,4,60,NULL,23,6,'Tuesday','11:30:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:43','2026-08-04 18:12:43'),(47,1,4,5,NULL,38,6,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:43','2026-08-04 18:12:43'),(48,1,4,1,NULL,27,6,'Saturday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:12:44','2026-08-04 18:12:44'),(49,1,4,3,NULL,26,6,'Tuesday','13:00:00','16:00:00','on-site',0,'days:1-3','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-04 18:13:15','2026-08-04 18:13:36'),(50,1,1,3,NULL,23,6,'Wednesday','13:00:00','15:00:00','on-site',0,'days:1-2','draft',NULL,NULL,NULL,NULL,NULL,'2026-08-05 18:24:30','2026-08-05 18:24:30'),(59,1,9,69,NULL,7,2,'Monday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(60,1,9,70,NULL,4,2,'Monday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(61,1,9,60,NULL,7,2,'Tuesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(62,1,9,71,NULL,6,2,'Tuesday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(63,1,9,6,NULL,38,2,'Tuesday','15:00:00','17:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(64,1,9,47,NULL,7,2,'Wednesday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(65,1,9,64,NULL,4,2,'Thursday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(66,1,9,68,NULL,38,2,'Saturday','13:00:00','16:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:14','2026-08-06 05:38:14'),(67,1,10,70,NULL,5,2,'Monday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(68,1,10,64,NULL,9,2,'Tuesday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(69,1,10,47,NULL,4,2,'Wednesday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(70,1,10,6,NULL,38,2,'Thursday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(71,1,10,71,NULL,5,2,'Thursday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(72,1,10,69,NULL,4,2,'Thursday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(73,1,10,60,NULL,6,2,'Friday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(74,1,10,68,NULL,38,2,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:26','2026-08-06 05:38:26'),(75,1,11,70,NULL,5,2,'Monday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(76,1,11,6,NULL,38,2,'Tuesday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(77,1,11,47,NULL,4,2,'Thursday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(78,1,11,71,NULL,8,2,'Thursday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(79,1,11,60,NULL,9,2,'Thursday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(80,1,11,69,NULL,4,2,'Friday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(81,1,11,64,NULL,8,2,'Friday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(82,1,11,68,NULL,38,2,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:36','2026-08-06 05:38:36'),(83,1,12,70,NULL,6,2,'Monday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(84,1,12,64,NULL,4,2,'Monday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(85,1,12,47,NULL,9,2,'Monday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(86,1,12,6,NULL,38,2,'Tuesday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(87,1,12,60,NULL,4,2,'Wednesday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(88,1,12,69,NULL,6,2,'Wednesday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(89,1,12,71,NULL,4,2,'Friday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(90,1,12,68,NULL,38,2,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:38:49','2026-08-06 05:38:49'),(91,1,13,47,NULL,9,2,'Monday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:04','2026-08-06 05:39:04'),(92,1,13,70,NULL,8,2,'Monday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:04','2026-08-06 05:39:04'),(93,1,13,60,NULL,5,2,'Tuesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:04','2026-08-06 05:39:04'),(94,1,13,64,NULL,7,2,'Tuesday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:04','2026-08-06 05:39:04'),(95,1,13,69,NULL,9,2,'Thursday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:05','2026-08-06 05:39:05'),(96,1,13,71,NULL,7,2,'Thursday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:05','2026-08-06 05:39:05'),(97,1,13,6,NULL,38,2,'Thursday','15:00:00','17:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:05','2026-08-06 05:39:05'),(98,1,13,68,NULL,38,2,'Saturday','13:00:00','16:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:05','2026-08-06 05:39:05'),(99,1,14,70,NULL,4,2,'Monday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(100,1,14,69,NULL,6,2,'Monday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(101,1,14,64,NULL,4,2,'Wednesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(102,1,14,71,NULL,5,2,'Wednesday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(103,1,14,6,NULL,38,2,'Wednesday','15:00:00','17:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(104,1,14,60,NULL,8,2,'Thursday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(105,1,14,47,NULL,6,2,'Friday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(106,1,14,68,NULL,38,2,'Saturday','07:00:00','10:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:15','2026-08-06 05:39:15'),(107,1,15,47,NULL,5,2,'Monday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(108,1,15,64,NULL,8,2,'Monday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(109,1,15,60,NULL,4,2,'Tuesday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(110,1,15,69,NULL,8,2,'Wednesday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(111,1,15,6,NULL,38,2,'Thursday','09:00:00','11:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(112,1,15,70,NULL,9,2,'Friday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(113,1,15,71,NULL,5,2,'Friday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(114,1,15,68,NULL,38,2,'Saturday','10:00:00','13:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:36','2026-08-06 05:39:36'),(115,1,16,6,NULL,38,2,'Monday','07:00:00','09:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(116,1,16,70,NULL,7,2,'Monday','10:00:00','13:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(117,1,16,47,NULL,4,2,'Tuesday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(118,1,16,64,NULL,7,2,'Tuesday','16:00:00','19:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(119,1,16,60,NULL,9,2,'Wednesday','07:00:00','10:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(120,1,16,71,NULL,4,2,'Thursday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(121,1,16,69,NULL,8,2,'Friday','13:00:00','16:00:00','on-site',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48'),(122,1,16,68,NULL,38,2,'Saturday','13:00:00','16:00:00','field',0,NULL,'draft',NULL,NULL,NULL,NULL,NULL,'2026-08-06 05:39:48','2026-08-06 05:39:48');
/*!40000 ALTER TABLE `schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduling_audit_logs`
--

DROP TABLE IF EXISTS `scheduling_audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduling_audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `schedule_recommendation_id` bigint(20) unsigned DEFAULT NULL,
  `term_id` bigint(20) unsigned DEFAULT NULL,
  `section_id` bigint(20) unsigned DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `action` varchar(80) NOT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `scheduling_audit_logs_user_id_foreign` (`user_id`),
  KEY `scheduling_audit_logs_schedule_recommendation_id_foreign` (`schedule_recommendation_id`),
  KEY `scheduling_audit_logs_term_id_foreign` (`term_id`),
  KEY `scheduling_audit_logs_section_id_foreign` (`section_id`),
  KEY `scheduling_audit_logs_department_id_foreign` (`department_id`),
  CONSTRAINT `scheduling_audit_logs_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `scheduling_audit_logs_schedule_recommendation_id_foreign` FOREIGN KEY (`schedule_recommendation_id`) REFERENCES `schedule_recommendations` (`id`) ON DELETE SET NULL,
  CONSTRAINT `scheduling_audit_logs_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE SET NULL,
  CONSTRAINT `scheduling_audit_logs_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `scheduling_audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduling_audit_logs`
--

LOCK TABLES `scheduling_audit_logs` WRITE;
/*!40000 ALTER TABLE `scheduling_audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `scheduling_audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `section_name` varchar(255) NOT NULL,
  `year_level` enum('1','2','3','4') NOT NULL,
  `semester` enum('1st','2nd','summer') NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `term_id` bigint(20) unsigned NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sections_term_id_foreign` (`term_id`),
  KEY `sections_department_term_status_index` (`department_id`,`term_id`,`status`),
  CONSTRAINT `sections_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'BSIT 1A','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(2,'BSIT 1B','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(3,'BSIT 1C','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(4,'BSIT 1D','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(5,'BSIT 1E','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(6,'BSIT 1F','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(7,'BSIT 1G','1','1st',6,1,'active','2026-08-04 05:07:42','2026-08-04 05:07:42'),(8,'BSBA 1A','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(9,'BSBA 1B','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(10,'BSBA 1C','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(11,'BSBA 1D','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(12,'BSBA 1E','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(13,'BSBA 1F','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(14,'BSBA 1G','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(15,'BSBA 1H','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(16,'BSBA 1I','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34'),(17,'BSBA 1J','1','1st',2,1,'active','2026-08-06 05:35:34','2026-08-06 05:35:34');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_notifications`
--

DROP TABLE IF EXISTS `system_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_notifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `actor_id` bigint(20) unsigned DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `term_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(80) NOT NULL,
  `title` varchar(160) NOT NULL,
  `message` text NOT NULL,
  `remarks` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_notifications_actor_id_foreign` (`actor_id`),
  KEY `system_notifications_department_id_foreign` (`department_id`),
  KEY `system_notifications_term_id_foreign` (`term_id`),
  KEY `system_notifications_user_id_created_at_index` (`user_id`,`created_at`),
  KEY `system_notifications_type_department_id_term_id_index` (`type`,`department_id`,`term_id`),
  KEY `system_notifications_read_at_index` (`read_at`),
  CONSTRAINT `system_notifications_actor_id_foreign` FOREIGN KEY (`actor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `system_notifications_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `system_notifications_term_id_foreign` FOREIGN KEY (`term_id`) REFERENCES `terms` (`id`) ON DELETE SET NULL,
  CONSTRAINT `system_notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notifications`
--

LOCK TABLES `system_notifications` WRITE;
/*!40000 ALTER TABLE `system_notifications` DISABLE KEYS */;
INSERT INTO `system_notifications` VALUES (1,1,7,6,1,'schedule_activity','Schedule Updated','Richie Dadubo updated schedule for IT 103 (BSIT 1B).',NULL,'[]',NULL,'2026-08-04 05:10:49','2026-08-04 05:10:49'),(2,11,7,6,1,'schedule_activity','Schedule Updated','Richie Dadubo updated schedule for IT 103 (BSIT 1B).',NULL,'[]',NULL,'2026-08-04 05:10:49','2026-08-04 05:10:49'),(3,1,7,6,1,'schedule_activity','Schedule Updated','Richie Dadubo updated schedule for IT 101 (BSIT 1B).',NULL,'[]',NULL,'2026-08-04 05:10:51','2026-08-04 05:10:51'),(4,11,7,6,1,'schedule_activity','Schedule Updated','Richie Dadubo updated schedule for IT 101 (BSIT 1B).',NULL,'[]',NULL,'2026-08-04 05:10:51','2026-08-04 05:10:51');
/*!40000 ALTER TABLE `system_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `terms`
--

DROP TABLE IF EXISTS `terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `terms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `academic_year` varchar(255) NOT NULL,
  `semester` enum('1st','2nd','summer') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `terms_is_active_index` (`is_active`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `terms`
--

LOCK TABLES `terms` WRITE;
/*!40000 ALTER TABLE `terms` DISABLE KEYS */;
INSERT INTO `terms` VALUES (1,'2026-2027','1st',1,1,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(2,'2026-2027','2nd',0,1,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(3,'2026-2027','summer',0,0,'2026-08-04 03:35:35','2026-08-04 03:35:35');
/*!40000 ALTER TABLE `terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'secretary',
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'VPAA User','vpaa','$2y$12$gsiufsMXCIJ1lukd109uUelGL9Df04W39c9HZoaLbCcLSEtCkylZO','vpaa',NULL,NULL,'2026-08-04 03:35:33','2026-08-04 03:35:33'),(2,'Dessa Mae Krism Cardinez','arts_sec','$2y$12$DO1HBbzodQPDNFVwbpuO7eBroeHqp7fFg9O71vUK61E.LPtB4vE3y','secretary',1,NULL,'2026-08-04 03:35:33','2026-08-04 03:35:33'),(3,'Rexyl Ann Bacarro','ba_sec','$2y$12$ZqUhPMTAfpfX00NcEQ8uSeJwSBeKvQIOECXEYQIhR1WXTH0muOaT.','secretary',2,NULL,'2026-08-04 03:35:33','2026-08-04 03:35:33'),(4,'Lochinvar Kyle Vestal','crim_sec','$2y$12$XXqe0tDaui3HqNuwpVlWh.3DBYVZ3L.sN/FOAvYzTt1n2n.YdSlGK','secretary',3,NULL,'2026-08-04 03:35:33','2026-08-04 03:35:33'),(5,'John Carlo Villarosa','educ_sec','$2y$12$A6rZhNAJZp1Lglltvj/HBO.fKZaMFbP3O54LFWGT.wN1bQTcGxdfu','secretary',4,NULL,'2026-08-04 03:35:33','2026-08-04 03:35:33'),(6,'Carrex Salcedo','hm_sec','$2y$12$kczH6phEq9ohY02Ry442z.pVgmKy9A5iL3zTc8Hg7jqXOJUYQ82ti','secretary',5,NULL,'2026-08-04 03:35:34','2026-08-04 03:35:34'),(7,'Richie Dadubo','it_sec','$2y$12$W0y2/s/TLUJKaeMEfH9rBOIEmqC618mcTmw/P5LNXbCDAtMPHu/vu','secretary',6,NULL,'2026-08-04 03:35:34','2026-08-04 03:35:34'),(8,'Secretary User','lib_sec','$2y$12$cAwVhmbQ.4hCVpz2x3fKwOUGtcB6aC3fM3QCRJOUQevjEg09VVRFS','secretary',7,NULL,'2026-08-04 03:35:34','2026-08-04 03:35:34'),(9,'Secretary User','mid_sec','$2y$12$9zx6TOf7dPZmNTbMFFburOMJRJMm/ZqP.MedEuHcJOcxbo/nTUBpG','secretary',8,NULL,'2026-08-04 03:35:34','2026-08-04 03:35:34'),(10,'Dean User','dean','$2y$12$GtguefsiVStT/RPCbSLzyOJvOkje7WKle34THfzXRgnuoiVokDe0u','dean',1,NULL,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(11,'IT Dean','it_dean','$2y$12$iew/VoEZo8tgkXv8D20Gp.xXlAX80cPpXJD7nk6F1/V7FA0msULy2','dean',6,NULL,'2026-08-04 03:35:35','2026-08-04 03:35:35'),(12,'Program Head User','program_head','$2y$12$nbM4ePNPrvF.WeQzilW55uYnJq2nEQIVz80fpmuo20wHuX028YchO','program_head',6,NULL,'2026-08-04 03:35:35','2026-08-04 03:35:35');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-07  9:41:21
