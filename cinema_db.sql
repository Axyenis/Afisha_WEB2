-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: Localhost    Database: cinema_db
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cinemas`
--

DROP TABLE IF EXISTS `cinemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cinemas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cinemas`
--

LOCK TABLES `cinemas` WRITE;
/*!40000 ALTER TABLE `cinemas` DISABLE KEYS */;
INSERT INTO `cinemas` VALUES (1,'Красная площадь'),(2,'SBS'),(3,'Галерея');
/*!40000 ALTER TABLE `cinemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie_cinemas`
--

DROP TABLE IF EXISTS `movie_cinemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie_cinemas` (
  `movie_id` int NOT NULL,
  `cinema_id` int NOT NULL,
  PRIMARY KEY (`movie_id`,`cinema_id`),
  KEY `cinema_id` (`cinema_id`),
  CONSTRAINT `movie_cinemas_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `movie_cinemas_ibfk_2` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie_cinemas`
--

LOCK TABLES `movie_cinemas` WRITE;
/*!40000 ALTER TABLE `movie_cinemas` DISABLE KEYS */;
INSERT INTO `movie_cinemas` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(9,1),(10,1),(12,1),(1,2),(2,2),(3,2),(4,2),(5,2),(10,2),(11,2),(12,2),(1,3),(2,3),(3,3),(6,3),(7,3),(8,3),(9,3),(10,3),(12,3);
/*!40000 ALTER TABLE `movie_cinemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movies`
--

DROP TABLE IF EXISTS `movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `poster` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `cinema_id` int DEFAULT NULL,
  `first_show_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cinema_id` (`cinema_id`),
  CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `cinemas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movies`
--

LOCK TABLES `movies` WRITE;
/*!40000 ALTER TABLE `movies` DISABLE KEYS */;
INSERT INTO `movies` VALUES (1,'Остров проклятых','poster1.jpg',NULL,1,'2024-06-12 08:00:00'),(2,'Майор Гром','poster2.jpg',NULL,2,'2024-06-12 08:15:00'),(3,'Джокер','poster3.jpg',NULL,3,'2024-06-12 08:30:00'),(4,'Титаник','poster4.jpg',NULL,1,'2024-06-12 08:45:00'),(5,'Мстители: Война без конечностей','poster5.jpg',NULL,2,'2024-06-12 14:00:00'),(6,'Побег из Шоушенка','poster6.jpg',NULL,3,'2024-06-12 14:15:00'),(7,'Анчартед','poster7.jpg',NULL,2,'2024-06-12 14:30:00'),(8,'Затерянный город','poster8.jpg',NULL,1,'2024-06-12 14:45:00'),(9,'Мстители: Финал','poster9.jpg',NULL,NULL,'2024-06-12 10:45:00'),(10,'Паркер','poster10.jpg',NULL,NULL,'2024-06-12 08:45:00'),(11,'Живое','poster11.jpg',NULL,NULL,'2024-06-12 10:15:00'),(12,'Крепкий орешек','poster12.jpg',NULL,NULL,'2024-06-12 17:45:00');
/*!40000 ALTER TABLE `movies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `booking_details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (1,'dww110400.d@gmail.com','Запись на фильм \"Мстители: Война без конечностей\" в кинотеатре \"Красная площадь\" 17.06 в 20:00'),(2,'ваоылджвоа','Запись на фильм \"Побег из Шоушенка\" в кинотеатре \"Галерея\" 16.06 в 20:15'),(3,'dfd@mai.com','Запись на фильм \"Титаник\" в кинотеатре \"SBS\" 16.06 в 14:45'),(4,'dww110400.d@gmail.com','Запись на фильм \"Титаник\" в кинотеатре \"Красная площадь\" 16.06 в 14:45'),(5,'dww110400.d@gmail.com','Запись на фильм \"Титаник\" в кинотеатре \"SBS\" 17.06 в 17:45'),(6,'dww110400.d@gmail.com','Запись на фильм \"Затерянный город\" в кинотеатре \"Галерея\" 14.06 в 14:45'),(7,'sdfs@mail.com','Запись на фильм \"Титаник\" в кинотеатре \"Красная площадь\" 14.06 в 11:45'),(8,'dww110400.d@gmail.com','Запись на фильм \"Титаник\" в кинотеатре \"Красная площадь\" 14.06 в 08:45'),(9,'dww110400.d@gmail.com','Запись на фильм \"Мстители: Война без конечностей\" в кинотеатре \"Красная площадь\" 16.06 в 20:00'),(10,'dww110400.d@gmail.com','Запись на фильм \"Крепкий орешек\" в кинотеатре \"Красная площадь\" 16.06 в 23:45'),(11,'dww110400.d@gmail.com','Запись на фильм \"Джокер\" в кинотеатре \"Красная площадь\" 17.06 в 17:30'),(12,'dww110400.d@gmail.com','Запись на фильм \"Мстители: Война без конечностей\" в кинотеатре \"Красная площадь\" 16.06 в 20:00');
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors_counter`
--

DROP TABLE IF EXISTS `visitors_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitors_counter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `counter_value` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors_counter`
--

LOCK TABLES `visitors_counter` WRITE;
/*!40000 ALTER TABLE `visitors_counter` DISABLE KEYS */;
INSERT INTO `visitors_counter` VALUES (1,4);
/*!40000 ALTER TABLE `visitors_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'cinema_db'
--

--
-- Dumping routines for database 'cinema_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-14  0:55:24
