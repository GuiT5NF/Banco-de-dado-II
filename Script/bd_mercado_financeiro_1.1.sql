-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mercado_financeiro
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `composicao_indices`
--

DROP TABLE IF EXISTS `composicao_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composicao_indices` (
  `id_composicao` varchar(45) DEFAULT NULL,
  `empresas_id_empresas` int(11) DEFAULT NULL,
  `indices_id_indice` int(11) DEFAULT NULL,
  `peso` varchar(45) DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `data_fim` date DEFAULT NULL,
  KEY `empresas_id_empresas` (`empresas_id_empresas`),
  KEY `indices_id_indice` (`indices_id_indice`),
  CONSTRAINT `composicao_indices_ibfk_1` FOREIGN KEY (`empresas_id_empresas`) REFERENCES `empresas` (`id_empresas`),
  CONSTRAINT `composicao_indices_ibfk_2` FOREIGN KEY (`indices_id_indice`) REFERENCES `indices` (`id_indices`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composicao_indices`
--

LOCK TABLES `composicao_indices` WRITE;
/*!40000 ALTER TABLE `composicao_indices` DISABLE KEYS */;
/*!40000 ALTER TABLE `composicao_indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacoes_historicos`
--

DROP TABLE IF EXISTS `cotacoes_historicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacoes_historicos` (
  `id_cotacoes` int(11) NOT NULL,
  `empresas_id_empresas` int(11) DEFAULT NULL,
  `data_cotacao` date DEFAULT NULL,
  `abertura` float DEFAULT NULL,
  `fechamento` float DEFAULT NULL,
  `maximo` float DEFAULT NULL,
  `minimo` float DEFAULT NULL,
  `volume` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_cotacoes`),
  KEY `empresas_id_empresas` (`empresas_id_empresas`),
  CONSTRAINT `cotacoes_historicos_ibfk_1` FOREIGN KEY (`empresas_id_empresas`) REFERENCES `empresas` (`id_empresas`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacoes_historicos`
--

LOCK TABLES `cotacoes_historicos` WRITE;
/*!40000 ALTER TABLE `cotacoes_historicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacoes_historicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacoes_indices`
--

DROP TABLE IF EXISTS `cotacoes_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacoes_indices` (
  `id_cotacoes_indices` int(11) NOT NULL,
  `indices_id_indice` int(11) DEFAULT NULL,
  `data_cotacao` date DEFAULT NULL,
  `abertura` float DEFAULT NULL,
  `fechamento` float DEFAULT NULL,
  `maximo` float DEFAULT NULL,
  `minimo` float DEFAULT NULL,
  PRIMARY KEY (`id_cotacoes_indices`),
  KEY `indices_id_indice` (`indices_id_indice`),
  CONSTRAINT `cotacoes_indices_ibfk_1` FOREIGN KEY (`indices_id_indice`) REFERENCES `indices` (`id_indices`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacoes_indices`
--

LOCK TABLES `cotacoes_indices` WRITE;
/*!40000 ALTER TABLE `cotacoes_indices` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacoes_indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dados_economicos`
--

DROP TABLE IF EXISTS `dados_economicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dados_economicos` (
  `id_dados_economicos` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `tipo_dado` varchar(45) DEFAULT NULL,
  `valor` float DEFAULT NULL,
  PRIMARY KEY (`id_dados_economicos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dados_economicos`
--

LOCK TABLES `dados_economicos` WRITE;
/*!40000 ALTER TABLE `dados_economicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `dados_economicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id_empresas` int(11) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `ticker` char(5) DEFAULT NULL,
  `setor_id_setor` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_empresas`),
  KEY `setor_id_setor` (`setor_id_setor`),
  CONSTRAINT `empresas_ibfk_1` FOREIGN KEY (`setor_id_setor`) REFERENCES `setor` (`id_setor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indices`
--

DROP TABLE IF EXISTS `indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indices` (
  `id_indices` int(11) NOT NULL,
  `nome_indices` varchar(100) DEFAULT NULL,
  `sigla` varchar(6) DEFAULT NULL,
  `pais_id_pais` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_indices`),
  KEY `pais_id_pais` (`pais_id_pais`),
  CONSTRAINT `indices_ibfk_1` FOREIGN KEY (`pais_id_pais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indices`
--

LOCK TABLES `indices` WRITE;
/*!40000 ALTER TABLE `indices` DISABLE KEYS */;
/*!40000 ALTER TABLE `indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `id_pais` int(11) NOT NULL,
  `nome_pais` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setor`
--

DROP TABLE IF EXISTS `setor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setor` (
  `id_setor` int(11) NOT NULL,
  `nome_setor` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_setor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setor`
--

LOCK TABLES `setor` WRITE;
/*!40000 ALTER TABLE `setor` DISABLE KEYS */;
/*!40000 ALTER TABLE `setor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-27 22:05:25
