CREATE DATABASE  IF NOT EXISTS `sp_games` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sp_games`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: sp_games
-- ------------------------------------------------------
-- Server version	8.0.16

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `catname` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`categoryid`),
  UNIQUE KEY `catname_UNIQUE` (`catname`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Action','An action game emphasizes physical challenges, including hand–eye coordination and reaction-time','2020-12-02 06:51:44'),(2,'strategy ','A strategy game or strategic game is a game (e.g. a board game) in which the players\' uncoerced, and often autonomous, decision-making skills have a high significance in determining the outcome. ','2020-12-15 15:54:18'),(3,'Simulation','fun','2020-12-15 15:55:24'),(4,'First-person shooter','First-person shooter (FPS) is a video game genre centered on gun and other weapon-based combat in a first-person perspective; that is, the player experiences the action through the eyes of the protagonist.','2020-12-15 15:56:27'),(5,'Sport','A sports game is a video game genre that simulates the practice of sports. ','2020-12-15 15:57:01'),(6,'Adventure ','An adventure game is a video game in which the player assumes the role of a protagonist in an interactive story driven by exploration and puzzle-solving.','2020-12-15 15:59:51'),(8,'horror game','A horror game is a video game genre centered on horror fiction and typically designed to scare the player.','2020-12-28 07:57:08'),(10,'puzzle','puzzle','2021-01-06 06:58:33'),(11,'sad','sad','2021-01-13 06:36:31'),(12,'funny','funny','2021-01-13 06:39:29'),(16,'Logic','\'An action game emphasizes physical challenges, including hand–eye coordination and reaction-time\'','2021-01-13 07:15:24');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `game` (
  `gameid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `platform` varchar(45) NOT NULL,
  `fk_categoryid` int(11) NOT NULL,
  `year` year(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gameid`),
  UNIQUE KEY `title_UNIQUE` (`title`),
  KEY `fk_categoryid_idx` (`fk_categoryid`),
  CONSTRAINT `fk_categoryid` FOREIGN KEY (`fk_categoryid`) REFERENCES `category` (`categoryid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,'Assassin’s Creed Valhalla','Assassin\'s Creed Valhalla is an action role-playing video game developed by Ubisoft Montreal and published by Ubisoft',70,'PC',1,2020,'2020-12-02 07:01:52'),(3,'\'Call of Duty: Black Ops Cold War\'\n','Call of Duty: Black Ops Cold War is a 2020 first-person shooter video game developed by Treyarch and Raven Software and published by Activision. ',80,'PC',3,2020,'2020-12-15 16:22:04'),(4,'Grand Theft Auto V','Grand Theft Auto V is a 2013 action-adventure game developed by Rockstar North and published by Rockstar Games.',60,'PC',4,2013,'2020-12-15 16:24:18'),(5,'Forza Horizon 4','Forza Horizon 4 is a 2018 racing video game developed by Playground Games and published by Microsoft Studios. ',60,'PC',5,2018,'2020-12-15 16:26:12'),(6,'Portal 2','Portal 2 is a puzzle-platform game developed by Valve. It was released in April 2011 for Windows, Mac OS X, Linux, PlayStation 3, and Xbox 360.',26,'PC',6,2011,'2020-12-15 16:29:04'),(7,'Outlast II','Outlast 2 is a first-person survival horror game that, like its predecessors Outlast and Outlast: Whistleblower, is a single-player campaign. ',30,'PC',8,2017,'2021-02-06 17:40:56');
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `reviewid` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `rating` varchar(45) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fk_userid` int(11) NOT NULL,
  `fk_gameid` int(11) NOT NULL,
  PRIMARY KEY (`reviewid`),
  KEY `fk_userid_idx` (`fk_userid`),
  KEY `fk_gameid_idx` (`fk_gameid`),
  CONSTRAINT `fk_gameid` FOREIGN KEY (`fk_gameid`) REFERENCES `game` (`gameid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_userid` FOREIGN KEY (`fk_userid`) REFERENCES `user` (`userid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'Enjoyed the game! The story and gameplay was good!','5','2020-12-20 07:55:09',2,1),(3,'Amazing Game ! Solid Action with the potential of greatness','4','2020-12-22 05:41:07',4,3),(4,'Best action,adventure and fps shooting game with violence ','5','2020-12-22 05:43:27',5,4),(5,'Best racing game of all time , Loving playing the game everytime !','5','2020-12-22 05:45:22',6,5),(6,'The most best Challenging game that i have ever experience in the game ! love the graphic','6','2020-12-22 05:48:39',7,6),(7,'Just off the bat, you’ll see some really disturbing imagery in this game and there’s a lot of gore','5','2021-02-06 17:46:16',8,7);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `type` varchar(45) NOT NULL,
  `profile_pic_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Password` varchar(255) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'Terry Tan','terry@gmail.com','Customer','https://www.abc.com/terry.jpg','2020-12-02 06:50:35','terry123'),(3,'JohnLee','JohnLee@gmail.com','Admin','https://www.johnlee.com/johnlee.jpg','2020-12-15 13:49:05','john123'),(4,'lucasjohny','lucasjohny@yahoo.com','Customer','https://www.lucasjohny.com/lucasjohny.jpg','2020-12-15 13:52:26','lucas242'),(5,'ahmadAli','ahmadAli@gmail.com','Admin','https://ahmadAli.com/ahmadAli.jpg','2020-12-15 14:11:32','ahmad123'),(6,'amandaLee','amandaLee@gmail.com','Customer','https://amandaLee.com/amandaLee.jpg','2020-12-15 14:12:32','amanda234'),(7,'Daniel Tan','Danieltan@gmail.com','Admin','https://Danieltan.com/danieltan.jpg','2020-12-15 14:20:00','daniel1234'),(8,'johnsonlee','johnsonlee@yahoo.com','Customer','https://johnsonlee.com/johnsonlee.jpg','2020-12-22 16:49:52','johnson763'),(15,'davidlee','dave@gmail.com','Customer','dave.jpg','2021-01-06 06:56:26','david1939'),(16,'Chris Choo','Chrischoo@gmail.com','Customer','Chrischoo.jpg','2021-02-03 04:16:26','chrispw'),(17,'Ann Ang','annang@gmail.com','Admin','annang.jpg','2021-02-03 04:16:26','annpw'),(18,'Chris Choo  ','chrischoo@gmail.com ','Customer  ','chrischoo.jpg ','2021-02-03 04:24:35','chrispw '),(20,'ChrisChoo  ',' chrischoo@gmail.com  Customer ','Customer ',' chrischoo.jpg','2021-02-06 15:31:21','chrispw');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'sp_games'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-08  8:48:16
