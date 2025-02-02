-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: localhost    Database: testewk
-- ------------------------------------------------------
-- Server version	5.5.62

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cidade` varchar(40) NOT NULL,
  `UF` varchar(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `clientes_nome_IDX` (`nome`) USING BTREE,
  KEY `clientes_UF_IDX` (`UF`,`cidade`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (41,'JONAS DA SILVA','CAMPINAS','SP'),(42,'MARIA COSTA E SILVA','VALINHOS','SP'),(43,'LEONARDO SENNA DA CRUZ','BELO HORIZONTE','MG'),(44,'SERGIO EDUARDO MENDES','CONTAGEM','MG'),(45,'NELSON ARAUJO CORREIA','AMPARO','SP'),(46,'MARLENA DE CASTRO','SERRA NEGRA','SP'),(47,'GERALDO CRUZ DE LIMA','BELO HORIZONTE','MG'),(48,'SIRLEY CUNHA DE FARIA','CONTAGEM','MG'),(49,'HELANA GOMES DE OLIVEIRA','RIO DE JANEIRO','RJ'),(50,'SILVANA LIMA DE ARAUJO','VALINHOS','SP'),(51,'LEO SOARES DO NASCIMENTO','BELO HORIZONTE','MG'),(52,'ALVARES RIVALDO FIGUEREDO','CONTAGEM','MG'),(53,'NELSON BRAGA CORREIA','AMPARO','SP'),(54,'MARCELA CASTRO WILL','SERRA NEGRA','SP'),(55,'MARCOS CORREIA DE LIMA','AMPARO','SP'),(56,'MARLENA CASTILHO E SILVA','PARATI','RJ'),(57,'GERALDO LEORNADO GIL','BELO HORIZONTE','MG'),(58,'FERNANDA CRISTINA GOMES','CONTAGEM','MG'),(59,'VITORIA OLIVEIRA LUIZ','CAMPINAS','SP'),(60,'SILVIA ARAUJO TONOI','RIO DE JANEIRO','RJ');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `idpedido` bigint(20) NOT NULL AUTO_INCREMENT,
  `dt_emissao` date NOT NULL,
  `idcliente` bigint(20) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idpedido`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2025-01-31',43,125.30),(2,'2025-01-31',43,33.56),(5,'2025-01-31',55,36.80),(6,'2025-01-31',43,30.20),(8,'2025-01-31',43,69.00),(9,'2025-01-31',43,88.40),(13,'2025-01-31',43,51.49),(14,'2025-01-31',43,24.52),(16,'2025-01-31',41,0.00),(17,'2025-01-31',52,14.15),(18,'2025-01-31',52,58.21),(19,'2025-01-31',52,0.00),(20,'2025-01-31',43,34.06),(22,'2025-01-31',58,176.40),(23,'2025-01-31',58,183.00),(24,'2025-01-31',53,78.00),(25,'2025-01-31',56,56.70),(26,'2025-01-31',50,38.16),(27,'2025-01-31',58,30.40),(28,'2025-01-31',60,133.20),(29,'2025-01-31',60,93.60),(30,'2025-01-31',57,7.00),(31,'2025-01-31',56,90.20),(32,'2025-02-01',46,0.00),(33,'2025-02-01',54,0.00),(34,'2025-02-01',44,52.80),(35,'2025-02-02',44,9.56),(37,'2025-02-02',44,11.27),(38,'2025-02-02',54,11.24),(40,'2025-02-02',44,17.42),(41,'2025-02-02',54,29.86),(42,'2025-02-02',54,0.00),(43,'2025-02-02',46,0.00),(44,'2025-02-02',41,0.00),(45,'2025-02-02',56,153.93),(47,'2025-02-02',45,0.00);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_produtos`
--

DROP TABLE IF EXISTS `pedidos_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos_produtos` (
  `idpedidos_produtos` bigint(20) NOT NULL AUTO_INCREMENT,
  `idpedido` bigint(20) NOT NULL,
  `idproduto` bigint(20) NOT NULL,
  `quantidade` decimal(10,4) NOT NULL,
  `valor_unitario` decimal(10,4) NOT NULL,
  `valor_total` decimal(10,4) NOT NULL,
  PRIMARY KEY (`idpedidos_produtos`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_produtos`
--

LOCK TABLES `pedidos_produtos` WRITE;
/*!40000 ALTER TABLE `pedidos_produtos` DISABLE KEYS */;
INSERT INTO `pedidos_produtos` VALUES (1,1,7,1.0000,11.4000,11.4000),(2,1,9,3.0000,8.0000,24.0000),(3,1,17,1.0000,40.4000,40.4000),(4,1,4,1.9000,5.0000,9.5000),(5,1,19,5.0000,8.0000,40.0000),(6,2,8,2.0000,4.1500,8.3000),(7,2,18,2.8700,8.8000,25.2560),(11,6,5,3.0000,3.8000,11.4000),(12,6,15,2.4100,7.8000,18.7980),(14,8,9,3.5000,8.0000,28.0000),(15,8,15,3.0000,7.8000,23.4000),(16,8,18,2.0000,8.8000,17.6000),(17,9,19,4.0000,8.0000,32.0000),(18,9,3,2.0000,3.5000,7.0000),(19,9,13,5.0000,9.0000,45.0000),(20,9,20,1.0000,4.4000,4.4000),(26,13,6,3.0000,3.0000,9.0000),(27,13,16,3.5410,12.0000,42.4920),(28,14,11,1.0000,9.9000,9.9000),(29,14,14,3.4400,4.2500,14.6200),(30,17,14,1.0000,4.2500,4.2500),(31,17,11,1.0000,9.9000,9.9000),(32,18,2,2.7640,7.8000,21.5592),(33,18,4,7.3300,5.0000,36.6500),(35,20,5,3.0000,3.8000,11.4000),(36,20,8,5.4600,4.1500,22.6590),(40,22,16,8.0000,12.0000,96.0000),(41,22,10,12.0000,6.7000,80.4000),(42,23,15,22.0000,7.8000,171.6000),(43,23,5,3.0000,3.8000,11.4000),(44,24,15,10.0000,7.8000,78.0000),(45,25,3,2.0000,3.5000,7.0000),(46,25,11,2.0000,9.9000,19.8000),(47,25,1,5.0000,5.9800,29.9000),(48,26,9,4.7700,8.0000,38.1600),(49,27,5,8.0000,3.8000,30.4000),(50,28,11,10.0000,9.9000,99.0000),(52,28,7,3.0000,11.4000,34.2000),(53,5,7,1.0000,11.4000,11.4000),(55,5,8,4.0000,4.1500,16.6000),(56,5,18,1.0000,8.8000,8.8000),(57,29,15,12.0000,7.8000,93.6000),(58,30,3,2.0000,3.5000,7.0000),(59,31,7,3.0000,11.4000,34.2000),(60,31,19,7.0000,8.0000,56.0000),(62,34,18,5.0000,8.8000,44.0000),(63,34,18,1.0000,8.8000,8.8000),(68,35,1,1.5980,5.9800,9.5560),(71,37,1,1.8850,5.9800,11.2723),(72,38,1,1.8800,5.9800,11.2424),(74,40,1,1.1234,5.9852,6.7238),(75,40,2,1.3546,7.8954,10.6951),(78,41,1,1.2354,5.9887,7.3984),(79,41,2,2.8640,7.8412,22.4572),(81,45,19,3.0000,8.0000,24.0000),(82,45,5,3.0000,3.8000,11.4000),(83,45,7,5.5000,11.4000,62.7000),(84,45,7,1.0000,11.4000,11.4000),(85,45,9,5.6330,7.8880,44.4331);
/*!40000 ALTER TABLE `pedidos_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtos` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `preco_venda` decimal(10,2) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `produtos_descricao_IDX` (`descricao`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'CENOURA',5.98),(2,'BATATA INGLESA',7.80),(3,'SAL',3.50),(4,'CEBOLA',5.00),(5,'ALFACE',3.80),(6,'COUVE',3.00),(7,'QUEIJO',11.40),(8,'MELANCIA',4.15),(9,'TOMATE',8.00),(10,'LEITE',6.70),(11,'DOCE DE LEITE',9.90),(12,'ARROZ',33.30),(13,'FEIJAO',9.00),(14,'ALHO',4.25),(15,'LARANJA LIMA',7.80),(16,'MUSSARELA FATIADA',12.00),(17,'ARROZ INTEGRAL',40.40),(18,'OLEO DE SOJA',8.80),(19,'FARINHA DE TRIGO',8.00),(20,'FERMENTO EM PO',4.40);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'testewk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-02 17:03:11
