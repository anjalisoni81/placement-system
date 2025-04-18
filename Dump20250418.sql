-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: placementsyst1
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company` (
  `Company_ID` varchar(50) NOT NULL,
  `Company_Name` varchar(40) NOT NULL,
  PRIMARY KEY (`Company_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('C101','Google'),('C102','Microsoft'),('C103','TCS'),('C104','Infosys'),('C105','Amazon');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_contact`
--

DROP TABLE IF EXISTS `company_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_contact` (
  `Contact_ID` int NOT NULL AUTO_INCREMENT,
  `Company_ID` varchar(50) NOT NULL,
  `Contact_Info` bigint NOT NULL,
  `Contact_Person` varchar(40) NOT NULL,
  PRIMARY KEY (`Contact_ID`),
  UNIQUE KEY `Contact_Info` (`Contact_Info`),
  KEY `Company_ID` (`Company_ID`),
  CONSTRAINT `company_contact_ibfk_1` FOREIGN KEY (`Company_ID`) REFERENCES `company` (`Company_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_contact`
--

LOCK TABLES `company_contact` WRITE;
/*!40000 ALTER TABLE `company_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `Document_ID` int NOT NULL AUTO_INCREMENT,
  `Registration_No` int NOT NULL,
  `Document_Name` varchar(40) NOT NULL,
  `Document_Link` varchar(250) NOT NULL,
  PRIMARY KEY (`Document_ID`),
  KEY `Registration_No` (`Registration_No`),
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`Registration_No`) REFERENCES `student` (`Registration_No`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
INSERT INTO `document` VALUES (1,101,'Resume','https://drive.com/resume_101.pdf'),(2,102,'Cover Letter','https://drive.com/cover_102.pdf'),(4,104,'Portfolio','https://drive.com/portfolio_104.pdf'),(5,105,'Degree Certificate','https://drive.com/degree_105.pdf');
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `placement`
--

DROP TABLE IF EXISTS `placement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `placement` (
  `Placement_ID` varchar(20) NOT NULL,
  `Stipend` int DEFAULT '0',
  `OfferType` varchar(20) NOT NULL,
  `OnOrOff_Campus` varchar(20) NOT NULL,
  `Company_ID` varchar(50) NOT NULL,
  `Registration_No` int NOT NULL,
  `Package` int DEFAULT NULL,
  `Last_Updated` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Placement_ID`),
  KEY `Registration_No` (`Registration_No`),
  KEY `idx_company_id` (`Company_ID`),
  CONSTRAINT `placement_ibfk_1` FOREIGN KEY (`Registration_No`) REFERENCES `student` (`Registration_No`) ON DELETE CASCADE,
  CONSTRAINT `placement_chk_1` CHECK ((`Stipend` >= 0)),
  CONSTRAINT `placement_chk_2` CHECK ((`OfferType` in (_utf8mb4'Full-Time',_utf8mb4'Internship'))),
  CONSTRAINT `placement_chk_3` CHECK ((`OnOrOff_Campus` in (_utf8mb4'On-Campus',_utf8mb4'Off-Campus'))),
  CONSTRAINT `placement_chk_4` CHECK ((`Package` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `placement`
--

LOCK TABLES `placement` WRITE;
/*!40000 ALTER TABLE `placement` DISABLE KEYS */;
INSERT INTO `placement` VALUES ('P001',50000,'Full-Time','On-Campus','C101',101,1200000,'2025-04-16 14:07:50'),('P002',40000,'Internship','Off-Campus','C102',102,NULL,'2025-04-16 14:07:50'),('P004',30000,'Internship','On-Campus','C104',104,NULL,'2025-04-16 14:07:50'),('P005',60000,'Full-Time','Off-Campus','C105',105,1500000,'2025-04-16 14:07:50'),('p010',12,'Full-Time','On-Campus','c103',1212,12,'2025-04-17 09:59:16');
/*!40000 ALTER TABLE `placement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `placementdetails`
--

DROP TABLE IF EXISTS `placementdetails`;
/*!50001 DROP VIEW IF EXISTS `placementdetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `placementdetails` AS SELECT 
 1 AS `Student_Name`,
 1 AS `Branch`,
 1 AS `Company_Name`,
 1 AS `OfferType`,
 1 AS `Stipend`,
 1 AS `Package`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `Registration_No` int NOT NULL,
  `Name` varchar(40) NOT NULL,
  `Section` varchar(10) NOT NULL,
  `Branch` varchar(20) NOT NULL,
  PRIMARY KEY (`Registration_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (101,'Rahul','A','CSE'),(102,'Ananya','B','ECE'),(104,'Priya','C','ECE'),(105,'Kunal','E','Civil'),(1212,'ada','b','se');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `placementdetails`
--

/*!50001 DROP VIEW IF EXISTS `placementdetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `placementdetails` AS select `s`.`Name` AS `Student_Name`,`s`.`Branch` AS `Branch`,`c`.`Company_Name` AS `Company_Name`,`p`.`OfferType` AS `OfferType`,`p`.`Stipend` AS `Stipend`,`p`.`Package` AS `Package` from ((`placement` `p` join `student` `s` on((`p`.`Registration_No` = `s`.`Registration_No`))) join `company` `c` on((`p`.`Company_ID` = `c`.`Company_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-18 11:45:57
