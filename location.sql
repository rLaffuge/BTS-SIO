CREATE DATABASE  IF NOT EXISTS `location` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `location`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: rlaffuge.ddns.net    Database: location
-- ------------------------------------------------------
-- Server version	5.5.41-0+wheezy1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `emprunteur`
--

DROP TABLE IF EXISTS `emprunteur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emprunteur` (
  `idemprunteur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idemprunteur`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprunteur`
--

LOCK TABLES `emprunteur` WRITE;
/*!40000 ALTER TABLE `emprunteur` DISABLE KEYS */;
INSERT INTO `emprunteur` VALUES (1,'Deray','Odile'),(2,'Karamazov','Serge'),(3,'Jérémi','Simon'),(4,'Bialès','Patrick'),(5,'Deray','Odile'),(6,'Laffuge','Rémy'),(8,'Laffuge','Rémy'),(9,'Laffuge','Rémy');
/*!40000 ALTER TABLE `emprunteur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entretien`
--

DROP TABLE IF EXISTS `entretien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entretien` (
  `identretien` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `releveKm` int(11) DEFAULT NULL,
  `description` mediumtext,
  `vehicule_idvehicule` int(11) NOT NULL,
  PRIMARY KEY (`identretien`),
  KEY `fk_entretien_vehicule1_idx` (`vehicule_idvehicule`),
  CONSTRAINT `fk_entretien_vehicule1` FOREIGN KEY (`vehicule_idvehicule`) REFERENCES `vehicule` (`idvehicule`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entretien`
--

LOCK TABLES `entretien` WRITE;
/*!40000 ALTER TABLE `entretien` DISABLE KEYS */;
/*!40000 ALTER TABLE `entretien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etatlieux`
--

DROP TABLE IF EXISTS `etatlieux`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etatlieux` (
  `idetatLieux` int(11) NOT NULL AUTO_INCREMENT,
  `moment` enum('avant','après') DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `photo` longblob,
  `urgenceEntretien` tinyint(1) DEFAULT NULL,
  `location_idlocation` int(11) NOT NULL,
  PRIMARY KEY (`idetatLieux`),
  KEY `fk_etatLieux_location1_idx` (`location_idlocation`),
  CONSTRAINT `fk_etatLieux_location1` FOREIGN KEY (`location_idlocation`) REFERENCES `location` (`idlocation`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etatlieux`
--

LOCK TABLES `etatlieux` WRITE;
/*!40000 ALTER TABLE `etatlieux` DISABLE KEYS */;
/*!40000 ALTER TABLE `etatlieux` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `idlocation` int(11) NOT NULL AUTO_INCREMENT,
  `dateDebut` datetime DEFAULT NULL,
  `dateRetourPrevue` datetime DEFAULT NULL,
  `dateRetourReelle` datetime DEFAULT NULL,
  `releveKmDebut` int(11) DEFAULT NULL,
  `releveKmFin` int(11) DEFAULT NULL,
  `vehicule_idvehicule` int(11) NOT NULL,
  `emprunteur_idemprunteur` int(11) NOT NULL,
  PRIMARY KEY (`idlocation`),
  KEY `fk_location_vehicule_idx` (`vehicule_idvehicule`),
  KEY `fk_location_emprunteur1_idx` (`emprunteur_idemprunteur`),
  CONSTRAINT `fk_location_emprunteur1` FOREIGN KEY (`emprunteur_idemprunteur`) REFERENCES `emprunteur` (`idemprunteur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_location_vehicule` FOREIGN KEY (`vehicule_idvehicule`) REFERENCES `vehicule` (`idvehicule`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilisateur` (
  `idutilisateur` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(45) NOT NULL,
  `hashPassword` varchar(45) NOT NULL,
  `salt` char(64) NOT NULL,
  `role` enum('admin','editor') NOT NULL,
  `derniereConnexion` timestamp NULL DEFAULT NULL,
  `dernierEchecConnexion` timestamp NULL DEFAULT NULL,
  `nombreEchecConnexion` int(11) DEFAULT NULL,
  PRIMARY KEY (`idutilisateur`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'admin','2c624232cdd221771294dfbb310aca000a0df6ac8b66b','8def3bf5d78abb247b4829e87b52b10d79b1cd0e2aec529930ed692ee8d1cd2c','admin',NULL,NULL,0);
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicule`
--

DROP TABLE IF EXISTS `vehicule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicule` (
  `idvehicule` int(11) NOT NULL AUTO_INCREMENT,
  `immatriculation` char(9) NOT NULL,
  `dateMiseCirculation` date DEFAULT NULL,
  `marque` varchar(45) DEFAULT NULL,
  `modele` varchar(45) DEFAULT NULL,
  `energie` enum('essence','diesel') DEFAULT NULL,
  `releveKm` int(11) DEFAULT NULL,
  `prochaineRevisionKm` int(11) DEFAULT NULL,
  PRIMARY KEY (`idvehicule`),
  UNIQUE KEY `immatriculation_UNIQUE` (`immatriculation`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicule`
--

LOCK TABLES `vehicule` WRITE;
/*!40000 ALTER TABLE `vehicule` DISABLE KEYS */;
INSERT INTO `vehicule` VALUES (2,'AA-456-KK','2014-01-12','Peugeot','308','diesel',4000,15000),(65,'SG-123-BB','2014-01-07','Peugeot','208','diesel',2000,200),(68,'SM-123-BB','2014-01-09','Peugeot','406','diesel',2000,10000),(83,'GR-452-JH','2015-02-16','Peugeot','1007','essence',152300,5000),(96,'WS-843-BV','2007-05-15','Citroen','Picasso','diesel',250000,5000),(97,'LE-235-GF','2005-12-24','Seat','Leon','essence',506248,15000),(98,'EF-666-CS','2000-03-12','Nissan','Primera','diesel',280000,10000),(100,'HG-164-SQ','2015-03-20','SEAT','IBIZA','essence',160000,15000),(105,'FT-412-VC','2015-03-16','SEAT','Toledo','diesel',500000,600),(106,'HG-741-AZ','2015-03-17','Renaud','Berlingo','diesel',163015,3000),(112,'FD-741-AQ','2014-01-11','Peugeot','308','diesel',4000,15000),(113,'CV-716-QS','2015-03-11','Frefe','fefef','diesel',5151,5151),(114,'PL-345-ML','2015-03-18','jhv','kbhjvf','essence',51515,6262),(123,'',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `vehicule` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER before_update_vehicule 
BEFORE update ON vehicule
FOR EACH ROW  
	BEGIN            
	IF NOT EXISTS (SELECT * FROM vehiculeRevision       
				WHERE idvehicule = NEW.idvehicule)    
		THEN    
                IF NEW.prochaineRevisionKm <= 1000     
					THEN      
						INSERT INTO vehiculeRevision VALUES (NEW.idvehicule, NEW.immatriculation);    
                END IF;                
	END IF;           
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `vehiculeRevision`
--

DROP TABLE IF EXISTS `vehiculeRevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehiculeRevision` (
  `idvehicule` int(11) NOT NULL,
  `immatriculation` char(9) NOT NULL,
  PRIMARY KEY (`idvehicule`),
  UNIQUE KEY `immatriculation_UNIQUE` (`immatriculation`),
  KEY `fk_vehicule_idx` (`idvehicule`,`immatriculation`),
  CONSTRAINT `fk_vehicule` FOREIGN KEY (`idvehicule`) REFERENCES `vehicule` (`idvehicule`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Table contenant les vehicules à réviser';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehiculeRevision`
--

LOCK TABLES `vehiculeRevision` WRITE;
/*!40000 ALTER TABLE `vehiculeRevision` DISABLE KEYS */;
INSERT INTO `vehiculeRevision` VALUES (105,'FT-412-VC'),(65,'SG-123-BB');
/*!40000 ALTER TABLE `vehiculeRevision` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `location`.`after_delete_revision`
AFTER DELETE ON vehiculeRevision
FOR EACH ROW
BEGIN
    UPDATE vehicule V
    SET V.prochaineRevisionKm = 15000
    WHERE V.idvehicule = OLD.idvehicule;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'location'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-19 16:03:37
