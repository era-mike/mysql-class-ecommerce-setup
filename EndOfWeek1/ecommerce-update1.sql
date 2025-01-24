-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: 127.0.0.1    Database: my_ecommerce
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Electronics'),(2,'Clothing'),(3,'Books'),(4,'Home Appliances');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John','Doe','john.doe@example.com'),(2,'Jane','Smith','jane.smith@example.com'),(3,'Bob','Johnson','bob.johnson@example.com'),(4,'Alice','Brown','alice.brown@example.com'),(5,'Chris','Miller','chris.miller@example.com'),(6,'Alex','Johnson','alex.johnson@example.com');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price` decimal(8,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `fk_order` (`order_id`),
  KEY `fk_product` (`product_id`),
  CONSTRAINT `fk_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,1,199.99),(2,1,10,2,9.99),(3,1,19,1,12.50),(4,2,18,1,14.99),(5,2,17,1,14.99);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `total_amount` decimal(8,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `expected_delivery_date` date DEFAULT NULL,
  `actual_delivery_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_customer` (`customer_id`),
  CONSTRAINT `fk_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,129.97,'completed','2024-12-17 18:02:06','2025-01-02','2025-01-02'),(2,2,72.97,'completed','2024-12-17 18:02:06','2025-01-02','2025-01-02'),(3,4,404.92,'pending','2024-12-17 00:00:00','2024-12-20',NULL),(4,2,212.56,'completed','2024-12-16 00:00:00','2024-12-19','2024-12-20'),(5,2,373.61,'processing','2024-12-17 00:00:00','2024-12-20',NULL),(6,3,494.13,'completed','2024-12-17 00:00:00','2024-12-20','2024-12-21'),(7,3,285.52,'completed','2024-12-18 00:00:00','2024-12-21','2024-12-22'),(8,5,142.68,'processing','2024-12-18 00:00:00','2024-12-21',NULL),(9,1,407.82,'pending','2024-12-17 00:00:00','2024-12-20',NULL),(10,5,182.90,'completed','2024-12-16 00:00:00','2024-12-19','2024-12-20');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(8,2) NOT NULL,
  `category_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `stock_available` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`product_id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_stock_positive` CHECK ((`stock_available` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Smartphone A1','Budget smartphone',199.99,1,'2025-01-16 18:02:06',150),(2,'Smartphone B2','Mid-range smartphone',299.99,1,'2025-01-16 18:02:06',0),(3,'Smartphone C3','Premium smartphone',999.99,1,'2025-01-16 18:02:06',0),(4,'Wireless Earbuds','Noise-canceling earbuds',49.99,1,'2025-01-16 18:02:06',50),(5,'Laptop Basic','Entry-level laptop',399.99,1,'2025-01-16 18:02:06',0),(6,'Gaming Laptop','High-performance gaming laptop',1299.99,1,'2025-01-16 18:02:06',0),(7,'4K TV','Ultra HD television',799.99,1,'2025-01-16 18:02:06',0),(8,'Bluetooth Speaker','Portable speaker',59.99,1,'2025-01-16 18:02:06',50),(9,'USB-C Charger','Fast charging adapter',19.99,1,'2025-01-16 18:02:06',50),(10,'T-Shirt S','Basic small T-shirt',9.99,2,'2025-01-16 18:02:06',50),(11,'T-Shirt L','Basic large T-shirt',11.99,2,'2025-01-16 18:02:06',50),(12,'Jeans Skinny','Skinny jeans style',39.99,2,'2025-01-16 18:02:06',50),(13,'Jeans Regular','Regular fit jeans',45.99,2,'2025-01-16 18:02:06',50),(14,'Summer Dress','Lightweight summer dress',29.99,2,'2025-01-16 18:02:06',50),(15,'Hoodie','Warm hoodie',49.99,2,'2025-01-16 18:02:06',50),(16,'Jacket','Winter jacket',89.99,2,'2025-01-16 18:02:06',50),(17,'Socks (5-pack)','Cotton socks, pack of 5',14.99,2,'2025-01-16 18:02:06',50),(18,'Mystery Novel','A thrilling mystery book',12.50,3,'2025-01-16 18:02:06',50),(19,'Romance Novel','A heartwarming romance story',14.99,3,'2025-01-16 18:02:06',50),(20,'Science Fiction Novel','Futuristic space adventure',16.99,3,'2025-01-16 18:02:06',50),(21,'Cookbook','Delicious recipes for beginners',19.99,3,'2025-01-16 18:02:06',50),(22,'Self-Help Book','Personal growth and productivity',21.50,3,'2025-01-16 18:02:06',50),(23,'Children Book A','Illustrated children story',8.99,3,'2025-01-16 18:02:06',50),(24,'Children Book B','Educational children story',7.99,3,'2025-01-16 18:02:06',50),(25,'Wireless Headphones',NULL,120.00,1,'2025-01-17 16:18:46',50),(26,'Wireless Headphones 2',NULL,120.00,1,'2025-01-17 16:19:36',50),(27,'Wireless Headphones','These phones are for your head!',120.00,1,'2025-01-17 16:21:13',150),(28,'Wireless Headphones 2','These phones are for your head!',120.00,1,'2025-01-17 16:21:13',50),(29,'Smart Microwave','A microwave with smart features.',199.99,4,'2025-01-17 20:50:37',0);
update products set created_at = '2024-01-01' where product_id > 0;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'my_ecommerce'
--

--
-- Dumping routines for database 'my_ecommerce'---
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-20 19:14:03
