-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2024 at 07:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamestore`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `show_all_products` ()   BEGIN
    SELECT p.product_id, p.name, c.name category, p.original_price, p.sale_price, p.stock
    FROM Products p
    JOIN categories c ON c.category_id = p.category_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `show_products_by_category_and_price` (IN `p_category_id` INT, IN `p_max_sale_price` DECIMAL(10,2))   BEGIN
    DECLARE product_count INT;

    SELECT COUNT(*) INTO product_count
    FROM Products
    WHERE category_id = p_category_id AND sale_price <= p_max_sale_price;

    IF product_count > 0 THEN
        SELECT product_id, name, category_id, original_price, sale_price, stock
        FROM Products
        WHERE category_id = p_category_id AND sale_price <= p_max_sale_price;
    ELSE
        SELECT 'No products found' AS message;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `count_by_category_and_price` (`p_category_id` INT, `p_max_sale_price` DECIMAL(10,2)) RETURNS INT(11)  BEGIN
    DECLARE product_count INT;

    SELECT COUNT(*) INTO product_count
    FROM Products
    WHERE category_id = p_category_id AND sale_price <= p_max_sale_price;

    RETURN product_count;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `count_total_game` () RETURNS INT(11)  BEGIN
    DECLARE total_count INT;

    SELECT COUNT(*) INTO total_count
    FROM Products
    WHERE category_id = 1;

    RETURN total_count;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'Game'),
(2, 'Console'),
(3, 'Accessory');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `registration_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `name`, `email`, `registration_date`) VALUES
(1, 'Kiki', 'kiki@gmail.com', '2024-01-01'),
(2, 'Ajril', 'ajril@gmail.com', '2024-02-01'),
(3, 'Fatah', 'fatah@gmail.com', '2024-03-01'),
(4, 'Ali', 'ali@gmail.com', '2024-04-01'),
(5, 'Hani', 'hani@gmail.com.com', '2024-05-01'),
(6, 'Sophia', 'sophia@gmail.com', '2024-06-01'),
(7, 'Rama', 'rama@gmail.com', '2024-07-01'),
(8, 'Amy', 'amy@egmail.com', '2024-08-01'),
(9, 'Diyu', 'diyu@gmail.com', '2024-09-01'),
(10, 'Ridwan', 'ridwan@gmail.com', '2024-10-01');

-- --------------------------------------------------------

--
-- Stand-in structure for view `high_price_products`
-- (See below for the actual view)
--
CREATE TABLE `high_price_products` (
`product_id` int(11)
,`name` varchar(100)
,`category_id` int(11)
,`sale_price` decimal(10,2)
,`stock` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `orderitems`
--

CREATE TABLE `orderitems` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitems`
--

INSERT INTO `orderitems` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 2, 699000.00),
(2, 2, 2, 2, 849000.00),
(3, 3, 6, 1, 7999000.00),
(4, 4, 3, 1, 549000.00),
(5, 5, 11, 1, 1049000.00),
(6, 6, 12, 1, 949000.00),
(7, 7, 18, 1, 699000.00),
(8, 8, 14, 1, 949000.00),
(9, 9, 32, 1, 649000.00),
(10, 10, 5, 2, 599000.00);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total`) VALUES
(1, 1, '2024-07-15', 1498000.00),
(2, 2, '2024-06-18', 1498000.00),
(3, 3, '2024-07-12', 7999000.00),
(4, 4, '2024-06-25', 549000.00),
(5, 5, '2024-06-30', 1049000.00),
(6, 1, '2024-07-01', 999000.00),
(7, 2, '2024-07-05', 849000.00),
(8, 3, '2024-06-20', 1049000.00),
(9, 4, '2024-07-03', 699000.00),
(10, 5, '2024-06-22', 1249000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `over500k_products`
-- (See below for the actual view)
--
CREATE TABLE `over500k_products` (
`product_id` int(11)
,`name` varchar(100)
,`category_id` int(11)
,`sale_price` decimal(10,2)
,`stock` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `productlogs`
--

CREATE TABLE `productlogs` (
  `log_id` int(11) NOT NULL,
  `operation` varchar(20) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `log_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productlogs`
--

INSERT INTO `productlogs` (`log_id`, `operation`, `product_id`, `name`, `category_id`, `original_price`, `sale_price`, `stock`, `log_date`) VALUES
(1, 'BEFORE INSERT', NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-14 12:46:27'),
(2, 'AFTER INSERT', 36, 'Resident Evil 4', 1, 549000.00, 599000.00, 200, '2024-07-14 12:46:27'),
(3, 'BEFORE UPDATE', 36, 'Resident Evil 4', 1, 549000.00, 599000.00, 200, '2024-07-14 13:24:33'),
(4, 'AFTER UPDATE', 36, 'Resident Evil 4 Remake', 1, 549000.00, 599000.00, 200, '2024-07-14 13:24:33'),
(5, 'BEFORE DELETE', 29, 'Battlefield 2042', 1, 849000.00, 899000.00, 140, '2024-07-14 13:33:18'),
(6, 'AFTER DELETE', NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-14 13:33:18'),
(7, 'BEFORE INSERT', NULL, NULL, NULL, NULL, NULL, NULL, '2024-07-14 14:44:46'),
(8, 'AFTER INSERT', 37, 'Elden Ring', NULL, NULL, 599000.00, NULL, '2024-07-14 14:44:46'),
(9, 'BEFORE UPDATE', 37, 'Elden Ring', NULL, NULL, 599000.00, NULL, '2024-07-14 14:48:05'),
(10, 'AFTER UPDATE', 37, 'Elden Ring: Shadow of the Erdtree', NULL, NULL, 800000.00, NULL, '2024-07-14 14:48:05');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `original_price` decimal(10,2) DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `category_id`, `original_price`, `sale_price`, `stock`) VALUES
(1, 'God of War', 1, 699000.00, 749000.00, 200),
(2, 'The Last of Us Part II', 1, 849000.00, 899000.00, 150),
(3, 'Red Dead Redemption 2', 1, 549000.00, 599000.00, 100),
(4, 'Cyberpunk 2077', 1, 449000.00, 499000.00, 200),
(5, 'Final Fantasy VII Remake', 1, 849000.00, 899000.00, 120),
(6, 'PlayStation 5', 2, 7949000.00, 7999000.00, 50),
(7, 'Xbox Series X', 2, 7949000.00, 7999000.00, 50),
(8, 'Nintendo Switch', 2, 4249000.00, 4299000.00, 75),
(9, 'PlayStation 4', 2, 4449000.00, 4499000.00, 80),
(10, 'Xbox One', 2, 4449000.00, 4499000.00, 60),
(11, 'DualSense Wireless Controller', 3, 1049000.00, 1099000.00, 150),
(12, 'Xbox Wireless Controller', 3, 949000.00, 999000.00, 150),
(13, 'Nintendo Switch Pro Controller', 3, 1049000.00, 1099000.00, 100),
(14, 'PlayStation 5 HD Camera', 3, 949000.00, 999000.00, 90),
(15, 'Xbox Play and Charge Kit', 3, 349000.00, 399000.00, 200),
(16, 'The Legend of Zelda: Breath of the Wild', 1, 849000.00, 899000.00, 150),
(17, 'Halo Infinite', 1, 849000.00, 899000.00, 100),
(18, 'Ghost of Tsushima', 1, 699000.00, 749000.00, 130),
(19, 'Marvel\'s Spider-Man: Miles Morales', 1, 699000.00, 749000.00, 150),
(20, 'Animal Crossing: New Horizons', 1, 849000.00, 899000.00, 140),
(21, 'Super Mario Odyssey', 1, 699000.00, 749000.00, 150),
(22, 'Sekiro: Shadows Die Twice', 1, 549000.00, 599000.00, 100),
(23, 'Resident Evil Village', 1, 849000.00, 899000.00, 110),
(24, 'Assassin\'s Creed Valhalla', 1, 699000.00, 749000.00, 120),
(25, 'FIFA 23', 1, 849000.00, 899000.00, 200),
(26, 'NBA 2K23', 1, 849000.00, 899000.00, 200),
(27, 'Madden NFL 23', 1, 849000.00, 899000.00, 180),
(28, 'Call of Duty: Modern Warfare II', 1, 1049000.00, 1099000.00, 150),
(30, 'Far Cry 6', 1, 849000.00, 899000.00, 130),
(31, 'Monster Hunter: World', 1, 549000.00, 599000.00, 150),
(32, 'Monster Hunter Rise', 1, 649000.00, 699000.00, 100),
(33, 'Resident Evil 2', 1, 449000.00, 499000.00, 120),
(34, 'Resident Evil 3', 1, 449000.00, 499000.00, 120),
(35, 'Resident Evil 7: Biohazard', 1, 549000.00, 599000.00, 100),
(36, 'Resident Evil 4 Remake', 1, 549000.00, 599000.00, 200),
(37, 'Elden Ring: Shadow of the Erdtree', NULL, NULL, 800000.00, NULL);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `after_delete_product` AFTER DELETE ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('AFTER DELETE', NULL, NULL, NULL, NULL, NULL, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_product` AFTER INSERT ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('AFTER INSERT', NEW.product_id, NEW.name, NEW.category_id, NEW.original_price, NEW.sale_price, NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_product` AFTER UPDATE ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('AFTER UPDATE', NEW.product_id, NEW.name, NEW.category_id, NEW.original_price, NEW.sale_price, NEW.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_product` BEFORE DELETE ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('BEFORE DELETE', OLD.product_id, OLD.name, OLD.category_id, OLD.original_price, OLD.sale_price, OLD.stock);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_product` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('BEFORE INSERT', NULL, NULL, NULL, NULL, NULL, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_product` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
    INSERT INTO ProductLogs (operation, product_id, name, category_id, original_price, sale_price, stock)
    VALUES ('BEFORE UPDATE', OLD.product_id, OLD.name, OLD.category_id, OLD.original_price, OLD.sale_price, OLD.stock);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `product_summary`
-- (See below for the actual view)
--
CREATE TABLE `product_summary` (
`product_id` int(11)
,`name` varchar(100)
,`sale_price` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `review_text` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `review_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `customer_id`, `product_id`, `review_text`, `rating`, `review_date`) VALUES
(1, 1, 1, 'Game yang sangat seru dan grafisnya luar biasa!', 5, '2024-07-16'),
(2, 2, 2, 'Pengalaman bermain yang mendalam dan emosional.', 4, '2024-06-19'),
(3, 3, 6, 'Konsol terbaik yang pernah saya miliki.', 5, '2024-07-13'),
(4, 4, 3, 'Cerita yang menarik dan gameplay yang seru.', 4, '2024-06-26'),
(5, 5, 11, 'Kontroler yang nyaman dan responsif.', 5, '2024-07-01'),
(6, 1, 12, 'Desain ergonomis, sangat nyaman digunakan.', 4, '2024-07-02'),
(7, 2, 18, 'Permainan yang menantang dan sangat memuaskan.', 5, '2024-07-06'),
(8, 3, 14, 'Kamera dengan kualitas gambar yang sangat baik.', 4, '2024-06-21'),
(9, 4, 32, 'Permainan dengan alur cerita yang menarik.', 4, '2024-07-04'),
(10, 5, 5, 'Game klasik yang harus dimiliki setiap penggemar RPG.', 5, '2024-06-23');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sale_date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supplierproducts`
--

CREATE TABLE `supplierproducts` (
  `supplier_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplierproducts`
--

INSERT INTO `supplierproducts` (`supplier_id`, `product_id`) VALUES
(1, 6),
(1, 9),
(1, 14),
(2, 7),
(2, 10),
(2, 12),
(2, 15),
(3, 8),
(3, 13),
(4, 3),
(5, 4),
(6, 5),
(7, 24),
(7, 30),
(8, 25),
(8, 27),
(11, 31),
(11, 32),
(11, 33),
(11, 34),
(11, 35);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `name`, `contact_email`) VALUES
(1, 'Sony', 'contact@sony.com'),
(2, 'Microsoft', 'contact@microsoft.com'),
(3, 'Nintendo', 'contact@nintendo.com'),
(4, 'Rockstar Games', 'contact@rockstargames.com'),
(5, 'CD Projekt', 'contact@cdprojekt.com'),
(6, 'Square Enix', 'contact@square-enix.com'),
(7, 'Ubisoft', 'contact@ubisoft.com'),
(8, 'EA Sports', 'contact@ea.com'),
(9, 'Activision', 'contact@activision.com'),
(10, 'Bethesda', 'contact@bethesda.com'),
(11, 'Capcom', 'contact@capcom.com');

-- --------------------------------------------------------

--
-- Stand-in structure for view `under500k_product`
-- (See below for the actual view)
--
CREATE TABLE `under500k_product` (
`product_id` int(11)
,`name` varchar(100)
,`category_id` int(11)
,`sale_price` decimal(10,2)
,`stock` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `high_price_products`
--
DROP TABLE IF EXISTS `high_price_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `high_price_products`  AS SELECT `over500k_products`.`product_id` AS `product_id`, `over500k_products`.`name` AS `name`, `over500k_products`.`category_id` AS `category_id`, `over500k_products`.`sale_price` AS `sale_price`, `over500k_products`.`stock` AS `stock` FROM `over500k_products` WHERE `over500k_products`.`sale_price` >= 500000WITH CASCADEDCHECK OPTION  ;

-- --------------------------------------------------------

--
-- Structure for view `over500k_products`
--
DROP TABLE IF EXISTS `over500k_products`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `over500k_products`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`category_id` AS `category_id`, `products`.`sale_price` AS `sale_price`, `products`.`stock` AS `stock` FROM `products` WHERE `products`.`sale_price` >= 500000 ;

-- --------------------------------------------------------

--
-- Structure for view `product_summary`
--
DROP TABLE IF EXISTS `product_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `product_summary`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`sale_price` AS `sale_price` FROM `products` ;

-- --------------------------------------------------------

--
-- Structure for view `under500k_product`
--
DROP TABLE IF EXISTS `under500k_product`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `under500k_product`  AS SELECT `products`.`product_id` AS `product_id`, `products`.`name` AS `name`, `products`.`category_id` AS `category_id`, `products`.`sale_price` AS `sale_price`, `products`.`stock` AS `stock` FROM `products` WHERE `products`.`sale_price` < 500000 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `idx_customer_order_date` (`customer_id`,`order_date`);

--
-- Indexes for table `productlogs`
--
ALTER TABLE `productlogs`
  ADD PRIMARY KEY (`log_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `idx_name_category` (`name`,`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sale_id`),
  ADD KEY `idx_product_sale_date` (`product_id`,`sale_date`);

--
-- Indexes for table `supplierproducts`
--
ALTER TABLE `supplierproducts`
  ADD PRIMARY KEY (`supplier_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orderitems`
--
ALTER TABLE `orderitems`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `productlogs`
--
ALTER TABLE `productlogs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `sale_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orderitems`
--
ALTER TABLE `orderitems`
  ADD CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `supplierproducts`
--
ALTER TABLE `supplierproducts`
  ADD CONSTRAINT `supplierproducts_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  ADD CONSTRAINT `supplierproducts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
