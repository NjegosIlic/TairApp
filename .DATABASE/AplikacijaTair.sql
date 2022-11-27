-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 27, 2022 at 04:39 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `AplikacijaTair`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `administrator_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(32) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
(3, 'NJegos1', '5CA4BB5D86D94C4F8B6F13F79852423673FC8DF3F4271A82848FBD7C2BAFE5B92F1A65CB7662EA1A63FFB231E28E936AD1510F410275B33F3FFAB8DE0A156D4F'),
(21, 'TestVanja', 'CDA1360DC9DC52BDDDD96D1777F5331ECA4F1E7EA8B99234DD86AF868E022E9FF09A1570EA1357D5FCEF4C1C45985C1ADC874D48B4EB4F42785BB16C83FF021A'),
(22, 'admin', 'C7AD44CBAD762A5DA0A452F9E854FDC1E0E7A52A38015F23F3EAB1D80B931DD472634DFAC71CD34EBC35D16AB7FB8A90C81F975113D6C7538DC69DD8DE9077EC');

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `article_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '0',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `excerpt` varchar(255) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `status` enum('avaliable','visible','hiden') DEFAULT 'avaliable',
  `is_promoted` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`article_id`, `name`, `category_id`, `excerpt`, `description`, `status`, `is_promoted`, `created_at`) VALUES
(1, 'ACME HDD 512GB ', 5, 'Kratak opis...', 'Detaljan opis... ', 'avaliable', 0, '2022-11-02 22:32:36'),
(2, 'ACME HD11 1024GB', 5, 'Neki kratak tekst 2...', 'Neki malo duzi tekst o proizvodu 2...', 'visible', 1, '2022-11-06 20:47:06');

-- --------------------------------------------------------

--
-- Table structure for table `article_feature`
--

CREATE TABLE `article_feature` (
  `article_feature_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `feature_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` varchar(255) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article_feature`
--

INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
(1, 1, 1, '512GB'),
(2, 1, 2, 'SATA3'),
(3, 1, 3, 'SSD'),
(6, 2, 1, '1024GB'),
(7, 2, 2, 'SATA 3.0');

-- --------------------------------------------------------

--
-- Table structure for table `article_price`
--

CREATE TABLE `article_price` (
  `article_price_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `price` decimal(10,2) UNSIGNED NOT NULL DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `article_price`
--

INSERT INTO `article_price` (`article_price_id`, `article_id`, `price`, `created_at`) VALUES
(1, 1, '45.00', '2022-11-02 22:52:46'),
(2, 1, '43.56', '2022-11-02 22:52:59'),
(3, 2, '56.89', '2022-11-06 20:47:06'),
(4, 2, '57.11', '2022-11-22 16:52:04');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `cart_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `cart_article`
--

CREATE TABLE `cart_article` (
  `cart_article_id` int(10) UNSIGNED NOT NULL,
  `cart_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  `parent_category_id` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent_category_id`) VALUES
(1, 'Racunarske komponente', 'assets/pc.jpg', NULL),
(2, 'Kucna elektronika', 'assets/home.jpg', NULL),
(3, 'Laptop racunari', 'assets/pc/laptop.jpg', 1),
(4, 'Memorijski mediji', 'assets/pc/memory.jpg', 1),
(5, 'Hard diskovi', 'assets/pc/memory/hdd.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `feature`
--

CREATE TABLE `feature` (
  `feature_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(32) DEFAULT '',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feature`
--

INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
(1, 'Kapacitet', 5),
(18, 'Napon', 2),
(20, 'Proizvodjac', 2),
(19, 'Snaga', 2),
(3, 'Tehnologija', 5),
(2, 'Tip', 5);

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `cart_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('rejected','accepted','shipped','pending') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE `photo` (
  `photo_id` int(10) UNSIGNED NOT NULL,
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `image_path` varchar(128) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `photo`
--

INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
(4, 1, '20221113-1318346681-hdd-icon.jpg'),
(6, 2, '20221114-3441354954-hard-drive.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `email` varchar(255) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  `forename` varchar(64) DEFAULT '0',
  `surname` varchar(64) NOT NULL DEFAULT '0',
  `phone_number` varchar(24) NOT NULL DEFAULT '0',
  `postal_adress` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `email`, `password_hash`, `forename`, `surname`, `phone_number`, `postal_adress`) VALUES
(1, 'test@test.rs', 'DDAF35A193617ABACC417349AE20413112E6FA4E89A97EA20A9EEEE64B55D39A2192992A274FC1A836BA3C23A3FEEBBD454D4423643CE80E2A9AC94FA54CA49F', 'Pera', 'Peric', '+38765706486', 'Nepoznata adresa bb, Glavna luka, Nedodjija'),
(14, 'test@test.com', 'EE26B0DD4AF7E749AA1A8EE3C10AE9923F618980772E473F8819A5D4940E0DB27AC185F8A0E1D5F84F88BC887FD67B143732C304CC5FA9AD8E6F57F50028A8FF', 'Test', 'Test', '+387657064865', 'Nepoznata adresa 56, Petrov Han, Nedodjija'),
(15, 'njegos.ilic1986@gmail.com', '6935FFFC6FC1A8B4854ED7834B8816ABE39F64790B6E1776FF9F2859278904941E3206BE320543F965A9072D8309D119F23CC68866726BEFE32617DA9CA219CF', 'Njegos', 'Ilic', '+387657064865797997', 'Ysenburger Str. 32, Karben'),
(17, 'njegos@gmail.com', '6935FFFC6FC1A8B4854ED7834B8816ABE39F64790B6E1776FF9F2859278904941E3206BE320543F965A9072D8309D119F23CC68866726BEFE32617DA9CA219CF', 'Njegos', 'Ilic', '+3876570648657979', 'Ysenburger Str. 32, Karben');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`administrator_id`),
  ADD UNIQUE KEY `uq_administrator_username` (`username`);

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`article_id`),
  ADD KEY `fk_article_category_id` (`category_id`);

--
-- Indexes for table `article_feature`
--
ALTER TABLE `article_feature`
  ADD PRIMARY KEY (`article_feature_id`),
  ADD UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`) USING BTREE,
  ADD KEY `fk_article_feature_feature_id` (`feature_id`);

--
-- Indexes for table `article_price`
--
ALTER TABLE `article_price`
  ADD PRIMARY KEY (`article_price_id`),
  ADD KEY `fk_article_price_article_id` (`article_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `fk_cart_user_id` (`user_id`);

--
-- Indexes for table `cart_article`
--
ALTER TABLE `cart_article`
  ADD PRIMARY KEY (`cart_article_id`),
  ADD UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  ADD KEY `fk_cart_article_article_id` (`article_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uq_category_name` (`name`) USING BTREE,
  ADD UNIQUE KEY `uq_category_image_path` (`image_path`),
  ADD KEY `fk_category_parent_category_id` (`parent_category_id`) USING BTREE;

--
-- Indexes for table `feature`
--
ALTER TABLE `feature`
  ADD PRIMARY KEY (`feature_id`),
  ADD UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`) USING BTREE,
  ADD KEY `fk_feature_category_id` (`category_id`) USING BTREE;

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`),
  ADD UNIQUE KEY `uq_order_cart_id` (`cart_id`);

--
-- Indexes for table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`photo_id`),
  ADD UNIQUE KEY `uq_photo_image_path` (`image_path`),
  ADD KEY `fk_photo_article_id` (`article_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`) USING BTREE,
  ADD UNIQUE KEY `uq_user_email` (`email`),
  ADD UNIQUE KEY `uq_user_phone_number` (`phone_number`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `administrator`
--
ALTER TABLE `administrator`
  MODIFY `administrator_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `article_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `article_feature`
--
ALTER TABLE `article_feature`
  MODIFY `article_feature_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `article_price`
--
ALTER TABLE `article_price`
  MODIFY `article_price_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `cart_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cart_article`
--
ALTER TABLE `cart_article`
  MODIFY `cart_article_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `feature`
--
ALTER TABLE `feature`
  MODIFY `feature_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `photo`
--
ALTER TABLE `photo`
  MODIFY `photo_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `article_feature`
--
ALTER TABLE `article_feature`
  ADD CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE;

--
-- Constraints for table `article_price`
--
ALTER TABLE `article_price`
  ADD CONSTRAINT `fk_article_price_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE;

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cart_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE;

--
-- Constraints for table `cart_article`
--
ALTER TABLE `cart_article`
  ADD CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `feature`
--
ALTER TABLE `feature`
  ADD CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE;

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE;

--
-- Constraints for table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
