-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: scheduling_db
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
-- Table structure for table `authentication_audit_logs`
--

DROP TABLE IF EXISTS `authentication_audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authentication_audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `actor_user_id` bigint(20) unsigned DEFAULT NULL,
  `subject_user_id` bigint(20) unsigned DEFAULT NULL,
  `event` varchar(80) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `authentication_audit_logs_actor_user_id_foreign` (`actor_user_id`),
  KEY `authentication_audit_logs_subject_user_id_foreign` (`subject_user_id`),
  KEY `authentication_audit_logs_event_index` (`event`),
  CONSTRAINT `authentication_audit_logs_actor_user_id_foreign` FOREIGN KEY (`actor_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `authentication_audit_logs_subject_user_id_foreign` FOREIGN KEY (`subject_user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authentication_audit_logs`
--

LOCK TABLES `authentication_audit_logs` WRITE;
/*!40000 ALTER TABLE `authentication_audit_logs` DISABLE KEYS */;
INSERT INTO `authentication_audit_logs` VALUES (1,NULL,1,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-16 21:12:05','2026-08-16 21:12:05'),(2,NULL,1,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-18 04:08:51','2026-08-18 04:08:51'),(3,1,1,'logout','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36',NULL,'2026-08-18 04:11:20','2026-08-18 04:11:20'),(4,NULL,7,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-18 04:11:25','2026-08-18 04:11:25'),(5,7,7,'logout','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36',NULL,'2026-08-18 04:11:37','2026-08-18 04:11:37'),(6,NULL,1,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-18 20:45:46','2026-08-18 20:45:46'),(7,1,1,'logout','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36',NULL,'2026-08-18 20:46:52','2026-08-18 20:46:52'),(8,NULL,7,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-18 20:47:02','2026-08-18 20:47:02'),(9,NULL,1,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-19 18:15:27','2026-08-19 18:15:27'),(10,NULL,11,'login_succeeded','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36','{\"method\":\"password\"}','2026-08-19 23:10:23','2026-08-19 23:10:23'),(11,11,11,'logout','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/151.0.0.0 Safari/537.36',NULL,'2026-08-19 23:10:37','2026-08-19 23:10:37');
/*!40000 ALTER TABLE `authentication_audit_logs` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Table structure for table `course_categories`
--

DROP TABLE IF EXISTS `course_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_categories_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_categories`
--

LOCK TABLES `course_categories` WRITE;
/*!40000 ALTER TABLE `course_categories` DISABLE KEYS */;
INSERT INTO `course_categories` VALUES (1,'GEC','General Education Curriculum courses.','2026-08-16 21:11:51','2026-08-16 21:11:51'),(2,'Laboratory','Courses that require laboratory scheduling rules.','2026-08-16 21:11:51','2026-08-16 21:11:51'),(3,'Field','Courses that use field or activity-area scheduling rules.','2026-08-16 21:11:51','2026-08-16 21:11:51'),(4,'Research','Research, thesis, capstone, or similar courses.','2026-08-16 21:11:51','2026-08-16 21:11:51'),(5,'Other','Additional course classification.','2026-08-16 21:11:51','2026-08-16 21:11:51');
/*!40000 ALTER TABLE `course_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_category_mapping`
--

DROP TABLE IF EXISTS `course_category_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_category_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) unsigned NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_category_mapping_unique` (`course_id`,`category_id`),
  KEY `course_category_mapping_category_id_index` (`category_id`),
  CONSTRAINT `course_category_mapping_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `course_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_category_mapping_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_category_mapping`
--

LOCK TABLES `course_category_mapping` WRITE;
/*!40000 ALTER TABLE `course_category_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_category_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_teaching_assignments`
--

DROP TABLE IF EXISTS `course_teaching_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_teaching_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `course_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_teaching_assignments_course_id_unique` (`course_id`),
  KEY `course_teaching_assignments_department_id_foreign` (`department_id`),
  CONSTRAINT `course_teaching_assignments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_teaching_assignments_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_teaching_assignments`
--

LOCK TABLES `course_teaching_assignments` WRITE;
/*!40000 ALTER TABLE `course_teaching_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_teaching_assignments` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curricula`
--

LOCK TABLES `curricula` WRITE;
/*!40000 ALTER TABLE `curricula` DISABLE KEYS */;
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
  KEY `curriculum_course_term_lookup_index` (`curriculum_id`,`year_level`,`semester`),
  CONSTRAINT `curriculum_course_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `curriculum_course_curriculum_id_foreign` FOREIGN KEY (`curriculum_id`) REFERENCES `curricula` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curriculum_course`
--

LOCK TABLES `curriculum_course` WRITE;
/*!40000 ALTER TABLE `curriculum_course` DISABLE KEYS */;
/*!40000 ALTER TABLE `curriculum_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_forced_course_days`
--

DROP TABLE IF EXISTS `department_forced_course_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department_forced_course_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `day` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_forced_course_day_unique` (`department_id`,`course_id`),
  KEY `department_forced_course_days_course_id_foreign` (`course_id`),
  CONSTRAINT `department_forced_course_days_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `department_forced_course_days_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_forced_course_days`
--

LOCK TABLES `department_forced_course_days` WRITE;
/*!40000 ALTER TABLE `department_forced_course_days` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_forced_course_days` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faculties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `administrative_role` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `employment_type` enum('full-time','part-time') NOT NULL,
  `max_units` int(11) NOT NULL DEFAULT 21,
  `overload_units` int(11) NOT NULL DEFAULT 0,
  `deload_units` int(11) NOT NULL DEFAULT 0,
  `probono_units` int(11) NOT NULL DEFAULT 0,
  `profile_picture` longtext DEFAULT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `faculties_user_id_unique` (`user_id`),
  KEY `faculties_department_status_index` (`department_id`,`status`),
  CONSTRAINT `faculties_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `faculties_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,NULL,NULL,'Alan','Turing',NULL,'full-time',21,0,0,0,NULL,6,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(2,NULL,NULL,'Grace','Hopper',NULL,'full-time',21,0,0,0,NULL,6,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(3,NULL,NULL,'Ada','Lovelace',NULL,'full-time',21,0,0,0,NULL,6,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(4,NULL,NULL,'Donald','Knuth',NULL,'full-time',21,0,0,0,NULL,6,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(5,NULL,NULL,'Margaret','Hamilton',NULL,'full-time',21,0,0,0,'data:image/jpeg;base64,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',6,'active','2026-08-09 20:35:53','2026-08-10 22:30:00'),(6,NULL,NULL,'Katherine','Johnson',NULL,'part-time',12,0,0,0,NULL,6,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(7,NULL,NULL,'Marie','Curie',NULL,'full-time',21,0,0,0,'data:image/jpeg;base64,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',1,'active','2026-08-09 20:35:53','2026-08-10 22:30:29'),(8,NULL,NULL,'Albert','Einstein',NULL,'full-time',21,0,0,0,'data:image/jpeg;base64,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',1,'active','2026-08-09 20:35:53','2026-08-10 23:12:13'),(9,NULL,NULL,'Rosalind','Franklin',NULL,'full-time',21,0,0,0,NULL,1,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(10,NULL,NULL,'Jose','Rizal',NULL,'full-time',21,0,0,0,NULL,1,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(11,NULL,NULL,'Fe','Del Mundo',NULL,'full-time',21,0,0,0,NULL,1,'active','2026-08-09 20:35:53','2026-08-09 20:35:53'),(12,NULL,NULL,'Socrates','Reyes',NULL,'part-time',12,0,0,0,NULL,1,'active','2026-08-09 20:35:53','2026-08-09 20:35:53');
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
INSERT INTO `faculty_availabilities` VALUES (1,6,0,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(2,6,1,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(3,6,2,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(4,6,3,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(5,6,4,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(6,6,5,'07:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(7,6,6,'07:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(8,12,0,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(9,12,1,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(10,12,2,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(11,12,3,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(12,12,4,'17:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(13,12,5,'07:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53'),(14,12,6,'07:00:00','19:00:00','2026-08-09 20:35:53','2026-08-09 20:35:53');
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
-- Table structure for table `field_course_settings`
--

DROP TABLE IF EXISTS `field_course_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_course_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `course_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_course_settings_course_code_unique` (`course_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `field_course_settings`
--

LOCK TABLES `field_course_settings` WRITE;
/*!40000 ALTER TABLE `field_course_settings` DISABLE KEYS */;
INSERT INTO `field_course_settings` VALUES (1,0,NULL,'2026-08-09 20:35:45','2026-08-09 20:35:45');
/*!40000 ALTER TABLE `field_course_settings` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_06_10_091418_create_personal_access_tokens_table',1),(5,'2026_06_10_121404_create_departments_table',1),(6,'2026_06_10_135126_create_permission_tables',1),(7,'2026_06_12_104133_create_rooms_table',1),(8,'2026_06_13_013305_create_faculties_table',1),(9,'2026_06_13_022536_create_courses_table',1),(10,'2026_06_14_092200_create_terms_table',1),(11,'2026_06_16_130518_create_sections_table',1),(12,'2026_06_22_121623_create_schedules_table',1),(13,'2026_07_17_000001_create_schedule_recommendations_table',1),(14,'2026_07_17_000002_create_scheduling_audit_logs_table',1),(15,'2026_07_20_000001_create_system_notifications_table',1),(16,'2026_07_20_000002_add_scheduling_performance_indexes',1),(17,'2026_07_22_123221_create_curricula_table',1),(18,'2026_07_22_130355_curriculum_course',1),(19,'2026_08_02_000000_create_schedule_splits_table',1),(20,'2026_08_03_070913_create_faculty_availabilities_table',1),(21,'2026_08_05_000001_allow_online_schedules_without_rooms',1),(22,'2026_08_08_000001_remove_cross_department_curriculum_links',1),(23,'2026_08_08_000002_add_lecture_lab_override_to_departments_table',1),(24,'2026_08_08_000003_add_split_units_override_to_departments_table',1),(25,'2026_08_08_000004_add_custom_lab_duration_override_to_departments_table',1),(26,'2026_08_08_000005_add_custom_lab_duration_minutes_to_departments_table',1),(27,'2026_08_08_000006_add_custom_lab_duration_options_to_departments_table',1),(28,'2026_08_08_000007_add_gec_split_override_to_departments_table',1),(29,'2026_08_08_000008_add_force_schedule_reuse_to_departments_table',1),(30,'2026_08_09_000001_create_department_forced_course_days_table',1),(31,'2026_08_09_000002_create_department_forced_schedule_course_codes_table',1),(32,'2026_08_09_110647_create_schedule_settings_table',1),(33,'2026_08_09_111049_create_timeslot_override_table',1),(34,'2026_08_09_120000_add_max_concurrent_classes_to_rooms_table',1),(35,'2026_08_09_121000_create_field_course_settings_table',1),(36,'2026_08_11_000001_add_logo_to_departments_table',2),(37,'2026_08_11_062359_add_profile_picture_to_faculties_table',3),(38,'2026_08_11_070000_add_profile_picture_to_users_table',4),(39,'2026_08_11_073000_add_image_to_rooms_table',5),(40,'2026_08_11_073000_add_logo_to_departments_table',6),(41,'2026_08_10_000001_drop_department_forced_schedule_course_codes_table',7),(42,'2026_08_10_000002_set_field_room_capacity_to_three',7),(43,'2026_08_10_000003_set_online_room_capacity_to_three',7),(44,'2026_08_10_000004_create_programs_and_assign_users',7),(45,'2026_08_10_000005_create_course_teaching_assignments_table',7),(46,'2026_08_11_000001_add_field_evening_schedule_to_departments_table',7),(47,'2026_08_11_000002_create_course_categories_tables',7),(48,'2026_08_11_000003_clear_service_minor_course_departments',7),(49,'2026_08_11_000004_remove_gec_category_from_gee_courses',7),(50,'2026_08_11_000005_add_sunday_online_only_to_departments_table',7),(51,'2026_08_14_000001_create_department_part_time_course_rules_table',7),(52,'2026_08_14_000002_remove_part_time_course_rule_windows',7),(53,'2026_08_14_000003_add_lecture_lab_lecture_online_default_to_departments_table',7),(54,'2026_08_14_000004_add_major_lecture_lab_room_fallback_to_departments_table',7),(55,'2026_08_14_000005_add_allow_lecture_usage_to_rooms_and_remove_major_lecture_lab_fallback_setting',7),(56,'2026_08_14_000006_remove_lecture_lab_lecture_online_default_from_departments_table',7),(57,'2026_08_15_000001_mark_computer_laboratories_as_lecture_capable',7),(58,'2026_08_15_000002_drop_department_part_time_course_rules_table',7),(59,'2026_08_15_000003_add_scheduling_profile_to_departments_table',7),(60,'2026_08_15_000004_add_resource_slot_limits_to_departments_table',7),(61,'2026_08_16_000001_add_authentication_fields_to_users_table',7),(62,'2026_08_16_000002_create_authentication_audit_logs_table',7),(63,'2026_08_16_000003_create_password_reset_tokens_table_if_missing',7),(64,'2026_08_16_000004_link_faculty_profiles_to_users',7);
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
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
INSERT INTO `personal_access_tokens` VALUES (17,'App\\Models\\User',1,'wicars-token','aa66d512f06d44330898bd4841debb7fbb9d56d37171051e4b787c1776242081','[\"*\"]','2026-08-11 05:13:20',NULL,'2026-08-11 04:33:05','2026-08-11 05:13:20'),(25,'App\\Models\\User',1,'wicars-token','0af6f09a548d96230b64f9f39f3851f45ae461a5d921dd0c392199dc02c355e3','[\"*\"]','2026-08-11 22:05:41',NULL,'2026-08-11 22:05:31','2026-08-11 22:05:41'),(27,'App\\Models\\User',7,'wicars-token','c2aea91e7576f656a89850ad1ae7a56412e209995324d55794611bbaced2c647','[\"*\"]','2026-08-12 00:51:40',NULL,'2026-08-12 00:50:23','2026-08-12 00:51:40'),(29,'App\\Models\\User',7,'wicars-token','d6a35d239f839c140379aa255c40794513b40c4c869b1bf0a220e8012639afaa','[\"*\"]','2026-08-13 01:24:52',NULL,'2026-08-13 01:14:58','2026-08-13 01:24:52'),(32,'App\\Models\\User',7,'wicars-token','8a3883b5d092c92aa593ec45561487c2827f43633d9e6b0af113150c4b27c0d9','[\"*\"]','2026-08-13 09:02:47',NULL,'2026-08-13 08:50:25','2026-08-13 09:02:47'),(36,'App\\Models\\User',1,'wicars-password','2a49969098eaca5177176ec85b1b408542a4c807c7c50bc9fa2e43a9c7e5618b','[\"*\"]','2026-08-16 21:16:55',NULL,'2026-08-16 21:12:05','2026-08-16 21:16:55'),(40,'App\\Models\\User',7,'wicars-password','e344a0f2e2e7677d03039f5e77a6c2ccb99d714fefbd543e2b075560f361e473','[\"*\"]','2026-08-18 20:47:25',NULL,'2026-08-18 20:47:02','2026-08-18 20:47:25'),(41,'App\\Models\\User',1,'wicars-password','179ce8131d0ae18b5af4bbf37b0965900faf9fc193575c14e20f4cf71ea71b86','[\"*\"]','2026-08-19 19:19:33',NULL,'2026-08-19 18:15:27','2026-08-19 19:19:33');
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `programs`
--

DROP TABLE IF EXISTS `programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_id` bigint(20) unsigned NOT NULL,
  `cluster` varchar(255) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `programs_department_code_unique` (`department_id`,`code`),
  KEY `programs_department_id_cluster_index` (`department_id`,`cluster`),
  CONSTRAINT `programs_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `programs`
--

LOCK TABLES `programs` WRITE;
/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;
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
  `allow_lecture_usage` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('available','not available') NOT NULL DEFAULT 'available',
  `max_concurrent_classes` smallint(5) unsigned NOT NULL DEFAULT 1,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `image` longtext DEFAULT NULL,
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
INSERT INTO `rooms` VALUES (1,'NEE 201','NEE Building','lecture',0,'available',1,1,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(2,'NEE 202','NEE Building','lecture',0,'available',1,1,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(3,'NEE 203','NEE Building','lecture',0,'available',1,1,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(4,'BA 201','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(5,'BA 202','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(6,'BA 203','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(7,'BA 204','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(8,'BA 205','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(9,'BA 206','Building 1','lecture',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(10,'BA Simulation','Building 1','laboratory',0,'available',1,2,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(11,'Educ 101','Building 2','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(12,'Educ 102','Building 2','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(13,'Educ 103','Building 2','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(14,'Educ 104','Building 2','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(15,'NEE 301','NEE Building','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(16,'NEE 302','NEE Building','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(17,'NEE 303','NEE Building','lecture',0,'available',1,4,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(18,'HM 201','Building 3','lecture',0,'available',1,5,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(19,'HM 202','Building 3','lecture',0,'available',1,5,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(20,'HM 203','Building 3','lecture',0,'available',1,5,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(21,'HM 204','Building 3','lecture',0,'available',1,5,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(22,'HM Simulation','Building 3','laboratory',0,'available',1,5,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(23,'IT 105','Building 4','lecture',0,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(24,'NEE 204','NEE Building','lecture',0,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(25,'CompLab1','Building 4','laboratory',1,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(26,'CompLab2','Building 4','laboratory',1,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(27,'CompLab3','Building 4','laboratory',1,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(28,'CompLab4','Building 4','laboratory',1,'available',1,6,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(29,'Lib Bldg','Building 5','lecture',0,'available',1,7,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(30,'Educ 105','Building 2','lecture',0,'available',1,7,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(31,'NEE 304','NEE Building','lecture',0,'available',1,7,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(32,'GF','Building 5','lecture',0,'available',1,7,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(33,'NEE 101','NEE Building','lecture',0,'available',1,8,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(34,'NEE 102','NEE Building','lecture',0,'available',1,8,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(35,'NEE 103','NEE Building','lecture',0,'available',1,8,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(36,'NEE 104','NEE Building','lecture',0,'available',1,8,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(37,'ONLINE',NULL,'online',0,'available',3,NULL,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53'),(38,'FIELD',NULL,'field',0,'available',3,NULL,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53');
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
-- Table structure for table `schedule_settings`
--

DROP TABLE IF EXISTS `schedule_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schedule_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `opening_time` time NOT NULL DEFAULT '07:00:00',
  `closing_time` time NOT NULL DEFAULT '19:00:00',
  `slot_interval` int(11) NOT NULL DEFAULT 30,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_settings`
--

LOCK TABLES `schedule_settings` WRITE;
/*!40000 ALTER TABLE `schedule_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule_settings` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_splits`
--

LOCK TABLES `schedule_splits` WRITE;
/*!40000 ALTER TABLE `schedule_splits` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedules`
--

LOCK TABLES `schedules` WRITE;
/*!40000 ALTER TABLE `schedules` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,'BSIT1A','1','1st',6,1,'active','2026-08-12 00:50:53','2026-08-12 00:50:53');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_notifications`
--

LOCK TABLES `system_notifications` WRITE;
/*!40000 ALTER TABLE `system_notifications` DISABLE KEYS */;
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
INSERT INTO `terms` VALUES (1,'2026-2027','1st',1,1,'2026-08-09 20:35:54','2026-08-09 20:35:54'),(2,'2026-2027','2nd',0,1,'2026-08-09 20:35:54','2026-08-09 20:35:54'),(3,'2026-2027','summer',0,0,'2026-08-09 20:35:54','2026-08-09 20:35:54');
/*!40000 ALTER TABLE `terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeslot_override`
--

DROP TABLE IF EXISTS `timeslot_override`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeslot_override` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `duration_minutes` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeslot_override`
--

LOCK TABLES `timeslot_override` WRITE;
/*!40000 ALTER TABLE `timeslot_override` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeslot_override` ENABLE KEYS */;
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
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'secretary',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `allow_google_login` tinyint(1) NOT NULL DEFAULT 0,
  `google_id` varchar(255) DEFAULT NULL,
  `google_email` varchar(255) DEFAULT NULL,
  `google_linked_at` timestamp NULL DEFAULT NULL,
  `last_login_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `program_id` bigint(20) unsigned DEFAULT NULL,
  `profile_picture` longtext DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_google_id_unique` (`google_id`),
  KEY `users_program_id_foreign` (`program_id`),
  CONSTRAINT `users_program_id_foreign` FOREIGN KEY (`program_id`) REFERENCES `programs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'VPAA User','vpaa',NULL,'$2y$12$wYTLshIRICnmisHqKLnsHudJSqQYSvdzCK0BqbGjon2g/.mK7H2Ha','vpaa',1,0,NULL,NULL,NULL,'2026-08-19 18:15:27',NULL,NULL,NULL,NULL,'2026-08-09 20:35:48','2026-08-19 18:15:27'),(2,'Dessa Mae Krism Cardinez','arts_sec',NULL,'$2y$12$fZS3Oo6hcNva5divmB0fduQNLS9gi3nYHyWtgcHOxWOgv9CocD7FS','secretary',1,0,NULL,NULL,NULL,NULL,1,NULL,'data:image/jpeg;base64,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',NULL,'2026-08-09 20:35:48','2026-08-10 22:54:21'),(3,'Rexyl Ann Bacarro','ba_sec',NULL,'$2y$12$4RTOJIWVm3BpwspZ2k0.oOH5aZGccnaQVfJQ5XQjXdOzaF/W3uV.6','secretary',1,0,NULL,NULL,NULL,NULL,2,NULL,NULL,NULL,'2026-08-09 20:35:49','2026-08-09 20:35:49'),(4,'Lochinvar Kyle Vestal','crim_sec',NULL,'$2y$12$FUwY90iDHQv0e80TDpHYTuteOqyT/99gcbg.jFcmGJD6UzL5TudEC','secretary',1,0,NULL,NULL,NULL,NULL,3,NULL,NULL,NULL,'2026-08-09 20:35:49','2026-08-09 20:35:49'),(5,'John Carlo Villarosa','educ_sec',NULL,'$2y$12$sW0msQHGywP4QplIl3N3ZOgtgwNwOlFxARl.BYNagxiiBf9nnXM56','secretary',1,0,NULL,NULL,NULL,NULL,4,NULL,NULL,NULL,'2026-08-09 20:35:49','2026-08-09 20:35:49'),(6,'Carrex Salcedo','hm_sec',NULL,'$2y$12$0cbacUZI9YuKAMflYHPcdu8BhOWCvddSjv6SdiwU7E1tZy06soT2C','secretary',1,0,NULL,NULL,NULL,NULL,5,NULL,NULL,NULL,'2026-08-09 20:35:50','2026-08-09 20:35:50'),(7,'Richie Dadubo','it_sec',NULL,'$2y$12$zFyxDgz6h0YRvjV8UwVFE.G1IIW5VgxFNfblwVdN4hwa1AMoMDLre','secretary',1,0,NULL,NULL,NULL,'2026-08-18 20:47:02',6,NULL,NULL,NULL,'2026-08-09 20:35:50','2026-08-18 20:47:02'),(8,'Secretary User','lib_sec',NULL,'$2y$12$TlH7tW6zOlwSUC/mzb/YAOk50l73d6Lvo2bpdkefD/NRk9FoJSXUS','secretary',1,0,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL,'2026-08-09 20:35:51','2026-08-09 20:35:51'),(9,'Secretary User','mid_sec',NULL,'$2y$12$oVYosx/U1NcH0VwI58wWrefSlka5EHcWSJ5.cOIpzNWHRLw2KXega','secretary',1,0,NULL,NULL,NULL,NULL,8,NULL,NULL,NULL,'2026-08-09 20:35:51','2026-08-09 20:35:51'),(10,'Dean User','dean',NULL,'$2y$12$d8MhBGnQJoDZcfEJzusn2OOYWbYdvU6j9wBuraiE3jO9dkEi7McrS','dean',1,0,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,'2026-08-09 20:35:52','2026-08-09 20:35:52'),(11,'IT Dean','it_dean',NULL,'$2y$12$Ck3YoQ.gk93caZRDNvIUHu.ToA7OldE30qlXpJS/8O4vh.HNCBpFG','dean',1,0,NULL,NULL,NULL,'2026-08-19 23:10:23',6,NULL,NULL,NULL,'2026-08-09 20:35:52','2026-08-19 23:10:23'),(12,'Program Head User','program_head',NULL,'$2y$12$mPy0XG38ffjL5utmCslT7u/Aub9ORhurgRxee/cY5pE6zGdEJe.YC','program_head',1,0,NULL,NULL,NULL,NULL,6,NULL,NULL,NULL,'2026-08-09 20:35:53','2026-08-09 20:35:53');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zz_departments_frmfix`
--

DROP TABLE IF EXISTS `zz_departments_frmfix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zz_departments_frmfix` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `department_code` varchar(255) NOT NULL,
  `scheduling_profile` varchar(32) NOT NULL DEFAULT 'standard',
  `logo` longtext DEFAULT NULL,
  `lecture_lab_schedule_override_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `custom_lab_duration_override_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `custom_lab_duration_minutes` smallint(5) unsigned DEFAULT NULL,
  `custom_lab_duration_6_hours_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `custom_lab_duration_5_hours_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `custom_lab_duration_other_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `gec_split_schedule_override_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `force_schedule_reuse_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `field_evening_schedule_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `sunday_online_only_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `online_slot_limit` smallint(5) unsigned NOT NULL DEFAULT 3,
  `field_slot_limit` smallint(5) unsigned NOT NULL DEFAULT 3,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `departments_department_name_unique` (`department_name`),
  UNIQUE KEY `departments_department_code_unique` (`department_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zz_departments_frmfix`
--

LOCK TABLES `zz_departments_frmfix` WRITE;
/*!40000 ALTER TABLE `zz_departments_frmfix` DISABLE KEYS */;
/*!40000 ALTER TABLE `zz_departments_frmfix` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'scheduling_db'
--

--
-- Dumping routines for database 'scheduling_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-20 15:39:20
