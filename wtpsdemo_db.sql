-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2023 at 04:47 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wtpsdemo_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `sma_addresses`
--

CREATE TABLE `sma_addresses` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `line1` varchar(50) NOT NULL,
  `line2` varchar(50) DEFAULT NULL,
  `city` varchar(25) NOT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `state` varchar(25) NOT NULL,
  `country` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_adjustments`
--

CREATE TABLE `sma_adjustments` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` text,
  `attachment` varchar(55) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `count_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_adjustments`
--

INSERT INTO `sma_adjustments` (`id`, `date`, `reference_no`, `warehouse_id`, `note`, `attachment`, `created_by`, `updated_by`, `updated_at`, `count_id`) VALUES
(1, '2023-11-09 19:12:00', '111', 1, '&lt;p&gt;test update quantity&lt;&sol;p&gt;', NULL, 2, NULL, NULL, NULL),
(2, '2023-11-09 19:22:00', '222', 1, '', NULL, 2, NULL, NULL, NULL),
(3, '2023-11-09 19:23:00', '333', 1, '', NULL, 2, NULL, NULL, NULL),
(4, '2023-11-09 19:48:00', '5555', 1, '', NULL, 2, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_adjustment_items`
--

CREATE TABLE `sma_adjustment_items` (
  `id` int(11) NOT NULL,
  `adjustment_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_adjustment_items`
--

INSERT INTO `sma_adjustment_items` (`id`, `adjustment_id`, `product_id`, `option_id`, `quantity`, `warehouse_id`, `serial_no`, `type`) VALUES
(7, 1, 4, NULL, '1.0000', 1, '', 'addition'),
(8, 2, 4, NULL, '1.0000', 1, '', 'addition'),
(10, 3, 2, NULL, '1.0000', 1, '', 'subtraction'),
(11, 4, 6, NULL, '2.0000', 1, '', 'addition');

-- --------------------------------------------------------

--
-- Table structure for table `sma_brands`
--

CREATE TABLE `sma_brands` (
  `id` int(11) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `slug` varchar(55) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_brands`
--

INSERT INTO `sma_brands` (`id`, `code`, `name`, `image`, `slug`, `description`) VALUES
(1, '123123', 'Mie Kering', NULL, 'mie-kering', 'Mie Kering');

-- --------------------------------------------------------

--
-- Table structure for table `sma_calendar`
--

CREATE TABLE `sma_calendar` (
  `id` int(11) NOT NULL,
  `title` varchar(55) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `start` datetime NOT NULL,
  `end` datetime DEFAULT NULL,
  `color` varchar(7) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_captcha`
--

CREATE TABLE `sma_captcha` (
  `captcha_id` bigint(13) UNSIGNED NOT NULL,
  `captcha_time` int(10) UNSIGNED NOT NULL,
  `ip_address` varchar(16) CHARACTER SET latin1 NOT NULL DEFAULT '0',
  `word` varchar(20) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_categories`
--

CREATE TABLE `sma_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `slug` varchar(55) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_categories`
--

INSERT INTO `sma_categories` (`id`, `code`, `name`, `image`, `parent_id`, `slug`, `description`) VALUES
(1, 'C1', 'Category 1', NULL, NULL, NULL, NULL),
(2, 'terigu', 'Terigu', NULL, 0, 'terigu', 'Raw Material Terigu'),
(3, 'Mie', 'Mie', NULL, 0, 'mie', 'Mie Kering'),
(4, 'Chemical', 'Chemical', NULL, 0, 'chemical', 'Bahan Kimia');

-- --------------------------------------------------------

--
-- Table structure for table `sma_combo_items`
--

CREATE TABLE `sma_combo_items` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_combo_items`
--

INSERT INTO `sma_combo_items` (`id`, `product_id`, `item_code`, `quantity`, `unit_price`) VALUES
(1, 2, '57750585', '5.0000', '20000.0000'),
(3, 5, '57750585', '8.0000', '20000.0000'),
(4, 6, '57750585', '5.0000', '20000.0000'),
(5, 7, '74562677', '2.0000', '3000.0000'),
(6, 7, '57750585', '3.0000', '20000.0000'),
(7, 8, '57750585', '3.0000', '20000.0000'),
(8, 3, '57750585', '10.0000', '20000.0000'),
(9, 9, '57750585', '2.0000', '20000.0000'),
(10, 10, '57750585', '2.0000', '20000.0000'),
(15, 12, '74562677', '1.0000', '3000.0000'),
(16, 12, '57750585', '2.0000', '20000.0000'),
(17, 13, '57750585', '2.0000', '20000.0000'),
(24, 11, '57750585', '1.0000', '20000.0000'),
(29, 14, '74562677', '1.0000', '3000.0000'),
(30, 14, '57750585', '1.0000', '20000.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_companies`
--

CREATE TABLE `sma_companies` (
  `id` int(11) NOT NULL,
  `group_id` int(10) UNSIGNED DEFAULT NULL,
  `group_name` varchar(20) NOT NULL,
  `customer_group_id` int(11) DEFAULT NULL,
  `customer_group_name` varchar(100) DEFAULT NULL,
  `name` varchar(55) NOT NULL,
  `company` varchar(255) NOT NULL,
  `vat_no` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(55) DEFAULT NULL,
  `state` varchar(55) DEFAULT NULL,
  `postal_code` varchar(8) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `cf1` varchar(100) DEFAULT NULL,
  `cf2` varchar(100) DEFAULT NULL,
  `cf3` varchar(100) DEFAULT NULL,
  `cf4` varchar(100) DEFAULT NULL,
  `cf5` varchar(100) DEFAULT NULL,
  `cf6` varchar(100) DEFAULT NULL,
  `invoice_footer` text,
  `payment_term` int(11) DEFAULT '0',
  `logo` varchar(255) DEFAULT 'logo.png',
  `award_points` int(11) DEFAULT '0',
  `deposit_amount` decimal(25,4) DEFAULT NULL,
  `price_group_id` int(11) DEFAULT NULL,
  `price_group_name` varchar(50) DEFAULT NULL,
  `gst_no` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_companies`
--

INSERT INTO `sma_companies` (`id`, `group_id`, `group_name`, `customer_group_id`, `customer_group_name`, `name`, `company`, `vat_no`, `address`, `city`, `state`, `postal_code`, `country`, `phone`, `email`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `invoice_footer`, `payment_term`, `logo`, `award_points`, `deposit_amount`, `price_group_id`, `price_group_name`, `gst_no`) VALUES
(1, 3, 'customer', 1, 'General', 'Walk-in Customer', 'Walk-in Customer', '', 'Customer Address', 'Petaling Jaya', 'Selangor', '46000', 'Malaysia', '0123456789', 'customer@tecdiary.com', '', '', '', '', '', '', NULL, 0, 'logo.png', 0, NULL, NULL, NULL, NULL),
(2, 4, 'supplier', NULL, NULL, 'Test Supplier', 'Supplier Company Name', NULL, 'Supplier Address', 'Petaling Jaya', 'Selangor', '46050', 'Malaysia', '0123456789', 'supplier@tecdiary.com', '-', '-', '-', '-', '-', '-', NULL, 0, 'logo.png', 0, NULL, NULL, NULL, NULL),
(3, NULL, 'biller', NULL, NULL, 'Mian Saleem', 'Test Biller', '5555', 'Biller adddress', 'City', '', '', 'Country', '012345678', 'saleem@tecdiary.com', '', '', '', '', '', '', ' Thank you for shopping with us. Please come again', 0, 'logo1.png', 0, NULL, NULL, NULL, NULL),
(4, 4, 'supplier', NULL, NULL, 'Bogasari', 'PT. Bogasari Flour Mills', '123123123', 'Jl. Raya cilincing no 1', 'Jakarta utara', 'DKI Jakarta', '14130', 'Indonesia', '08123132123', 'info@bogasariflour.com', '', '', '', '', '', '', NULL, 0, 'logo.png', 0, NULL, NULL, NULL, '3333333');

-- --------------------------------------------------------

--
-- Table structure for table `sma_costing`
--

CREATE TABLE `sma_costing` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `sale_item_id` int(11) NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `purchase_item_id` int(11) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `purchase_net_unit_cost` decimal(25,4) DEFAULT NULL,
  `purchase_unit_cost` decimal(25,4) DEFAULT NULL,
  `sale_net_unit_price` decimal(25,4) NOT NULL,
  `sale_unit_price` decimal(25,4) NOT NULL,
  `quantity_balance` decimal(15,4) DEFAULT NULL,
  `inventory` tinyint(1) DEFAULT '0',
  `overselling` tinyint(1) DEFAULT '0',
  `option_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_costing`
--

INSERT INTO `sma_costing` (`id`, `date`, `product_id`, `sale_item_id`, `sale_id`, `purchase_item_id`, `quantity`, `purchase_net_unit_cost`, `purchase_unit_cost`, `sale_net_unit_price`, `sale_unit_price`, `quantity_balance`, `inventory`, `overselling`, `option_id`, `purchase_id`) VALUES
(1, '2023-11-08', 1, 1, 1, 2, '5.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '0.0000', 1, 0, NULL, 1),
(2, '2023-11-08', 1, 2, 2, 3, '3.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '2.0000', 1, 0, NULL, NULL),
(3, '2023-11-10', 1, 3, 3, 3, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '1.0000', 1, 0, NULL, NULL),
(4, '2023-11-10', 1, 4, 4, 3, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '0.0000', 1, 0, NULL, NULL),
(5, '2023-11-10', 1, 5, 5, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '19.0000', 1, 0, NULL, 2),
(6, '2023-11-11', 1, 6, 6, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '18.0000', 1, 0, NULL, 2),
(7, '2023-11-11', 1, 7, 7, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '17.0000', 1, 0, NULL, 2),
(8, '2023-11-11', 1, 8, 8, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '16.0000', 1, 0, NULL, 2),
(9, '2023-11-11', 1, 9, 9, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '15.0000', 1, 0, NULL, 2),
(10, '2023-11-11', 1, 10, 10, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '14.0000', 1, 0, NULL, 2),
(11, '2023-11-11', 1, 11, 11, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '13.0000', 1, 0, NULL, 2),
(12, '2023-11-11', 1, 12, 12, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '12.0000', 1, 0, NULL, 2),
(13, '2023-11-11', 1, 13, 13, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '11.0000', 1, 0, NULL, 2),
(14, '2023-11-11', 1, 14, 14, 5, '1.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '10.0000', 1, 0, NULL, 2),
(15, '2023-11-11', 1, 15, 14, 5, '2.0000', '10000.0000', '10000.0000', '20000.0000', '20000.0000', '9.0000', 1, 0, NULL, 2),
(16, '2023-11-13', 21, 16, 15, 9, '5.0000', '1000000.0000', '1000.0000', '1000.0000', '1000.0000', '9995.0000', 1, 0, NULL, 4),
(17, '2023-11-16', 19, 19, 18, 15, '10.0000', '15000.0000', '15000.0000', '15000.0000', '15000.0000', '15.0000', 1, 0, NULL, 7),
(18, '2023-11-16', 19, 20, 19, 15, '10.0000', '15000.0000', '15000.0000', '15000.0000', '15000.0000', '5.0000', 1, 0, NULL, 7),
(19, '2023-11-16', 19, 21, 20, 15, '5.0000', '15000.0000', '15000.0000', '15000.0000', '15000.0000', '0.0000', 1, 0, NULL, 7),
(20, '2023-11-16', 19, 21, 20, 17, '5.0000', '15000.0000', '15000.0000', '15000.0000', '15000.0000', '25.0000', 1, 0, NULL, 8),
(21, '2023-11-19', 22, 23, 22, 19, '5.0000', '10000.0000', '10000.0000', '480.0000', '480.0000', '83.0000', 1, 0, NULL, 9),
(22, '2023-11-19', 20, 26, 25, 26, '10.0000', '211720.0000', '211720.0000', '3880.0000', '3880.0000', '10.0000', 1, 0, NULL, 16),
(23, '2023-11-19', 20, 27, 26, 26, '5.0000', '211720.0000', '211720.0000', '3880.0000', '3880.0000', '5.0000', 1, 0, NULL, 16),
(24, '2023-11-25', 23, 38, 37, 38, '1.0000', '410000.0000', '410000.0000', '400.0000', '400.0000', '1.0000', 1, 0, NULL, 27),
(25, '2023-11-26', 23, 50, 50, 38, '2.0000', '410000.0000', '410000.0000', '400.0000', '400.0000', '0.0000', 1, 0, NULL, 27),
(26, '2023-11-26', 23, 50, 50, 40, '10.0000', '820000.0000', '820000.0000', '400.0000', '400.0000', '0.0000', 1, 0, NULL, 29),
(27, '2023-11-26', 24, 51, 51, 41, '30.0000', '820000.0000', '820000.0000', '600.0000', '600.0000', '0.0000', 1, 0, NULL, 30),
(28, '2023-11-29', 23, 52, 52, 38, '2.0000', '410000.0000', '410000.0000', '400.0000', '400.0000', '0.0000', 1, 0, NULL, 27),
(29, '2023-11-29', 23, 52, 52, 40, '2.0000', '820000.0000', '820000.0000', '400.0000', '400.0000', '0.0000', 1, 0, NULL, 29),
(30, '2023-11-29', 23, 52, 52, 43, '15.0000', '141000.0000', '141000.0000', '400.0000', '400.0000', '0.0000', 1, 0, NULL, 32),
(31, '2023-12-08', 28, 53, 53, 74, '100.0000', '1000000.0000', '1000000.0000', '520.0000', '520.0000', '0.0000', 1, 0, NULL, 40),
(32, '2023-12-10', 29, 54, 54, 78, '80.0000', '100000.0000', '100000.0000', '1000.0000', '1000.0000', '20.0000', 1, 0, NULL, 44);

-- --------------------------------------------------------

--
-- Table structure for table `sma_currencies`
--

CREATE TABLE `sma_currencies` (
  `id` int(11) NOT NULL,
  `code` varchar(5) NOT NULL,
  `name` varchar(55) NOT NULL,
  `rate` decimal(12,4) NOT NULL,
  `auto_update` tinyint(1) NOT NULL DEFAULT '0',
  `symbol` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_currencies`
--

INSERT INTO `sma_currencies` (`id`, `code`, `name`, `rate`, `auto_update`, `symbol`) VALUES
(3, 'IDR', 'Rupiah', '15000.0000', 0, 'Rp.');

-- --------------------------------------------------------

--
-- Table structure for table `sma_customer_groups`
--

CREATE TABLE `sma_customer_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `percent` int(11) NOT NULL,
  `discount` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_customer_groups`
--

INSERT INTO `sma_customer_groups` (`id`, `name`, `percent`, `discount`) VALUES
(1, 'General', 0, NULL),
(2, 'Reseller', -5, NULL),
(3, 'Distributor', -15, NULL),
(4, 'New Customer (+10)', 10, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_damage`
--

CREATE TABLE `sma_damage` (
  `id` int(11) NOT NULL,
  `reference` varchar(20) NOT NULL,
  `total_amount` double NOT NULL DEFAULT '0',
  `reason` varchar(100) NOT NULL DEFAULT '',
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_damage`
--

INSERT INTO `sma_damage` (`id`, `reference`, `total_amount`, `reason`, `created_by`, `created_at`) VALUES
(2, '0001/DMG/WTPS/XII/20', 30000, 'barang rusak', 2, '2023-12-10 15:36:58'),
(3, '0002/DMG/WTPS/XII/20', 68000, 'kadaluarsa', 2, '2023-12-10 15:40:53'),
(4, '0003/DMG/WTPS/XII/20', 68000, 'kadaluarsa', 2, '2023-12-10 15:42:09');

-- --------------------------------------------------------

--
-- Table structure for table `sma_damage_items`
--

CREATE TABLE `sma_damage_items` (
  `id` int(11) NOT NULL,
  `damage_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(10) NOT NULL,
  `product_desc` varchar(50) NOT NULL,
  `product_batch` varchar(20) NOT NULL,
  `qty` float NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_code` varchar(5) NOT NULL,
  `unit_amount` double NOT NULL,
  `total_amount` double NOT NULL DEFAULT '0',
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_damage_items`
--

INSERT INTO `sma_damage_items` (`id`, `damage_id`, `product_id`, `product_code`, `product_desc`, `product_batch`, `qty`, `unit_id`, `unit_code`, `unit_amount`, `total_amount`, `warehouse_id`, `note`) VALUES
(2, 0, 29, 'FG0008', 'Mie Damage', '20231210-1', 3, 2, 'ZAK', 10000, 30000, 4, 'tidak ada'),
(3, 3, 29, 'FG0008', 'Mie Damage', '20231210-1', 2, 2, 'ZAK', 10000, 20000, 4, 'mei 2022'),
(4, 3, 28, 'FG0007', 'Mie Retur', '20231208-1', 6, 2, 'ZAK', 8000, 48000, 4, 'tidak ada label'),
(5, 4, 29, 'FG0008', 'Mie Damage', '20231210-1', 2, 2, 'ZAK', 10000, 20000, 4, 'mei 2022'),
(6, 4, 28, 'FG0007', 'Mie Retur', '20231208-1', 6, 2, 'ZAK', 8000, 48000, 4, 'tidak ada label');

-- --------------------------------------------------------

--
-- Table structure for table `sma_date_format`
--

CREATE TABLE `sma_date_format` (
  `id` int(11) NOT NULL,
  `js` varchar(20) NOT NULL,
  `php` varchar(20) NOT NULL,
  `sql` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_date_format`
--

INSERT INTO `sma_date_format` (`id`, `js`, `php`, `sql`) VALUES
(1, 'mm-dd-yyyy', 'm-d-Y', '%m-%d-%Y'),
(2, 'mm/dd/yyyy', 'm/d/Y', '%m/%d/%Y'),
(3, 'mm.dd.yyyy', 'm.d.Y', '%m.%d.%Y'),
(4, 'dd-mm-yyyy', 'd-m-Y', '%d-%m-%Y'),
(5, 'dd/mm/yyyy', 'd/m/Y', '%d/%m/%Y'),
(6, 'dd.mm.yyyy', 'd.m.Y', '%d.%m.%Y');

-- --------------------------------------------------------

--
-- Table structure for table `sma_deliveries`
--

CREATE TABLE `sma_deliveries` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) NOT NULL,
  `do_reference_no` varchar(50) NOT NULL,
  `sale_reference_no` varchar(50) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `address` varchar(1000) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `status` varchar(15) DEFAULT NULL,
  `attachment` varchar(50) DEFAULT NULL,
  `delivered_by` varchar(50) DEFAULT NULL,
  `received_by` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `no_vehicle` varchar(20) NOT NULL DEFAULT '',
  `is_complete` varchar(1) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_deliveries`
--

INSERT INTO `sma_deliveries` (`id`, `date`, `sale_id`, `do_reference_no`, `sale_reference_no`, `customer`, `address`, `note`, `status`, `attachment`, `delivered_by`, `received_by`, `created_by`, `updated_by`, `updated_at`, `no_vehicle`, `is_complete`) VALUES
(1, '2023-11-19 08:25:00', 21, '12345', '11111', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '&lt;p&gt;&lt;p&gt;&lt;p&gt;Tidak ada catatan&lt;&sol;p&gt;&lt;&sol;p&gt;&lt;&sol;p&gt;', 'packing', NULL, 'Fauzi', 'Theo', 2, NULL, NULL, '', ''),
(9, '2023-11-26 06:02:00', 37, 'DO2023/11/0001', '0025/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'B 1234 HHH', 'X'),
(10, '2023-11-26 07:11:00', 50, 'DO2023/11/0001', '0026/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'B 1234 HHH', ''),
(11, '2023-11-26 07:35:00', 50, 'DO2023/11/0001', '0026/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'B 7777 FFF', ''),
(12, '2023-11-26 07:50:00', 51, 'DO2023/11/0001', '0027/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'T 1234 JJJ', ''),
(13, '2023-11-26 07:52:00', 51, 'DO2023/11/0001', '0027/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'G 1234 JJJ', ''),
(14, '2023-11-26 08:16:00', 51, '0007/SJ/WTPS/XI/2023', '0027/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'L 1234 JJJ', ''),
(15, '2023-11-29 12:45:00', 52, '0008/SJ/WTPS/XI/2023', '0028/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, 'Theo', '', 2, NULL, NULL, 'B 1234 HHH', ''),
(16, '2023-11-29 12:51:00', 52, '0009/SJ/WTPS/XI/2023', '0028/SO/WTPS/XI/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'B 1234 HHH', ''),
(17, '2023-12-08 13:25:00', 53, '0010/SJ/WTPS/XII/2023', '0029/SO/WTPS/XII/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'B 1234 JJJ', ''),
(18, '2023-12-08 14:51:00', 53, '0011/SJ/WTPS/XII/2023', '0029/SO/WTPS/XII/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'H 1234 DDC', ''),
(19, '2023-12-10 06:59:00', 54, '0012/SJ/WTPS/XII/2023', '0030/SO/WTPS/XII/2023', 'Walk-in Customer', '<p>Customer Address Petaling Jaya Selangor 46000 Malaysia<br>Telpon: 0123456789 Email: customer@tecdiary.com</p>', '', 'delivering', NULL, '', '', 2, NULL, NULL, 'F 1245 DDD', '');

-- --------------------------------------------------------

--
-- Table structure for table `sma_delivery_item`
--

CREATE TABLE `sma_delivery_item` (
  `delivery_id` int(11) NOT NULL,
  `seq` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `product_code` varchar(20) NOT NULL,
  `product_desc` varchar(40) NOT NULL,
  `qty` decimal(15,4) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `unit_code` varchar(10) NOT NULL,
  `product_batch` varchar(20) NOT NULL DEFAULT '',
  `warehouse_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_delivery_item`
--

INSERT INTO `sma_delivery_item` (`delivery_id`, `seq`, `product_id`, `product_code`, `product_desc`, `qty`, `unit_id`, `unit_code`, `product_batch`, `warehouse_id`) VALUES
(9, 1, 23, 'FG0002', 'Mie Bihun', '1.0000', 2, 'ZAK', '20231125-8', 3),
(10, 1, 23, 'FG0002', 'Mie Bihun', '5.0000', 2, 'ZAK', '20231126-1', 1),
(11, 1, 23, 'FG0002', 'Mie Bihun', '3.0000', 2, 'ZAK', '20231126-1', 1),
(12, 1, 24, 'FG0003', 'Mie Kwetiaw', '10.0000', 2, 'ZAK', '20231126-2', 1),
(13, 1, 24, 'FG0003', 'Mie Kwetiaw', '5.0000', 2, 'ZAK', '20231126-2', 1),
(13, 2, 24, 'FG0003', 'Mie Kwetiaw', '3.0000', 2, 'ZAK', '20231126-3', 1),
(14, 1, 24, 'FG0003', 'Mie Kwetiaw', '15.0000', 2, 'ZAK', '20231126-2', 1),
(14, 2, 24, 'FG0003', 'Mie Kwetiaw', '20.0000', 2, 'ZAK', '20231126-3', 1),
(15, 1, 23, 'FG0002', 'Mie Bihun', '12.0000', 2, 'ZAK', '20231129-1', 1),
(16, 1, 23, 'FG0002', 'Mie Bihun', '1.0000', 2, 'ZAK', '20231125-8', 3),
(16, 2, 23, 'FG0002', 'Mie Bihun', '2.0000', 2, 'ZAK', '20231126-1', 1),
(16, 3, 23, 'FG0002', 'Mie Bihun', '3.0000', 2, 'ZAK', '20231129-1', 1),
(17, 1, 28, 'FG0007', 'Mie Retur', '20.0000', 2, 'ZAK', '20231208-1', 1),
(18, 1, 28, 'FG0007', 'Mie Retur', '50.0000', 2, 'ZAK', '20231208-1', 1),
(19, 1, 29, 'FG0008', 'Mie Damage', '10.0000', 2, 'ZAK', '20231210-1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sma_deposits`
--

CREATE TABLE `sma_deposits` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `company_id` int(11) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `paid_by` varchar(50) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_expenses`
--

CREATE TABLE `sma_expenses` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference` varchar(50) NOT NULL,
  `amount` decimal(25,4) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` varchar(55) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_expense_categories`
--

CREATE TABLE `sma_expense_categories` (
  `id` int(11) NOT NULL,
  `code` varchar(55) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_gift_cards`
--

CREATE TABLE `sma_gift_cards` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,4) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer` varchar(255) DEFAULT NULL,
  `balance` decimal(25,4) NOT NULL,
  `expiry` date DEFAULT NULL,
  `created_by` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_gift_card_topups`
--

CREATE TABLE `sma_gift_card_topups` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `card_id` int(11) NOT NULL,
  `amount` decimal(15,4) NOT NULL,
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_groups`
--

CREATE TABLE `sma_groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_groups`
--

INSERT INTO `sma_groups` (`id`, `name`, `description`) VALUES
(1, 'owner', 'Owner'),
(2, 'admin', 'Administrator'),
(3, 'customer', 'Customer'),
(4, 'supplier', 'Supplier'),
(5, 'sales', 'Sales Staff');

-- --------------------------------------------------------

--
-- Table structure for table `sma_login_attempts`
--

CREATE TABLE `sma_login_attempts` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_logs`
--

CREATE TABLE `sma_logs` (
  `id` int(11) NOT NULL,
  `detail` varchar(190) NOT NULL,
  `model` longtext,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_logs`
--

INSERT INTO `sma_logs` (`id`, `detail`, `model`, `date`) VALUES
(1, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"8\",\"code\":\"09368872\",\"name\":\"noodle2\",\"unit\":null,\"cost\":null,\"price\":\"60000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"09368872\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:22:14'),
(2, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"7\",\"code\":\"67626088\",\"name\":\"noodle\",\"unit\":null,\"cost\":null,\"price\":\"66000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"67626088\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:22:14'),
(3, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"5\",\"code\":\"888888\",\"name\":\"Mie Lurus\",\"unit\":null,\"cost\":null,\"price\":\"160000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"mie-lurus\",\"featured\":null,\"weight\":\"1.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:22:14'),
(4, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"6\",\"code\":\"9999\",\"name\":\"mi\",\"unit\":null,\"cost\":null,\"price\":\"100000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"05482153\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:22:14'),
(5, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"9\",\"code\":\"28784648\",\"name\":\"test\",\"unit\":null,\"cost\":null,\"price\":\"40000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"28784648\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:42:27'),
(6, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"10\",\"code\":\"37574490\",\"name\":\"tes2\",\"unit\":null,\"cost\":null,\"price\":\"40000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"1.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"37574490\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-09 20:42:27'),
(7, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"13\",\"code\":\"03732412\",\"name\":\"mie kering 2\",\"unit\":null,\"cost\":null,\"price\":\"40000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"0.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"03732412\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-12 11:23:44'),
(8, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"12\",\"code\":\"74372071\",\"name\":\"Mie Kering 1\",\"unit\":null,\"cost\":null,\"price\":\"43000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"mie-kering-1\",\"featured\":null,\"weight\":\"25.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Mie Kering\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:01'),
(9, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"14\",\"code\":\"33501950\",\"name\":\"Bihun\",\"unit\":null,\"cost\":null,\"price\":\"23000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"3.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"bihun\",\"featured\":null,\"weight\":\"20.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Bihun Kering\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:14'),
(10, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"1\",\"code\":\"57750585\",\"name\":\"Terigu\",\"unit\":\"1\",\"cost\":\"10000.0000\",\"price\":\"20000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"8.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"1\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"standard\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"1\",\"purchase_unit\":\"1\",\"brand\":\"0\",\"slug\":\"57750585\",\"featured\":null,\"weight\":\"1.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Terigu segitiga biru\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:14'),
(11, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"3\",\"code\":\"59775713\",\"name\":\"Mie Kering\",\"unit\":null,\"cost\":null,\"price\":\"200000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"mie-kering\",\"featured\":null,\"weight\":\"25.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Mie Kering\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:14'),
(12, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"2\",\"code\":\"62765470\",\"name\":\"Mie Kering\",\"unit\":null,\"cost\":null,\"price\":\"100000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"0\",\"slug\":\"mie-kering\",\"featured\":null,\"weight\":\"25.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Mie Kering\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:14'),
(13, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"4\",\"code\":\"74562677\",\"name\":\"Garam\",\"unit\":\"1\",\"cost\":\"3000.0000\",\"price\":\"3000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"2.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"1\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"standard\",\"supplier1\":\"2\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"1\",\"purchase_unit\":\"1\",\"brand\":\"1\",\"slug\":\"garam\",\"featured\":null,\"weight\":\"1.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Garam kasar\",\"hide_pos\":\"1\"}}', '2023-11-12 11:24:14'),
(14, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"11\",\"code\":\"79009910\",\"name\":\"Mie Gacor\",\"unit\":null,\"cost\":null,\"price\":\"20000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"3.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"79009910\",\"featured\":null,\"weight\":\"0.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:14'),
(15, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"17\",\"code\":\"FG0007\",\"name\":\"Mie Kering Tujuh Mangkuk\",\"unit\":null,\"cost\":null,\"price\":\"120000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":\"0.0000\",\"tax_rate\":\"1\",\"track_quantity\":\"0\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"combo\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"0\",\"purchase_unit\":\"0\",\"brand\":\"1\",\"slug\":\"mie-kering-tujuh-mangkuk\",\"featured\":null,\"weight\":\"25.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Mie Kering 12\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:15'),
(16, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"16\",\"code\":\"RM0004\",\"name\":\"Pewarna Kuning\",\"unit\":\"1\",\"cost\":\"2000.0000\",\"price\":\"2000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"1\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"standard\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"1\",\"purchase_unit\":\"1\",\"brand\":\"1\",\"slug\":\"pewarna-kuning\",\"featured\":null,\"weight\":\"10.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Pewarna Kuning Baru\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:15'),
(17, 'Product is being deleted by ownertoko (User Id: 2)', '{\"model\":{\"id\":\"15\",\"code\":\"RM1003\",\"name\":\"Terigu Baru\",\"unit\":\"1\",\"cost\":\"10000.0000\",\"price\":\"10000.0000\",\"alert_quantity\":\"0.0000\",\"image\":\"no_image.png\",\"category_id\":\"1\",\"subcategory_id\":null,\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"quantity\":null,\"tax_rate\":\"1\",\"track_quantity\":\"1\",\"details\":\"\",\"warehouse\":null,\"barcode_symbology\":\"code128\",\"file\":\"\",\"product_details\":\"\",\"tax_method\":\"1\",\"type\":\"standard\",\"supplier1\":\"0\",\"supplier1price\":null,\"supplier2\":null,\"supplier2price\":null,\"supplier3\":null,\"supplier3price\":null,\"supplier4\":null,\"supplier4price\":null,\"supplier5\":null,\"supplier5price\":null,\"promotion\":null,\"promo_price\":null,\"start_date\":null,\"end_date\":null,\"supplier1_part_no\":\"\",\"supplier2_part_no\":null,\"supplier3_part_no\":null,\"supplier4_part_no\":null,\"supplier5_part_no\":null,\"sale_unit\":\"1\",\"purchase_unit\":\"1\",\"brand\":\"0\",\"slug\":\"terigu-baru\",\"featured\":null,\"weight\":\"25.0000\",\"hsn_code\":null,\"views\":\"0\",\"hide\":\"0\",\"second_name\":\"Terigu Lencana Merah\",\"hide_pos\":\"0\"}}', '2023-11-12 11:24:15'),
(18, 'Supplier is being deleted by k-wtps-0002 (User Id: 4)', '{\"model\":{\"id\":\"5\",\"group_id\":\"4\",\"group_name\":\"supplier\",\"customer_group_id\":null,\"customer_group_name\":null,\"name\":\"theo\",\"company\":\"PT Wings Indonesia\",\"vat_no\":\"12.234.111.1-345.000\",\"address\":\"Rawamangun\",\"city\":\"Jakarta Pusat\",\"state\":\"DKI Jakarta\",\"postal_code\":\"11244554\",\"country\":\"Indonesia\",\"phone\":\"087654331123\",\"email\":\"nugroho.hari@gmail.com\",\"cf1\":\"\",\"cf2\":\"\",\"cf3\":\"\",\"cf4\":\"\",\"cf5\":\"\",\"cf6\":\"\",\"invoice_footer\":null,\"payment_term\":\"0\",\"logo\":\"logo.png\",\"award_points\":\"0\",\"deposit_amount\":null,\"price_group_id\":null,\"price_group_name\":null,\"gst_no\":\"\"}}', '2023-11-13 13:47:50');

-- --------------------------------------------------------

--
-- Table structure for table `sma_migrations`
--

CREATE TABLE `sma_migrations` (
  `version` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_migrations`
--

INSERT INTO `sma_migrations` (`version`) VALUES
(315);

-- --------------------------------------------------------

--
-- Table structure for table `sma_notifications`
--

CREATE TABLE `sma_notifications` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_date` datetime DEFAULT NULL,
  `till_date` datetime DEFAULT NULL,
  `scope` tinyint(1) NOT NULL DEFAULT '3'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_order_ref`
--

CREATE TABLE `sma_order_ref` (
  `ref_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `so` int(11) NOT NULL DEFAULT '1',
  `qu` int(11) NOT NULL DEFAULT '1',
  `po` int(11) NOT NULL DEFAULT '1',
  `to` int(11) NOT NULL DEFAULT '1',
  `pos` int(11) NOT NULL DEFAULT '1',
  `do` int(11) NOT NULL DEFAULT '1',
  `pay` int(11) NOT NULL DEFAULT '1',
  `re` int(11) NOT NULL DEFAULT '1',
  `rep` int(11) NOT NULL DEFAULT '1',
  `ex` int(11) NOT NULL DEFAULT '1',
  `ppay` int(11) NOT NULL DEFAULT '1',
  `qa` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_order_ref`
--

INSERT INTO `sma_order_ref` (`ref_id`, `date`, `so`, `qu`, `po`, `to`, `pos`, `do`, `pay`, `re`, `rep`, `ex`, `ppay`, `qa`) VALUES
(1, '2015-03-01', 1, 1, 1, 2, 19, 1, 19, 1, 1, 1, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `sma_payments`
--

CREATE TABLE `sma_payments` (
  `id` int(11) NOT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sale_id` int(11) DEFAULT NULL,
  `return_id` int(11) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `reference_no` varchar(50) NOT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `paid_by` varchar(20) NOT NULL,
  `cheque_no` varchar(20) DEFAULT NULL,
  `cc_no` varchar(20) DEFAULT NULL,
  `cc_holder` varchar(25) DEFAULT NULL,
  `cc_month` varchar(2) DEFAULT NULL,
  `cc_year` varchar(4) DEFAULT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `amount` decimal(25,4) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `pos_paid` decimal(25,4) DEFAULT '0.0000',
  `pos_balance` decimal(25,4) DEFAULT '0.0000',
  `approval_code` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_payments`
--

INSERT INTO `sma_payments` (`id`, `date`, `sale_id`, `return_id`, `purchase_id`, `reference_no`, `transaction_id`, `paid_by`, `cheque_no`, `cc_no`, `cc_holder`, `cc_month`, `cc_year`, `cc_type`, `amount`, `currency`, `created_by`, `attachment`, `type`, `note`, `pos_paid`, `pos_balance`, `approval_code`) VALUES
(1, '2023-11-08 02:12:00', NULL, NULL, 1, '777777777', NULL, 'cash', '', '', '', '', '', 'Visa', '115000.0000', NULL, 2, NULL, 'sent', '', '0.0000', '0.0000', NULL),
(2, '2023-11-08 02:59:03', 1, NULL, NULL, 'IPAY2023/11/0001', NULL, 'cash', '', '', '', '', '', '', '100000.0000', NULL, 2, NULL, 'received', '', '100000.0000', '0.0000', NULL),
(3, '2023-11-08 03:20:27', 2, NULL, NULL, 'IPAY2023/11/0002', NULL, 'cash', '', '', '', '', '', '', '60000.0000', NULL, 2, NULL, 'received', '', '60000.0000', '0.0000', NULL),
(4, '2023-11-09 20:49:00', 3, NULL, NULL, 'IPAY2023/11/0003', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(5, '2023-11-09 20:52:32', 4, NULL, NULL, 'IPAY2023/11/0004', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(6, '2023-11-09 21:02:37', 5, NULL, NULL, 'IPAY2023/11/0005', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(7, '2023-11-11 02:28:33', 6, NULL, NULL, 'IPAY2023/11/0006', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(8, '2023-11-11 02:46:30', 7, NULL, NULL, 'IPAY2023/11/0007', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(9, '2023-11-11 02:49:34', 8, NULL, NULL, 'IPAY2023/11/0008', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(10, '2023-11-11 02:55:26', 9, NULL, NULL, 'IPAY2023/11/0009', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(11, '2023-11-11 03:16:52', 10, NULL, NULL, 'IPAY2023/11/0010', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(12, '2023-11-11 04:17:50', 11, NULL, NULL, 'IPAY2023/11/0011', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(13, '2023-11-11 04:22:01', 12, NULL, NULL, 'IPAY2023/11/0012', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(14, '2023-11-11 04:23:27', 13, NULL, NULL, 'IPAY2023/11/0013', NULL, 'cash', '', '', '', '', '', '', '20000.0000', NULL, 2, NULL, 'received', '', '20000.0000', '0.0000', NULL),
(15, '2023-11-11 04:36:44', 14, NULL, NULL, 'IPAY2023/11/0014', NULL, 'cash', '', '', '', '', '', '', '60000.0000', NULL, 2, NULL, 'received', '', '60000.0000', '0.0000', NULL),
(16, '2023-11-13 15:01:46', 15, NULL, NULL, 'IPAY2023/11/0015', NULL, 'cash', '', '', '', '', '', '', '5000.0000', NULL, 2, NULL, 'received', '', '5000.0000', '0.0000', NULL),
(17, '2023-11-16 13:21:23', 18, NULL, NULL, 'IPAY2023/11/0016', NULL, 'cash', '', '', '', '', '', '', '150000.0000', NULL, 2, NULL, 'received', '', '150000.0000', '0.0000', NULL),
(18, '2023-11-16 13:23:26', 19, NULL, NULL, 'IPAY2023/11/0017', NULL, 'cash', '', '', '', '', '', '', '150000.0000', NULL, 2, NULL, 'received', '', '150000.0000', '0.0000', NULL),
(19, '2023-11-16 13:24:24', 20, NULL, NULL, 'IPAY2023/11/0018', NULL, 'cash', '', '', '', '', '', '', '150000.0000', NULL, 2, NULL, 'received', '', '150000.0000', '0.0000', NULL),
(20, '2023-11-27 03:29:00', NULL, NULL, 9, 'POP2023/11/0001', NULL, 'cash', '', '', '', '', '', 'Visa', '500000.0000', NULL, 2, NULL, 'sent', '', '0.0000', '0.0000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_paypal`
--

CREATE TABLE `sma_paypal` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL,
  `paypal_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '2.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '3.9000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '4.4000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_paypal`
--

INSERT INTO `sma_paypal` (`id`, `active`, `account_email`, `paypal_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'mypaypal@paypal.com', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_permissions`
--

CREATE TABLE `sma_permissions` (
  `id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `products-index` tinyint(1) DEFAULT '0',
  `products-add` tinyint(1) DEFAULT '0',
  `products-edit` tinyint(1) DEFAULT '0',
  `products-delete` tinyint(1) DEFAULT '0',
  `products-cost` tinyint(1) DEFAULT '0',
  `products-price` tinyint(1) DEFAULT '0',
  `quotes-index` tinyint(1) DEFAULT '0',
  `quotes-add` tinyint(1) DEFAULT '0',
  `quotes-edit` tinyint(1) DEFAULT '0',
  `quotes-pdf` tinyint(1) DEFAULT '0',
  `quotes-email` tinyint(1) DEFAULT '0',
  `quotes-delete` tinyint(1) DEFAULT '0',
  `sales-index` tinyint(1) DEFAULT '0',
  `sales-add` tinyint(1) DEFAULT '0',
  `sales-edit` tinyint(1) DEFAULT '0',
  `sales-pdf` tinyint(1) DEFAULT '0',
  `sales-email` tinyint(1) DEFAULT '0',
  `sales-delete` tinyint(1) DEFAULT '0',
  `purchases-index` tinyint(1) DEFAULT '0',
  `purchases-add` tinyint(1) DEFAULT '0',
  `purchases-edit` tinyint(1) DEFAULT '0',
  `purchases-pdf` tinyint(1) DEFAULT '0',
  `purchases-email` tinyint(1) DEFAULT '0',
  `purchases-delete` tinyint(1) DEFAULT '0',
  `transfers-index` tinyint(1) DEFAULT '0',
  `transfers-add` tinyint(1) DEFAULT '0',
  `transfers-edit` tinyint(1) DEFAULT '0',
  `transfers-pdf` tinyint(1) DEFAULT '0',
  `transfers-email` tinyint(1) DEFAULT '0',
  `transfers-delete` tinyint(1) DEFAULT '0',
  `customers-index` tinyint(1) DEFAULT '0',
  `customers-add` tinyint(1) DEFAULT '0',
  `customers-edit` tinyint(1) DEFAULT '0',
  `customers-delete` tinyint(1) DEFAULT '0',
  `suppliers-index` tinyint(1) DEFAULT '0',
  `suppliers-add` tinyint(1) DEFAULT '0',
  `suppliers-edit` tinyint(1) DEFAULT '0',
  `suppliers-delete` tinyint(1) DEFAULT '0',
  `sales-deliveries` tinyint(1) DEFAULT '0',
  `sales-add_delivery` tinyint(1) DEFAULT '0',
  `sales-edit_delivery` tinyint(1) DEFAULT '0',
  `sales-delete_delivery` tinyint(1) DEFAULT '0',
  `sales-email_delivery` tinyint(1) DEFAULT '0',
  `sales-pdf_delivery` tinyint(1) DEFAULT '0',
  `sales-gift_cards` tinyint(1) DEFAULT '0',
  `sales-add_gift_card` tinyint(1) DEFAULT '0',
  `sales-edit_gift_card` tinyint(1) DEFAULT '0',
  `sales-delete_gift_card` tinyint(1) DEFAULT '0',
  `pos-index` tinyint(1) DEFAULT '0',
  `sales-return_sales` tinyint(1) DEFAULT '0',
  `reports-index` tinyint(1) DEFAULT '0',
  `reports-warehouse_stock` tinyint(1) DEFAULT '0',
  `reports-quantity_alerts` tinyint(1) DEFAULT '0',
  `reports-expiry_alerts` tinyint(1) DEFAULT '0',
  `reports-products` tinyint(1) DEFAULT '0',
  `reports-daily_sales` tinyint(1) DEFAULT '0',
  `reports-monthly_sales` tinyint(1) DEFAULT '0',
  `reports-sales` tinyint(1) DEFAULT '0',
  `reports-payments` tinyint(1) DEFAULT '0',
  `reports-purchases` tinyint(1) DEFAULT '0',
  `reports-profit_loss` tinyint(1) DEFAULT '0',
  `reports-customers` tinyint(1) DEFAULT '0',
  `reports-suppliers` tinyint(1) DEFAULT '0',
  `reports-staff` tinyint(1) DEFAULT '0',
  `reports-register` tinyint(1) DEFAULT '0',
  `sales-payments` tinyint(1) DEFAULT '0',
  `purchases-payments` tinyint(1) DEFAULT '0',
  `purchases-expenses` tinyint(1) DEFAULT '0',
  `products-adjustments` tinyint(1) NOT NULL DEFAULT '0',
  `bulk_actions` tinyint(1) NOT NULL DEFAULT '0',
  `customers-deposits` tinyint(1) NOT NULL DEFAULT '0',
  `customers-delete_deposit` tinyint(1) NOT NULL DEFAULT '0',
  `products-barcode` tinyint(1) NOT NULL DEFAULT '0',
  `purchases-return_purchases` tinyint(1) NOT NULL DEFAULT '0',
  `reports-expenses` tinyint(1) NOT NULL DEFAULT '0',
  `reports-daily_purchases` tinyint(1) DEFAULT '0',
  `reports-monthly_purchases` tinyint(1) DEFAULT '0',
  `products-stock_count` tinyint(1) DEFAULT '0',
  `edit_price` tinyint(1) DEFAULT '0',
  `returns-index` tinyint(1) DEFAULT '0',
  `returns-add` tinyint(1) DEFAULT '0',
  `returns-edit` tinyint(1) DEFAULT '0',
  `returns-delete` tinyint(1) DEFAULT '0',
  `returns-email` tinyint(1) DEFAULT '0',
  `returns-pdf` tinyint(1) DEFAULT '0',
  `reports-tax` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_permissions`
--

INSERT INTO `sma_permissions` (`id`, `group_id`, `products-index`, `products-add`, `products-edit`, `products-delete`, `products-cost`, `products-price`, `quotes-index`, `quotes-add`, `quotes-edit`, `quotes-pdf`, `quotes-email`, `quotes-delete`, `sales-index`, `sales-add`, `sales-edit`, `sales-pdf`, `sales-email`, `sales-delete`, `purchases-index`, `purchases-add`, `purchases-edit`, `purchases-pdf`, `purchases-email`, `purchases-delete`, `transfers-index`, `transfers-add`, `transfers-edit`, `transfers-pdf`, `transfers-email`, `transfers-delete`, `customers-index`, `customers-add`, `customers-edit`, `customers-delete`, `suppliers-index`, `suppliers-add`, `suppliers-edit`, `suppliers-delete`, `sales-deliveries`, `sales-add_delivery`, `sales-edit_delivery`, `sales-delete_delivery`, `sales-email_delivery`, `sales-pdf_delivery`, `sales-gift_cards`, `sales-add_gift_card`, `sales-edit_gift_card`, `sales-delete_gift_card`, `pos-index`, `sales-return_sales`, `reports-index`, `reports-warehouse_stock`, `reports-quantity_alerts`, `reports-expiry_alerts`, `reports-products`, `reports-daily_sales`, `reports-monthly_sales`, `reports-sales`, `reports-payments`, `reports-purchases`, `reports-profit_loss`, `reports-customers`, `reports-suppliers`, `reports-staff`, `reports-register`, `sales-payments`, `purchases-payments`, `purchases-expenses`, `products-adjustments`, `bulk_actions`, `customers-deposits`, `customers-delete_deposit`, `products-barcode`, `purchases-return_purchases`, `reports-expenses`, `reports-daily_purchases`, `reports-monthly_purchases`, `products-stock_count`, `edit_price`, `returns-index`, `returns-add`, `returns-edit`, `returns-delete`, `returns-email`, `returns-pdf`, `reports-tax`) VALUES
(1, 5, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_pos_register`
--

CREATE TABLE `sma_pos_register` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `cash_in_hand` decimal(25,4) NOT NULL,
  `status` varchar(10) NOT NULL,
  `total_cash` decimal(25,4) DEFAULT NULL,
  `total_cheques` int(11) DEFAULT NULL,
  `total_cc_slips` int(11) DEFAULT NULL,
  `total_cash_submitted` decimal(25,4) DEFAULT NULL,
  `total_cheques_submitted` int(11) DEFAULT NULL,
  `total_cc_slips_submitted` int(11) DEFAULT NULL,
  `note` text,
  `closed_at` timestamp NULL DEFAULT NULL,
  `transfer_opened_bills` varchar(50) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_pos_register`
--

INSERT INTO `sma_pos_register` (`id`, `date`, `user_id`, `cash_in_hand`, `status`, `total_cash`, `total_cheques`, `total_cc_slips`, `total_cash_submitted`, `total_cheques_submitted`, `total_cc_slips_submitted`, `note`, `closed_at`, `transfer_opened_bills`, `closed_by`) VALUES
(1, '2023-11-08 02:25:52', 2, '25000000.0000', 'open', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_pos_settings`
--

CREATE TABLE `sma_pos_settings` (
  `pos_id` int(1) NOT NULL,
  `cat_limit` int(11) NOT NULL,
  `pro_limit` int(11) NOT NULL,
  `default_category` int(11) NOT NULL,
  `default_customer` int(11) NOT NULL,
  `default_biller` int(11) NOT NULL,
  `display_time` varchar(3) NOT NULL DEFAULT 'yes',
  `cf_title1` varchar(255) DEFAULT NULL,
  `cf_title2` varchar(255) DEFAULT NULL,
  `cf_value1` varchar(255) DEFAULT NULL,
  `cf_value2` varchar(255) DEFAULT NULL,
  `receipt_printer` varchar(55) DEFAULT NULL,
  `cash_drawer_codes` varchar(55) DEFAULT NULL,
  `focus_add_item` varchar(55) DEFAULT NULL,
  `add_manual_product` varchar(55) DEFAULT NULL,
  `customer_selection` varchar(55) DEFAULT NULL,
  `add_customer` varchar(55) DEFAULT NULL,
  `toggle_category_slider` varchar(55) DEFAULT NULL,
  `toggle_subcategory_slider` varchar(55) DEFAULT NULL,
  `cancel_sale` varchar(55) DEFAULT NULL,
  `suspend_sale` varchar(55) DEFAULT NULL,
  `print_items_list` varchar(55) DEFAULT NULL,
  `finalize_sale` varchar(55) DEFAULT NULL,
  `today_sale` varchar(55) DEFAULT NULL,
  `open_hold_bills` varchar(55) DEFAULT NULL,
  `close_register` varchar(55) DEFAULT NULL,
  `keyboard` tinyint(1) NOT NULL,
  `pos_printers` varchar(255) DEFAULT NULL,
  `java_applet` tinyint(1) NOT NULL,
  `product_button_color` varchar(20) NOT NULL DEFAULT 'default',
  `tooltips` tinyint(1) DEFAULT '1',
  `paypal_pro` tinyint(1) DEFAULT '0',
  `stripe` tinyint(1) DEFAULT '0',
  `rounding` tinyint(1) DEFAULT '0',
  `char_per_line` tinyint(4) DEFAULT '42',
  `pin_code` varchar(20) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT 'purchase_code',
  `envato_username` varchar(50) DEFAULT 'envato_username',
  `version` varchar(10) DEFAULT '3.4.38',
  `after_sale_page` tinyint(1) DEFAULT '0',
  `item_order` tinyint(1) DEFAULT '0',
  `authorize` tinyint(1) DEFAULT '0',
  `toggle_brands_slider` varchar(55) DEFAULT NULL,
  `remote_printing` tinyint(1) DEFAULT '1',
  `printer` int(11) DEFAULT NULL,
  `order_printers` varchar(55) DEFAULT NULL,
  `auto_print` tinyint(1) DEFAULT '0',
  `customer_details` tinyint(1) DEFAULT NULL,
  `local_printers` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_pos_settings`
--

INSERT INTO `sma_pos_settings` (`pos_id`, `cat_limit`, `pro_limit`, `default_category`, `default_customer`, `default_biller`, `display_time`, `cf_title1`, `cf_title2`, `cf_value1`, `cf_value2`, `receipt_printer`, `cash_drawer_codes`, `focus_add_item`, `add_manual_product`, `customer_selection`, `add_customer`, `toggle_category_slider`, `toggle_subcategory_slider`, `cancel_sale`, `suspend_sale`, `print_items_list`, `finalize_sale`, `today_sale`, `open_hold_bills`, `close_register`, `keyboard`, `pos_printers`, `java_applet`, `product_button_color`, `tooltips`, `paypal_pro`, `stripe`, `rounding`, `char_per_line`, `pin_code`, `purchase_code`, `envato_username`, `version`, `after_sale_page`, `item_order`, `authorize`, `toggle_brands_slider`, `remote_printing`, `printer`, `order_printers`, `auto_print`, `customer_details`, `local_printers`) VALUES
(1, 22, 20, 1, 1, 3, '1', 'GST Reg', 'VAT Reg', '123456789', '987654321', 'BIXOLON SRP-350II', 'x1C', 'Ctrl+F3', 'Ctrl+Shift+M', 'Ctrl+Shift+C', 'Ctrl+Shift+A', 'Ctrl+F11', 'Ctrl+F12', 'F4', 'F7', 'F9', 'F8', 'Ctrl+F1', 'Ctrl+F2', 'Ctrl+F10', 1, 'BIXOLON SRP-350II, BIXOLON SRP-350II', 0, 'default', 1, 0, 0, 0, 42, NULL, 'purchase_code', 'envato_username', '3.4.38', 0, 0, 0, NULL, 1, NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_price_groups`
--

CREATE TABLE `sma_price_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_price_groups`
--

INSERT INTO `sma_price_groups` (`id`, `name`) VALUES
(1, 'Default');

-- --------------------------------------------------------

--
-- Table structure for table `sma_printers`
--

CREATE TABLE `sma_printers` (
  `id` int(11) NOT NULL,
  `title` varchar(55) NOT NULL,
  `type` varchar(25) NOT NULL,
  `profile` varchar(25) NOT NULL,
  `char_per_line` tinyint(3) UNSIGNED DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `ip_address` varbinary(45) DEFAULT NULL,
  `port` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_production`
--

CREATE TABLE `sma_production` (
  `id` int(11) NOT NULL,
  `reff_doc` varchar(50) NOT NULL,
  `status_doc` varchar(20) NOT NULL,
  `created_by` varchar(20) NOT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `note` varchar(100) NOT NULL,
  `total_cost` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_production`
--

INSERT INTO `sma_production` (`id`, `reff_doc`, `status_doc`, `created_by`, `created_date`, `note`, `total_cost`) VALUES
(1, '20231118-1', 'Finish', '2', '2023-11-18 11:33:32', '', '0.0000'),
(2, '20231118-2', 'Finish', '2', '2023-11-18 11:39:19', '', '0.0000'),
(3, '20231118-3', 'Reject', '2', '2023-11-18 11:43:19', 'dikarenakan mesin rusak', '0.0000'),
(4, '20231118-4', 'Finish', '2', '2023-11-18 11:48:57', '', '0.0000'),
(5, '20231118-5', 'Finish', '2', '2023-11-18 11:51:29', 'dikarenakan mesin rusak', '0.0000'),
(6, '20231118-6', 'Reject', '2', '2023-11-18 23:46:23', 'dikarenakan mesin rusak', '750000.0000'),
(7, '20231118-7', 'Reject', '2', '2023-11-18 23:51:13', 'dikarenakan mesin rusak', '30000.0000'),
(8, '20231118-8', 'Reject', '2', '2023-11-18 23:59:54', 'dikarenakan mesin rusak', '30000.0000'),
(9, '20231119-1', 'Reject', '2', '2023-11-19 00:01:22', 'dikarenakan mesin rusak', '30000.0000'),
(10, '20231119-2', 'Reject', '2', '2023-11-19 00:04:28', 'dikarenakan mesin rusak', '30000.0000'),
(11, '20231119-3', 'Reject', '2', '2023-11-19 00:06:23', 'dikarenakan mesin rusak', '30000.0000'),
(12, '20231119-4', 'Reject', '2', '2023-11-19 00:07:06', 'dikarenakan mesin rusak', '30000.0000'),
(13, '20231119-5', 'Reject', '2', '2023-11-19 00:08:29', 'dikarenakan mesin rusak', '30000.0000'),
(14, '20231119-6', 'Reject', '2', '2023-11-19 00:08:55', 'dikarenakan mesin rusak', '100000.0000'),
(15, '20231119-7', 'On Production', '2', '2023-11-19 14:45:39', '', '0.0000'),
(16, '20231119-8', 'Finish', '2', '2023-11-19 15:03:41', '', '100150000.0000'),
(17, '20231125-1', 'Finish', '2', '2023-11-25 08:38:52', '', '3280000.0000'),
(18, '20231125-2', 'Finish', '2', '2023-11-25 08:41:51', '', '2460000.0000'),
(19, '20231125-3', 'Finish', '2', '2023-11-25 08:46:11', '', '820000.0000'),
(20, '20231125-4', 'Finish', '2', '2023-11-25 08:50:56', '', '410000.0000'),
(21, '20231125-5', 'Finish', '2', '2023-11-25 08:52:06', '', '246000.0000'),
(22, '20231125-6', 'Finish', '2', '2023-11-25 09:02:49', '', '410000.0000'),
(23, '20231125-7', 'Finish', '2', '2023-11-25 09:05:59', '', '410000.0000'),
(24, '20231125-8', 'Finish', '2', '2023-11-25 09:08:53', '', '410000.0000'),
(25, '20231126-1', 'Finish', '2', '2023-11-26 13:36:21', '', '820000.0000'),
(26, '20231126-2', 'Finish', '2', '2023-11-26 14:43:44', '', '820000.0000'),
(27, '20231126-3', 'Finish', '2', '2023-11-26 14:50:53', '', '410000.0000'),
(28, '20231129-1', 'Finish', '2', '2023-11-29 18:45:04', '', '188000.0000'),
(29, '20231201-1', 'Finish', '2', '2023-12-01 20:08:06', '', '710000.0000'),
(30, '20231201-2', 'Finish', '2', '2023-12-01 22:21:32', '', '346000.0000'),
(31, '20231201-3', 'Finish', '2', '2023-12-01 22:23:14', '', '428000.0000'),
(32, '20231201-4', 'On Production', '2', '2023-12-01 22:25:09', '', '530000.0000'),
(33, '20231202-1', 'Finish', '2', '2023-12-02 09:25:26', '', '50000.0000'),
(34, '20231202-2', 'Finish', '2', '2023-12-02 09:35:36', '', '10000.0000'),
(35, '20231208-1', 'Finish', '2', '2023-12-08 20:24:09', '', '100000000.0000'),
(36, '20231210-1', 'Finish', '2', '2023-12-10 13:58:41', '', '10000000.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_production_items`
--

CREATE TABLE `sma_production_items` (
  `id` int(11) NOT NULL,
  `reff_doc` varchar(50) NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `product_code` varchar(20) NOT NULL,
  `qty` float NOT NULL,
  `unit_id` int(10) UNSIGNED NOT NULL,
  `unit_code` varchar(20) NOT NULL,
  `type_item` varchar(10) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `purchase_id` varchar(20) NOT NULL,
  `product_unit_cost` decimal(15,4) NOT NULL,
  `product_total_cost` decimal(15,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sma_production_items`
--

INSERT INTO `sma_production_items` (`id`, `reff_doc`, `product_id`, `product_code`, `qty`, `unit_id`, `unit_code`, `type_item`, `warehouse_id`, `purchase_id`, `product_unit_cost`, `product_total_cost`) VALUES
(1, '20231118-1', 22, 'RM0004', 60, 3, 'KG', 'raw', 1, '19', '10000.0000', '16720.0000'),
(2, '20231118-1', 19, 'RM0002', 2, 1, 'Pcs', 'raw', 1, '17', '15000.0000', '195000.0000'),
(3, '20231118-2', 22, 'RM0004', 60, 3, 'KG', 'raw', 1, '19', '10000.0000', '960.0000'),
(4, '20231118-2', 19, 'RM0002', 2, 1, 'Pcs', 'raw', 1, '17', '15000.0000', '30000.0000'),
(5, '20231118-3', 22, 'RM0004', 50, 3, 'KG', 'raw', 1, '19', '400.0000', '800.0000'),
(6, '20231118-4', 22, 'RM0004', 50, 3, 'KG', 'raw', 1, '19', '400.0000', '32.0000'),
(7, '20231118-5', 22, 'RM0004', 50, 3, 'KG', 'raw', 1, '19', '400.0000', '20000.0000'),
(14, '20231118-1', 20, 'FG0001', 20, 2, 'ZAK', 'goods', 1, '26', '211720.0000', '4234400.0000'),
(15, '20231118-2', 20, 'FG0001', 15, 2, 'ZAK', 'goods', 1, '27', '30960.0000', '464400.0000'),
(16, '20231118-4', 20, 'FG0001', 5, 2, 'ZAK', 'goods', 1, '28', '32.0000', '32.0000'),
(17, '20231118-6', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '750000.0000'),
(18, '20231118-7', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(19, '20231118-8', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(20, '20231119-1', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(21, '20231119-2', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(22, '20231119-3', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(23, '20231119-4', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(24, '20231119-5', 22, 'RM0004', 3, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '30000.0000'),
(25, '20231119-6', 22, 'RM0004', 10, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '100000.0000'),
(26, '20231119-8', 22, 'RM0004', 15, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '150000.0000'),
(27, '20231119-8', 21, 'RM0003', 100, 3, 'KG', 'raw', 1, '9', '500500.0000', '100000000.0000'),
(28, '20231119-8', 20, 'FG0001', 30, 2, 'ZAK', 'goods', 1, '29', '100150000.0000', '100150000.0000'),
(29, '20231125-1', 18, 'RM0001', 40, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '3280000.0000'),
(30, '20231125-1', 20, 'FG0001', 12, 2, 'ZAK', 'goods', 1, '32', '3280000.0000', '3280000.0000'),
(31, '20231125-2', 18, 'RM0001', 30, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '2460000.0000'),
(32, '20231125-2', 20, 'FG0001', 13, 2, 'ZAK', 'goods', 1, '33', '2460000.0000', '2460000.0000'),
(33, '20231125-3', 18, 'RM0001', 10, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '820000.0000'),
(34, '20231125-3', 20, 'FG0001', 3, 2, 'ZAK', 'goods', 1, '34', '820000.0000', '820000.0000'),
(35, '20231125-4', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '410000.0000'),
(36, '20231125-4', 20, 'FG0001', 1, 2, 'ZAK', 'goods', 1, '35', '410000.0000', '410000.0000'),
(37, '20231125-5', 18, 'RM0001', 3, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '246000.0000'),
(38, '20231125-5', 20, 'FG0001', 1, 2, 'ZAK', 'goods', 1, '36', '246000.0000', '246000.0000'),
(39, '20231125-6', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '410000.0000'),
(40, '20231125-6', 20, 'FG0001', 1, 2, 'ZAK', 'goods', 1, '37', '410000.0000', '410000.0000'),
(41, '20231125-7', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 1, '7', '82000.0000', '410000.0000'),
(42, '20231125-7', 23, 'FG0002', 2, 2, 'ZAK', 'goods', 1, '38', '410000.0000', '410000.0000'),
(43, '20231125-8', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '410000.0000'),
(44, '20231125-8', 23, 'FG0002', 2, 2, 'ZAK', 'goods', 3, '39', '410000.0000', '410000.0000'),
(45, '20231126-1', 18, 'RM0001', 10, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '820000.0000'),
(46, '20231126-1', 23, 'FG0002', 10, 2, 'ZAK', 'goods', 1, '40', '820000.0000', '820000.0000'),
(47, '20231126-2', 18, 'RM0001', 10, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '820000.0000'),
(48, '20231126-2', 24, 'FG0003', 30, 2, 'ZAK', 'goods', 1, '41', '820000.0000', '820000.0000'),
(49, '20231126-3', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 1, '7', '82000.0000', '410000.0000'),
(50, '20231126-3', 24, 'FG0003', 25, 2, 'ZAK', 'goods', 1, '42', '410000.0000', '410000.0000'),
(51, '20231129-1', 18, 'RM0001', 2, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '164000.0000'),
(52, '20231129-1', 22, 'RM0004', 60, 3, 'KG', 'raw', 1, '19', '400.0000', '24000.0000'),
(53, '20231129-1', 23, 'FG0002', 15, 2, 'ZAK', 'goods', 1, '43', '141000.0000', '141000.0000'),
(54, '20231129-1', 20, 'FG0001', 5, 2, 'ZAK', 'goods', 1, '44', '47000.0000', '47000.0000'),
(55, '20231201-1', 19, 'RM0002', 20, 1, 'Pcs', 'raw', 1, '17', '15000.0000', '300000.0000'),
(56, '20231201-1', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 2, '45', '82000.0000', '410000.0000'),
(57, '20231201-1', 20, 'FG0001', 4, 2, 'ZAK', 'goods', 1, '46', '177500.0000', '710000.0000'),
(58, '20231201-2', 18, 'RM0001', 3, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '246000.0000'),
(59, '20231201-2', 22, 'RM0004', 10, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '100000.0000'),
(60, '20231201-2', 24, 'FG0003', 5, 2, 'ZAK', 'goods', 1, '47', '69200.0000', '346000.0000'),
(61, '20231201-3', 18, 'RM0001', 4, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '328000.0000'),
(62, '20231201-3', 22, 'RM0004', 10, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '20000.0000'),
(63, '20231201-3', 23, 'FG0002', 10, 2, 'ZAK', 'goods', 1, '48', '34800.0000', '348000.0000'),
(64, '20231201-4', 18, 'RM0001', 5, 1, 'Pcs', 'raw', 3, '31', '82000.0000', '410000.0000'),
(65, '20231201-4', 22, 'RM0004', 12, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '120000.0000'),
(66, '20231202-1', 22, 'RM0004', 5, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '50000.0000'),
(67, '20231202-1', 26, 'FG0005', 100, 2, 'ZAK', 'goods', 1, '61', '500.0000', '50000.0000'),
(68, '20231202-2', 22, 'RM0004', 1, 2, 'ZAK', 'raw', 1, '19', '10000.0000', '10000.0000'),
(69, '20231202-2', 27, 'FG0006', 100, 2, 'ZAK', 'goods', 1, '64', '100.0000', '10000.0000'),
(70, '20231208-1', 21, 'RM0003', 100, 3, 'KG', 'raw', 1, '9', '1000000.0000', '100000000.0000'),
(71, '20231208-1', 28, 'FG0007', 100, 2, 'ZAK', 'goods', 1, '74', '1000000.0000', '100000000.0000'),
(72, '20231210-1', 21, 'RM0003', 10, 3, 'KG', 'raw', 1, '9', '1000000.0000', '10000000.0000'),
(73, '20231210-1', 29, 'FG0008', 100, 2, 'ZAK', 'goods', 1, '78', '100000.0000', '10000000.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_products`
--

CREATE TABLE `sma_products` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` int(11) DEFAULT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) NOT NULL,
  `alert_quantity` decimal(15,4) DEFAULT '20.0000',
  `image` varchar(255) DEFAULT 'no_image.png',
  `category_id` int(11) NOT NULL,
  `subcategory_id` int(11) DEFAULT NULL,
  `cf1` varchar(255) DEFAULT NULL,
  `cf2` varchar(255) DEFAULT NULL,
  `cf3` varchar(255) DEFAULT NULL,
  `cf4` varchar(255) DEFAULT NULL,
  `cf5` varchar(255) DEFAULT NULL,
  `cf6` varchar(255) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `tax_rate` int(11) DEFAULT NULL,
  `track_quantity` tinyint(1) DEFAULT '1',
  `details` varchar(1000) DEFAULT NULL,
  `warehouse` int(11) DEFAULT NULL,
  `barcode_symbology` varchar(55) NOT NULL DEFAULT 'code128',
  `file` varchar(100) DEFAULT NULL,
  `product_details` text,
  `tax_method` tinyint(1) DEFAULT '0',
  `type` varchar(55) NOT NULL DEFAULT 'standard',
  `supplier1` int(11) DEFAULT NULL,
  `supplier1price` decimal(25,4) DEFAULT NULL,
  `supplier2` int(11) DEFAULT NULL,
  `supplier2price` decimal(25,4) DEFAULT NULL,
  `supplier3` int(11) DEFAULT NULL,
  `supplier3price` decimal(25,4) DEFAULT NULL,
  `supplier4` int(11) DEFAULT NULL,
  `supplier4price` decimal(25,4) DEFAULT NULL,
  `supplier5` int(11) DEFAULT NULL,
  `supplier5price` decimal(25,4) DEFAULT NULL,
  `promotion` tinyint(1) DEFAULT '0',
  `promo_price` decimal(25,4) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `supplier1_part_no` varchar(50) DEFAULT NULL,
  `supplier2_part_no` varchar(50) DEFAULT NULL,
  `supplier3_part_no` varchar(50) DEFAULT NULL,
  `supplier4_part_no` varchar(50) DEFAULT NULL,
  `supplier5_part_no` varchar(50) DEFAULT NULL,
  `sale_unit` int(11) DEFAULT NULL,
  `purchase_unit` int(11) DEFAULT NULL,
  `brand` int(11) DEFAULT NULL,
  `slug` varchar(55) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `weight` decimal(10,4) DEFAULT NULL,
  `hsn_code` int(11) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT '0',
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `second_name` varchar(255) DEFAULT NULL,
  `hide_pos` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_products`
--

INSERT INTO `sma_products` (`id`, `code`, `name`, `unit`, `cost`, `price`, `alert_quantity`, `image`, `category_id`, `subcategory_id`, `cf1`, `cf2`, `cf3`, `cf4`, `cf5`, `cf6`, `quantity`, `tax_rate`, `track_quantity`, `details`, `warehouse`, `barcode_symbology`, `file`, `product_details`, `tax_method`, `type`, `supplier1`, `supplier1price`, `supplier2`, `supplier2price`, `supplier3`, `supplier3price`, `supplier4`, `supplier4price`, `supplier5`, `supplier5price`, `promotion`, `promo_price`, `start_date`, `end_date`, `supplier1_part_no`, `supplier2_part_no`, `supplier3_part_no`, `supplier4_part_no`, `supplier5_part_no`, `sale_unit`, `purchase_unit`, `brand`, `slug`, `featured`, `weight`, `hsn_code`, `views`, `hide`, `second_name`, `hide_pos`) VALUES
(18, 'RM0001', 'Terigu Jawara', 1, '82000.0000', '90000.0000', '0.0000', 'no_image.png', 2, NULL, '', '', '', '', '', '', '3.0000', 1, 1, '', NULL, 'code128', '', '', 1, 'standard', 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 1, 1, 0, 'terigu-jawara', NULL, '25.0000', NULL, 0, 0, 'Terigu Jawara', 0),
(19, 'RM0002', 'Garam Klosok', 1, '15000.0000', '15000.0000', '35.0000', 'no_image.png', 1, NULL, '', '', '', '', '', '', '5.0000', 1, 1, '', NULL, 'code128', '', '', 1, 'standard', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 1, 1, 0, 'garam-klosok', NULL, '50.0000', NULL, 0, 0, 'Garam Klosok', 0),
(20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 2, NULL, '97000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '100.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 0, 0, 1, 'mie-kering-tujuh-mangkok-bal', NULL, '5.0000', NULL, 0, 0, 'Mie Kering Tujuh Mangkok - Bal', 0),
(21, 'RM0003', 'Pewarna Merah', 3, '1000.0000', '1000.0000', '0.0000', 'no_image.png', 1, NULL, '', '', '', '', '', '', '9689.9000', 1, 0, '', NULL, 'code128', '', '', 1, 'standard', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 3, 3, 0, 'pewarna-merah', NULL, '1.0000', NULL, 0, 0, 'Pewarna Merah', 0),
(22, 'RM0004', 'Primephos 578', 2, '10000.0000', '12000.0000', '0.0000', 'no_image.png', 4, NULL, '', '', '', '', '', '', '45.6000', 1, 1, '', NULL, 'code128', '', '', 1, 'standard', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 0, 'primephos-578', NULL, '1.0000', NULL, 0, 0, 'Primephos 578', 0),
(23, 'FG0002', 'Mie Bihun', 2, NULL, '10000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '15.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 1, 'mie-bihun', NULL, '12.0000', NULL, 0, 0, 'Mie Bihun', 0),
(24, 'FG0003', 'Mie Kwetiaw', 2, NULL, '15000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '7.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 1, 'mie-kwetiaw', NULL, '10.0000', NULL, 0, 0, 'Mie Kwetiaw', 0),
(25, 'FG0004', 'Mie Kue', 2, NULL, '12000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '0.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 1, 'mie-kue', NULL, '12.0000', NULL, 0, 0, 'Mie Kue', 0),
(26, 'FG0005', 'Mie Transfer', 2, NULL, '150000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '100.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 1, 'mie-transfer', NULL, '25.0000', NULL, 0, 0, 'Mie Transfer', 0),
(27, 'FG0006', 'Mie Transfer 2', 2, NULL, '12000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '100.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 0, 'mie-transfer-2', NULL, '25.0000', NULL, 0, 0, 'Mie Transfer 2', 0),
(28, 'FG0007', 'Mie Retur', 2, '8000.0000', '13000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '37.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 0, 'mie-retur', NULL, '25.0000', NULL, 0, 0, 'Mie Retur', 0),
(29, 'FG0008', 'Mie Damage', 2, '10000.0000', '25000.0000', '0.0000', 'no_image.png', 3, NULL, '', '', '', '', '', '', '93.0000', 1, 0, '', NULL, 'code128', '', '', 1, 'combo', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, 2, 2, 1, 'mie-damage', NULL, '25.0000', NULL, 0, 0, 'Mie Damage', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_product_photos`
--

CREATE TABLE `sma_product_photos` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `photo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_product_prices`
--

CREATE TABLE `sma_product_prices` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price_group_id` int(11) NOT NULL,
  `price` decimal(25,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_product_variants`
--

CREATE TABLE `sma_product_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `cost` decimal(25,4) DEFAULT NULL,
  `price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_promos`
--

CREATE TABLE `sma_promos` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `product2buy` int(11) NOT NULL,
  `product2get` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_purchases`
--

CREATE TABLE `sma_purchases` (
  `id` int(11) NOT NULL,
  `reference_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(11) NOT NULL,
  `supplier` varchar(55) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `note` varchar(1000) NOT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `product_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_discount` decimal(25,4) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT NULL,
  `product_tax` decimal(25,4) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `paid` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `status` varchar(55) DEFAULT '',
  `payment_status` varchar(20) DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `return_purchase_ref` varchar(55) DEFAULT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `return_purchase_total` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_purchases`
--

INSERT INTO `sma_purchases` (`id`, `reference_no`, `date`, `supplier_id`, `supplier`, `warehouse_id`, `note`, `total`, `product_discount`, `order_discount_id`, `order_discount`, `total_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `paid`, `status`, `payment_status`, `created_by`, `updated_by`, `updated_at`, `attachment`, `payment_term`, `due_date`, `return_id`, `surcharge`, `return_purchase_ref`, `purchase_id`, `return_purchase_total`, `cgst`, `sgst`, `igst`) VALUES
(1, '123123', '2023-11-08 02:11:00', 4, 'PT. Bogasari Flour Mills', 1, '', '100000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '15000.0000', '115000.0000', '115000.0000', 'received', 'paid', 2, 2, '2023-11-08 02:14:47', NULL, 7, '2023-11-15', NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(2, '11', '2023-11-09 21:01:00', 2, 'Supplier Company Name', 1, '', '200000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '200000.0000', '0.0000', 'received', 'pending', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(3, '0003/PO/WTPS/XI/2023', '2023-11-12 12:03:00', 4, 'PT. Bogasari Flour Mills', 1, '', '820000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '15000.0000', '835000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-12 12:20:58', NULL, 7, '2023-11-19', NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(4, '0004/PO/WTPS/XI/2023', '2023-11-13 14:13:00', 2, 'Supplier Company Name', 1, '', '10000000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '10000000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-13 14:16:25', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(5, '0005/PO/WTPS/XI/2023', '2023-11-13 14:18:00', 4, 'PT. Bogasari Flour Mills', 1, '', '30000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 2, '3000.0000', '3000.0000', '15000.0000', '48000.0000', '0.0000', 'received', 'pending', 4, 2, '2023-11-14 03:22:05', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(6, '0006/PO/WTPS/XI/2023', '2023-11-15 03:04:00', 2, 'Supplier Company Name', 3, '', '200000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '5000.0000', '205000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-16 12:40:30', NULL, 7, '2023-11-22', NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(7, '0007/PO/WTPS/XI/2023', '2023-11-16 13:20:00', 4, 'PT. Bogasari Flour Mills', 1, '', '375000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '375000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-16 13:20:42', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(8, '0008/PO/WTPS/XI/2023', '2023-11-16 13:22:00', 4, 'PT. Bogasari Flour Mills', 1, '', '450000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '450000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-16 13:22:48', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(9, '0009/PO/WTPS/XI/2023', '2023-11-18 03:17:00', 4, 'PT. Bogasari Flour Mills', 1, '', '1000000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '1000000.0000', '500000.0000', 'received', 'partial', 2, 2, '2023-11-18 03:17:46', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(16, '20231118-1', '2023-11-18 08:45:24', 999, 'own', 999, '', '211720.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '211720.0000', '211720.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(17, '20231118-2', '2023-11-18 08:48:53', 999, 'own', 999, '', '30960.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '30960.0000', '30960.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(18, '20231118-4', '2023-11-18 15:37:12', 999, 'own', 999, '', '32.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '32.0000', '32.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(19, '20231119-8', '2023-11-19 08:09:31', 999, 'own', 999, '', '100150000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '100150000.0000', '100150000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(20, '0014/PO/WTPS/XI/2023', '2023-11-25 01:37:00', 4, 'PT. Bogasari Flour Mills', 3, '', '12300000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '12300000.0000', '0.0000', 'received', 'pending', 2, 2, '2023-11-25 01:38:16', NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(21, '20231125-1', '2023-11-25 01:39:33', 999, 'own', 999, '', '3280000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '3280000.0000', '3280000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(22, '20231125-2', '2023-11-25 01:42:06', 999, 'own', 999, '', '2460000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '2460000.0000', '2460000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(23, '20231125-3', '2023-11-25 01:46:27', 999, 'own', 999, '', '820000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '820000.0000', '820000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(24, '20231125-4', '2023-11-25 01:51:13', 999, 'own', 999, '', '410000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '410000.0000', '410000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(25, '20231125-5', '2023-11-25 01:52:29', 999, 'own', 999, '', '246000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '246000.0000', '246000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(26, '20231125-6', '2023-11-25 02:03:01', 999, 'own', 999, '', '410000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '410000.0000', '410000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(27, '20231125-7', '2023-11-25 02:06:13', 999, 'own', 999, '', '410000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '410000.0000', '410000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(28, '20231125-8', '2023-11-25 02:09:06', 999, 'own', 999, '', '410000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '410000.0000', '410000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(29, '20231126-1', '2023-11-26 06:36:36', 999, 'own', 999, '', '820000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '820000.0000', '820000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(30, '20231126-2', '2023-11-26 07:44:17', 999, 'own', 999, '', '820000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '820000.0000', '820000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(31, '20231126-3', '2023-11-26 07:51:15', 999, 'own', 999, '', '410000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '410000.0000', '410000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(32, '20231129-1', '2023-11-29 12:10:47', 999, 'own', 999, '', '188000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '188000.0000', '188000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(33, '20231201-1', '2023-12-01 15:17:08', 999, 'own', 999, '', '710000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '710000.0000', '710000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(34, '20231201-2', '2023-12-01 15:22:37', 999, 'own', 999, '', '346000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '346000.0000', '346000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(35, '20231201-3', '2023-12-01 15:24:33', 999, 'own', 999, '', '348000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '348000.0000', '348000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(36, '20231202-1', '2023-12-02 02:25:41', 999, 'own', 999, '', '50000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '50000.0000', '50000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(37, '20231202-2', '2023-12-02 02:35:48', 999, 'own', 999, '', '10000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '10000.0000', '10000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(39, '0001/RET/WTPS/XII/2023', '2023-12-08 13:14:19', 999, 'own', 999, '', '30000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '30000.0000', '30000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(40, '20231208-1', '2023-12-08 13:24:52', 999, 'own', 999, '', '100000000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '100000000.0000', '100000000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(41, '0002/RET/WTPS/XII/2023', '2023-12-08 13:29:05', 999, 'own', 999, '', '195000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '195000.0000', '195000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(42, '0003/RET/WTPS/XII/2023', '2023-12-08 14:26:08', 999, 'own', 999, '', '39000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '39000.0000', '39000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(43, '0004/RET/WTPS/XII/2023', '2023-12-08 14:34:00', 999, 'own', 999, '', '13000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '13000.0000', '13000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(44, '20231210-1', '2023-12-10 06:58:55', 999, 'own', 999, '', '10000000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '10000000.0000', '10000000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL),
(45, '0005/RET/WTPS/XII/2023', '2023-12-10 07:04:28', 999, 'own', 999, '', '250000.0000', NULL, NULL, NULL, NULL, NULL, 1, NULL, '0.0000', '0.0000', '250000.0000', '250000.0000', 'received', 'paid', 2, NULL, NULL, NULL, 0, NULL, NULL, '0.0000', NULL, NULL, '0.0000', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_purchase_items`
--

CREATE TABLE `sma_purchase_items` (
  `id` int(11) NOT NULL,
  `purchase_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) DEFAULT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(50) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(20) DEFAULT NULL,
  `discount` varchar(20) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `quantity_balance` decimal(15,4) DEFAULT '0.0000',
  `date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  `quantity_received` decimal(15,4) DEFAULT NULL,
  `supplier_part_no` varchar(50) DEFAULT NULL,
  `purchase_item_id` int(11) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `base_unit_cost` decimal(25,4) DEFAULT NULL,
  `product_batch` varchar(20) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_purchase_items`
--

INSERT INTO `sma_purchase_items` (`id`, `purchase_id`, `transfer_id`, `product_id`, `product_code`, `product_name`, `option_id`, `net_unit_cost`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `expiry`, `subtotal`, `quantity_balance`, `date`, `status`, `unit_cost`, `real_unit_cost`, `quantity_received`, `supplier_part_no`, `purchase_item_id`, `product_unit_id`, `product_unit_code`, `unit_quantity`, `gst`, `cgst`, `sgst`, `igst`, `base_unit_cost`, `product_batch`) VALUES
(2, 1, NULL, 1, '57750585', 'Terigu', NULL, '10000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '100000.0000', '0.0000', '2023-11-08', 'received', '10000.0000', '10000.0000', '10.0000', NULL, NULL, 1, 'raw01', '10.0000', NULL, NULL, NULL, NULL, '10000.0000', ''),
(3, NULL, 1, 1, '57750585', 'Terigu', NULL, '10000.0000', '5.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '50000.0000', '0.0000', '2023-11-08', 'received', '10000.0000', '10000.0000', NULL, NULL, NULL, 1, 'raw01', '5.0000', NULL, NULL, NULL, NULL, NULL, ''),
(4, NULL, NULL, 4, '74562677', 'Garam', NULL, '3000.0000', '1.0000', 1, '0.0000', 1, '0', NULL, NULL, NULL, '3000.0000', '2.0000', '2023-11-10', 'received', '3000.0000', '3000.0000', '1.0000', NULL, NULL, 1, 'raw01', '1.0000', NULL, NULL, NULL, NULL, NULL, ''),
(5, 2, NULL, 1, '57750585', 'Terigu', NULL, '10000.0000', '20.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '200000.0000', '8.0000', '2023-11-10', 'received', '10000.0000', '10000.0000', '20.0000', NULL, NULL, 1, 'raw01', '20.0000', NULL, NULL, NULL, NULL, '10000.0000', ''),
(7, 3, NULL, 18, 'RM0001', 'Terigu Jawara', NULL, '82000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '820000.0000', '0.0000', '2023-11-12', 'received', '82000.0000', '82000.0000', '10.0000', NULL, NULL, 1, 'Pcs', '10.0000', NULL, NULL, NULL, NULL, '82000.0000', ''),
(9, 4, NULL, 21, 'RM0003', 'Pewarna Merah', NULL, '1000000.0000', '10000.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '10000000.0000', '9659.9000', '2023-11-13', 'received', '1000000.0000', '1000000.0000', '10000.0000', NULL, NULL, 3, 'KG', '10.0000', NULL, NULL, NULL, NULL, '1000.0000', ''),
(11, 5, NULL, 21, 'RM0003', 'Pewarna Merah', NULL, '1000.0000', '30.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '30000.0000', '30.0000', '2023-11-13', 'received', '1000.0000', '1000.0000', '30.0000', NULL, NULL, 3, 'KG', '30.0000', NULL, NULL, NULL, NULL, '1000.0000', ''),
(13, 6, NULL, 22, 'RM0004', 'Primephos 578', NULL, '10000.0000', '20.0000', 3, '0.0000', 1, '0', '0', '0.0000', NULL, '200000.0000', '0.0000', '2023-11-15', 'received', '10000.0000', '10000.0000', '20.0000', NULL, NULL, 2, 'ZAK', '20.0000', NULL, NULL, NULL, NULL, '10000.0000', ''),
(15, 7, NULL, 19, 'RM0002', 'Garam Klosok', NULL, '15000.0000', '25.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '375000.0000', '0.0000', '2023-11-16', 'received', '15000.0000', '15000.0000', '25.0000', NULL, NULL, 1, 'Pcs', '25.0000', NULL, NULL, NULL, NULL, '15000.0000', ''),
(17, 8, NULL, 19, 'RM0002', 'Garam Klosok', NULL, '15000.0000', '30.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '450000.0000', '5.0000', '2023-11-16', 'received', '15000.0000', '15000.0000', '30.0000', NULL, NULL, 1, 'Pcs', '30.0000', NULL, NULL, NULL, NULL, '15000.0000', ''),
(19, 9, NULL, 22, 'RM0004', 'Primephos 578', NULL, '10000.0000', '100.0000', 1, '0.0000', 1, '0', '0', '0.0000', NULL, '1000000.0000', '45.6000', '2023-11-18', 'received', '10000.0000', '10000.0000', '100.0000', NULL, NULL, 2, 'ZAK', '100.0000', NULL, NULL, NULL, NULL, '10000.0000', ''),
(26, 16, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '211720.0000', '20.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '4234400.0000', '10.0000', '2023-11-18', 'received', '211720.0000', '211720.0000', '20.0000', NULL, NULL, 2, 'ZAK', '20.0000', NULL, NULL, NULL, NULL, '211720.0000', ''),
(27, 17, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '30960.0000', '15.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '464400.0000', '15.0000', '2023-11-18', 'received', '30960.0000', '30960.0000', '15.0000', NULL, NULL, 2, 'ZAK', '15.0000', NULL, NULL, NULL, NULL, '30960.0000', ''),
(28, 18, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '32.0000', '5.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '32.0000', '5.0000', '2023-11-18', 'received', '32.0000', '32.0000', '5.0000', NULL, NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, '32.0000', ''),
(29, 19, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '100150000.0000', '30.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '100150000.0000', '30.0000', '2023-11-19', 'received', '100150000.0000', '100150000.0000', '30.0000', NULL, NULL, 2, 'ZAK', '30.0000', NULL, NULL, NULL, NULL, '100150000.0000', ''),
(31, 20, NULL, 18, 'RM0001', 'Terigu Jawara', NULL, '82000.0000', '150.0000', 3, '0.0000', 1, '0', '0', '0.0000', NULL, '12300000.0000', '1.0000', '2023-11-25', 'received', '82000.0000', '82000.0000', '150.0000', NULL, NULL, 1, 'Pcs', '150.0000', NULL, NULL, NULL, NULL, '82000.0000', ''),
(32, 21, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '3280000.0000', '12.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '3280000.0000', '12.0000', '2023-11-25', 'received', '3280000.0000', '3280000.0000', '12.0000', NULL, NULL, 2, 'ZAK', '12.0000', NULL, NULL, NULL, NULL, '3280000.0000', '20231125-1'),
(33, 22, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '2460000.0000', '13.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '2460000.0000', '13.0000', '2023-11-25', 'received', '2460000.0000', '2460000.0000', '13.0000', NULL, NULL, 2, 'ZAK', '13.0000', NULL, NULL, NULL, NULL, '2460000.0000', '20231125-2'),
(34, 23, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '820000.0000', '3.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '820000.0000', '3.0000', '2023-11-25', 'received', '820000.0000', '820000.0000', '3.0000', NULL, NULL, 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, '820000.0000', '20231125-3'),
(35, 24, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '410000.0000', '1.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '410000.0000', '1.0000', '2023-11-25', 'received', '410000.0000', '410000.0000', '1.0000', NULL, NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, '410000.0000', '20231125-4'),
(36, 25, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '246000.0000', '1.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '246000.0000', '1.0000', '2023-11-25', 'received', '246000.0000', '246000.0000', '1.0000', NULL, NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, '246000.0000', '20231125-5'),
(37, 26, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '410000.0000', '1.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '410000.0000', '1.0000', '2023-11-25', 'received', '410000.0000', '410000.0000', '1.0000', NULL, NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, '410000.0000', '20231125-6'),
(38, 27, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '410000.0000', '2.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '410000.0000', '0.0000', '2023-11-25', 'received', '410000.0000', '410000.0000', '2.0000', NULL, NULL, 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, '410000.0000', '20231125-7'),
(39, 28, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '410000.0000', '2.0000', 3, NULL, 1, NULL, NULL, NULL, NULL, '410000.0000', '0.0000', '2023-11-25', 'received', '410000.0000', '410000.0000', '2.0000', NULL, NULL, 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, '410000.0000', '20231125-8'),
(40, 29, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '820000.0000', '10.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '820000.0000', '0.0000', '2023-11-26', 'received', '820000.0000', '820000.0000', '10.0000', NULL, NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, '820000.0000', '20231126-1'),
(41, 30, NULL, 24, 'FG0003', 'Mie Kwetiaw', NULL, '820000.0000', '30.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '820000.0000', '0.0000', '2023-11-26', 'received', '820000.0000', '820000.0000', '30.0000', NULL, NULL, 2, 'ZAK', '30.0000', NULL, NULL, NULL, NULL, '820000.0000', '20231126-2'),
(42, 31, NULL, 24, 'FG0003', 'Mie Kwetiaw', NULL, '410000.0000', '25.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '410000.0000', '0.0000', '2023-11-26', 'received', '410000.0000', '410000.0000', '25.0000', NULL, NULL, 2, 'ZAK', '25.0000', NULL, NULL, NULL, NULL, '410000.0000', '20231126-3'),
(43, 32, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '141000.0000', '15.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '141000.0000', '0.0000', '2023-11-29', 'received', '141000.0000', '141000.0000', '15.0000', NULL, NULL, 2, 'ZAK', '15.0000', NULL, NULL, NULL, NULL, '141000.0000', '20231129-1'),
(44, 32, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '47000.0000', '5.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '47000.0000', '5.0000', '2023-11-29', 'received', '47000.0000', '47000.0000', '5.0000', NULL, NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, '47000.0000', '20231129-1'),
(45, NULL, 2, 18, 'RM0001', 'Terigu Jawara', NULL, '82000.0000', '20.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '1640000.0000', '2.0000', '2023-12-01', 'received', '82000.0000', '82000.0000', NULL, NULL, NULL, 1, 'Pcs', '20.0000', NULL, NULL, NULL, NULL, NULL, ''),
(46, 33, NULL, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', NULL, '177500.0000', '4.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '710000.0000', '4.0000', '2023-12-01', 'received', '177500.0000', '177500.0000', '4.0000', NULL, NULL, 2, 'ZAK', '4.0000', NULL, NULL, NULL, NULL, '177500.0000', '20231201-1'),
(47, 34, NULL, 24, 'FG0003', 'Mie Kwetiaw', NULL, '69200.0000', '5.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '346000.0000', '5.0000', '2023-12-01', 'received', '69200.0000', '69200.0000', '5.0000', NULL, NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, '69200.0000', '20231201-2'),
(48, 35, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '34800.0000', '10.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '348000.0000', '6.0000', '2023-12-01', 'received', '34800.0000', '34800.0000', '10.0000', NULL, NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, '34800.0000', '20231201-3'),
(49, NULL, 3, 24, 'FG0003', 'Mie Kwetiaw', NULL, '0.0000', '2.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '2.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, NULL, '20231201-2'),
(50, NULL, 4, 23, 'FG0002', 'Mie Bihun', NULL, '0.0000', '3.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '3.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, NULL, '20231201-3'),
(60, NULL, 14, 23, 'FG0002', 'Mie Bihun', NULL, '0.0000', '3.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '3.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, NULL, '20231201-3'),
(61, 36, NULL, 26, 'FG0005', 'Mie Transfer', NULL, '500.0000', '100.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '50000.0000', '88.0000', '2023-12-02', 'received', '500.0000', '500.0000', '100.0000', NULL, NULL, 2, 'ZAK', '100.0000', NULL, NULL, NULL, NULL, '500.0000', '20231202-1'),
(62, NULL, 15, 26, 'FG0005', 'Mie Transfer', NULL, '0.0000', '2.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '2.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, NULL, '20231202-1'),
(63, NULL, 16, 26, 'FG0005', 'Mie Transfer', NULL, '0.0000', '10.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '10.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL, '20231202-1'),
(64, 37, NULL, 27, 'FG0006', 'Mie Transfer 2', NULL, '100.0000', '100.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '10000.0000', '85.0000', '2023-12-02', 'received', '100.0000', '100.0000', '100.0000', NULL, NULL, 2, 'ZAK', '100.0000', NULL, NULL, NULL, NULL, '100.0000', '20231202-2'),
(65, NULL, 17, 27, 'FG0006', 'Mie Transfer 2', NULL, '0.0000', '10.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '7.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL, '20231202-2'),
(66, NULL, 18, 27, 'FG0006', 'Mie Transfer 2', NULL, '0.0000', '5.0000', 2, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '5.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, NULL, '20231202-2'),
(67, NULL, 19, 27, 'FG0006', 'Mie Transfer 2', NULL, '0.0000', '3.0000', 1, '0.0000', 1, '0', NULL, NULL, NULL, '0.0000', '3.0000', '2023-12-02', 'received', '0.0000', NULL, NULL, NULL, NULL, 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, NULL, '20231202-2'),
(71, 39, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '10000.0000', '1.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '10000.0000', '1.0000', '2023-12-08', 'received', '10000.0000', '10000.0000', '1.0000', NULL, NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, '10000.0000', '20231129-1'),
(72, 39, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '10000.0000', '2.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '20000.0000', '2.0000', '2023-12-08', 'received', '10000.0000', '10000.0000', '2.0000', NULL, NULL, 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, '10000.0000', '20231126-1'),
(73, 39, NULL, 23, 'FG0002', 'Mie Bihun', NULL, '10000.0000', '0.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '0.0000', '0.0000', '2023-12-08', 'received', '10000.0000', '10000.0000', '0.0000', NULL, NULL, 2, 'ZAK', '0.0000', NULL, NULL, NULL, NULL, '10000.0000', '20231125-8'),
(74, 40, NULL, 28, 'FG0007', 'Mie Retur', NULL, '1000000.0000', '100.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '100000000.0000', '30.0000', '2023-12-08', 'received', '1000000.0000', '1000000.0000', '100.0000', NULL, NULL, 2, 'ZAK', '100.0000', NULL, NULL, NULL, NULL, '1000000.0000', '20231208-1'),
(75, 41, NULL, 28, 'FG0007', 'Mie Retur', NULL, '13000.0000', '15.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '195000.0000', '3.0000', '2023-12-08', 'received', '13000.0000', '13000.0000', '15.0000', NULL, NULL, 2, 'ZAK', '15.0000', NULL, NULL, NULL, NULL, '13000.0000', '20231208-1'),
(76, 42, NULL, 28, 'FG0007', 'Mie Retur', NULL, '13000.0000', '3.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '39000.0000', '3.0000', '2023-12-08', 'received', '13000.0000', '13000.0000', '3.0000', NULL, NULL, 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, '13000.0000', '20231208-1'),
(77, 43, NULL, 28, 'FG0007', 'Mie Retur', NULL, '13000.0000', '1.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '13000.0000', '1.0000', '2023-12-08', 'received', '13000.0000', '13000.0000', '1.0000', NULL, NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, '13000.0000', '20231208-1'),
(78, 44, NULL, 29, 'FG0008', 'Mie Damage', NULL, '100000.0000', '100.0000', 1, NULL, 1, NULL, NULL, NULL, NULL, '10000000.0000', '90.0000', '2023-12-10', 'received', '100000.0000', '100000.0000', '100.0000', NULL, NULL, 2, 'ZAK', '100.0000', NULL, NULL, NULL, NULL, '100000.0000', '20231210-1'),
(79, 45, NULL, 29, 'FG0008', 'Mie Damage', NULL, '25000.0000', '10.0000', 4, NULL, 1, NULL, NULL, NULL, NULL, '250000.0000', '3.0000', '2023-12-10', 'received', '25000.0000', '25000.0000', '10.0000', NULL, NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, '25000.0000', '20231210-1');

-- --------------------------------------------------------

--
-- Table structure for table `sma_quotes`
--

CREATE TABLE `sma_quotes` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `internal_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `status` varchar(20) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `supplier` varchar(55) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_quote_items`
--

CREATE TABLE `sma_quote_items` (
  `id` int(11) NOT NULL,
  `quote_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_returns`
--

CREATE TABLE `sma_returns` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `staff_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_items` smallint(6) DEFAULT NULL,
  `paid` decimal(25,4) DEFAULT '0.0000',
  `surcharge` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `delv_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_returns`
--

INSERT INTO `sma_returns` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `grand_total`, `created_by`, `updated_by`, `updated_at`, `total_items`, `paid`, `surcharge`, `attachment`, `hash`, `cgst`, `sgst`, `igst`, `shipping`, `delv_id`) VALUES
(2, '2023-12-08 13:12:13', '0001/RET/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 4, '', '', '30000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '30000.0000', 2, NULL, NULL, 0, '0.0000', '0.0000', NULL, '35678c89f02b25b4b2e7865e67e9de175c6ce117e3a8ebb13eacc3b75eac92fe', NULL, NULL, NULL, '0.0000', 0),
(3, '2023-12-08 13:28:17', '0002/RET/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 4, '', '', '195000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '195000.0000', 2, NULL, NULL, 0, '0.0000', '0.0000', NULL, '7eaa5c005176c83f5767d143f4324da73f7dc83e3ea7deed72d031db8771e9df', NULL, NULL, NULL, '0.0000', 17),
(4, '2023-12-08 14:25:51', '0003/RET/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 4, '', '', '39000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '39000.0000', 2, NULL, NULL, 0, '0.0000', '0.0000', NULL, '799606dfb0c37a71dbccc4ce696ec5985afd06c4c3a700d0ce867a1027c368da', NULL, NULL, NULL, '0.0000', 17),
(5, '2023-12-08 14:33:30', '0004/RET/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 4, '', '', '13000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '13000.0000', 2, NULL, NULL, 0, '0.0000', '0.0000', NULL, '1a6d3a30c2f3ab76f9809d99c78b63eb4ede587d63130a3ffa392b739d0c4509', NULL, NULL, NULL, '0.0000', 17),
(6, '2023-12-10 07:01:00', '0005/RET/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 4, '', '', '250000.0000', '0.0000', NULL, '0.0000', '0.0000', '0.0000', NULL, '0.0000', '0.0000', '250000.0000', 2, NULL, NULL, 0, '0.0000', '0.0000', NULL, '347559279bba4b671f902e5c12ecbb238f7f4160d74dcdd14841d42ba5bc7aae', NULL, NULL, NULL, '0.0000', 19);

-- --------------------------------------------------------

--
-- Table structure for table `sma_return_items`
--

CREATE TABLE `sma_return_items` (
  `id` int(11) NOT NULL,
  `return_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `product_batch` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_return_items`
--

INSERT INTO `sma_return_items` (`id`, `return_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`, `product_unit_id`, `product_unit_code`, `unit_quantity`, `comment`, `gst`, `cgst`, `sgst`, `igst`, `product_batch`) VALUES
(4, 0, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '1.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '10000.0000', '', '10000.0000', 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, NULL, '20231129-1'),
(5, 0, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '2.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '20000.0000', '', '10000.0000', 2, 'ZAK', '2.0000', NULL, NULL, NULL, NULL, NULL, '20231126-1'),
(6, 0, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '0.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '0.0000', '', '10000.0000', 2, 'ZAK', '0.0000', NULL, NULL, NULL, NULL, NULL, '20231125-8'),
(7, 3, 28, 'FG0007', 'Mie Retur', 'combo', NULL, '13000.0000', '13000.0000', '15.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '195000.0000', '', '13000.0000', 2, 'ZAK', '15.0000', NULL, NULL, NULL, NULL, NULL, '20231208-1'),
(8, 4, 28, 'FG0007', 'Mie Retur', 'combo', NULL, '13000.0000', '13000.0000', '3.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '39000.0000', '', '13000.0000', 2, 'ZAK', '3.0000', NULL, NULL, NULL, NULL, NULL, '20231208-1'),
(9, 5, 28, 'FG0007', 'Mie Retur', 'combo', NULL, '13000.0000', '13000.0000', '1.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '13000.0000', '', '13000.0000', 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, NULL, '20231208-1'),
(10, 6, 29, 'FG0008', 'Mie Damage', 'combo', NULL, '25000.0000', '25000.0000', '10.0000', 4, '0.0000', NULL, '', NULL, '0.0000', '250000.0000', '', '25000.0000', 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL, '20231210-1');

-- --------------------------------------------------------

--
-- Table structure for table `sma_sales`
--

CREATE TABLE `sma_sales` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) NOT NULL,
  `biller_id` int(11) NOT NULL,
  `biller` varchar(55) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `staff_note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `product_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount_id` varchar(20) DEFAULT NULL,
  `total_discount` decimal(25,4) DEFAULT '0.0000',
  `order_discount` decimal(25,4) DEFAULT '0.0000',
  `product_tax` decimal(25,4) DEFAULT '0.0000',
  `order_tax_id` int(11) DEFAULT NULL,
  `order_tax` decimal(25,4) DEFAULT '0.0000',
  `total_tax` decimal(25,4) DEFAULT '0.0000',
  `shipping` decimal(25,4) DEFAULT '0.0000',
  `grand_total` decimal(25,4) NOT NULL,
  `sale_status` varchar(20) DEFAULT NULL,
  `payment_status` varchar(20) DEFAULT NULL,
  `payment_term` tinyint(4) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_items` smallint(6) DEFAULT NULL,
  `pos` tinyint(1) NOT NULL DEFAULT '0',
  `paid` decimal(25,4) DEFAULT '0.0000',
  `return_id` int(11) DEFAULT NULL,
  `surcharge` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `return_sale_ref` varchar(55) DEFAULT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `return_sale_total` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `rounding` decimal(10,4) DEFAULT NULL,
  `suspend_note` varchar(255) DEFAULT NULL,
  `api` tinyint(1) DEFAULT '0',
  `shop` tinyint(1) DEFAULT '0',
  `address_id` int(11) DEFAULT NULL,
  `reserve_id` int(11) DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `manual_payment` varchar(55) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL,
  `payment_method` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_sales`
--

INSERT INTO `sma_sales` (`id`, `date`, `reference_no`, `customer_id`, `customer`, `biller_id`, `biller`, `warehouse_id`, `note`, `staff_note`, `total`, `product_discount`, `order_discount_id`, `total_discount`, `order_discount`, `product_tax`, `order_tax_id`, `order_tax`, `total_tax`, `shipping`, `grand_total`, `sale_status`, `payment_status`, `payment_term`, `due_date`, `created_by`, `updated_by`, `updated_at`, `total_items`, `pos`, `paid`, `return_id`, `surcharge`, `attachment`, `return_sale_ref`, `sale_id`, `return_sale_total`, `rounding`, `suspend_note`, `api`, `shop`, `address_id`, `reserve_id`, `hash`, `manual_payment`, `cgst`, `sgst`, `igst`, `payment_method`) VALUES
(1, '2023-11-08 02:59:03', 'SALE/POS2023/11/0001', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '100000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '100000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '100000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '567c14c4ae6d28db20dde153be49ddc170221a8e4b430dd4bc6c405d79becc06', NULL, NULL, NULL, NULL, NULL),
(2, '2023-11-08 03:20:27', 'SALE/POS2023/11/0002', 1, 'Walk-in Customer', 3, 'Test Biller', 2, '', '', '60000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 3, 1, '60000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '250f0dcb45ca9393c0844c45e0ce81ae93a3b2bc1b24d3061f33e25135b52459', NULL, NULL, NULL, NULL, NULL),
(3, '2023-11-09 20:49:00', 'SALE/POS2023/11/0003', 1, 'Walk-in Customer', 3, 'Test Biller', 2, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'df2d06b2ce28aa3d5697d17661e7617743d8998e7e3d62b669b9c005aaa0e842', NULL, NULL, NULL, NULL, NULL),
(4, '2023-11-09 20:52:32', 'SALE/POS2023/11/0004', 1, 'Walk-in Customer', 3, 'Test Biller', 2, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'e704a42357df9736fc2cef552dc27c48f7d8bb3b680f652c102733f1426698f9', NULL, NULL, NULL, NULL, NULL),
(5, '2023-11-09 21:02:37', 'SALE/POS2023/11/0005', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'a874f9e332391b34032641b73acdfafbdb91554ffc6bb9671fc4aef57c58b97a', NULL, NULL, NULL, NULL, NULL),
(6, '2023-11-11 02:28:33', 'SALE/POS2023/11/0006', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'b771d2911275b3c99ed8c0107d8b5f9fa1484167bc6d0d7cb52237545e36c3b2', NULL, NULL, NULL, NULL, NULL),
(7, '2023-11-11 02:46:30', 'SALE/POS2023/11/0007', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '9cf9c305718d14816d3d5b63beef5e4ab26e83bc6c70b8f90f7da24a85e38b8c', NULL, NULL, NULL, NULL, NULL),
(8, '2023-11-11 02:49:34', 'SALE/POS2023/11/0008', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'bb61be1dd0271d1d9842eae573a92c3ffb8a1355651881836628608c172f6035', NULL, NULL, NULL, NULL, NULL),
(9, '2023-11-11 02:55:26', 'SALE/POS2023/11/0009', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '57846328e70060115961bcff907c641abb33bd97b4e3fbf4d5423a5269528009', NULL, NULL, NULL, NULL, NULL),
(10, '2023-11-11 03:16:52', 'SALE/POS2023/11/0010', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, 'bcf77b4504600e73214ad317eb6adf4f1056326b040154e06982e2cbc4b1f043', NULL, NULL, NULL, NULL, NULL),
(11, '2023-11-11 04:17:50', 'SALE/POS2023/11/0011', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '107ea82301662ac30146fe0f6884d9fbdb83b40cfb5a80a3bfd527970efbfe70', NULL, NULL, NULL, NULL, NULL),
(12, '2023-11-11 04:22:01', 'SALE/POS2023/11/0012', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '4248e8c13846479fdd38eb3292171ee3ea00a9003b05abbbab68314ece603791', NULL, NULL, NULL, NULL, NULL),
(13, '2023-11-11 04:23:27', 'SALE/POS2023/11/0013', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '20000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '20000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 1, 1, '20000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '1e7417212a1a360b7f788f445d37da4e753eff11273bd4f960294288baed9d40', NULL, NULL, NULL, NULL, NULL),
(14, '2023-11-11 04:36:44', 'SALE/POS2023/11/0014', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '60000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 2, 1, '60000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '6c021ae3aa5fdaf1db504a91ecd516879d5a685814324800ef52f797dde86368', NULL, NULL, NULL, NULL, NULL),
(15, '2023-11-13 15:01:46', 'SALE/POS2023/11/0015', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '5000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '5000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 5, 1, '5000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '3e4aad7396697ca906e5086f5aa6843bb3fecc9a50ad0834339ddcfb014678a7', NULL, NULL, NULL, NULL, NULL),
(18, '2023-11-16 13:21:23', 'SALE/POS2023/11/0016', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '150000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '150000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 10, 1, '150000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '97ad09e2ae28cf3127612f32b1966f764260beedeac50442fef2a43673be4c26', NULL, NULL, NULL, NULL, NULL),
(19, '2023-11-16 13:23:26', 'SALE/POS2023/11/0017', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '150000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '150000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 10, 1, '150000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '714fa8e51aad1d93be7ac6ae1c00532ad365cb5ea8c8405a0def198c9a2737a3', NULL, NULL, NULL, NULL, NULL),
(20, '2023-11-16 13:24:24', 'SALE/POS2023/11/0018', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '150000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '150000.0000', 'completed', 'paid', 0, NULL, 2, NULL, NULL, 10, 1, '150000.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', '0.0000', NULL, 0, 0, NULL, NULL, '335f238163e4014d24f7b1e0ec3247087de0518ca2b9c0cc9a2a7f94db56e810', NULL, NULL, NULL, NULL, NULL),
(21, '2023-11-19 08:20:00', '11111', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '970000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '970000.0000', 'completed', 'due', 7, '2023-11-26', 2, NULL, NULL, 10, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '1124b291cf722d9b4fc6763d35c6556f6e59e40dab136628a2ce3c946c09fc91', NULL, NULL, NULL, NULL, NULL),
(22, '2023-11-19 08:31:00', '33333', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '60000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '60000.0000', 'completed', 'due', 7, '2023-11-26', 2, NULL, NULL, 5, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, 'bb0227d306aa34130056e6c0a84f8fa5fec36c9d4500308eb43b8f70ec57701d', NULL, NULL, NULL, NULL, NULL),
(23, '2023-11-19 08:32:00', '66666', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '970000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '970000.0000', 'completed', 'pending', 7, '2023-11-26', 2, NULL, NULL, 10, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '3063202152a8269f127ab52b6fc7466520d177e5eb550a93e3f42b66b0a8fd98', NULL, NULL, NULL, NULL, NULL),
(24, '2023-11-19 08:42:00', '99999', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '970000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '970000.0000', 'completed', 'pending', 7, '2023-11-26', 2, NULL, NULL, 10, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '0d7c03d33b3083cd9ccf91f41aba1e6e6c2cccf78d5ba2247642bdf1d2ea0f9b', NULL, NULL, NULL, NULL, NULL),
(25, '2023-11-19 08:42:00', '99999', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '970000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '970000.0000', 'completed', 'pending', 7, '2023-11-26', 2, NULL, NULL, 10, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '21c339c8392c24018837726f3c3493fa6b42cf1d5b40d85128b94eb304f80055', NULL, NULL, NULL, NULL, NULL),
(26, '2023-11-19 09:19:00', '0024/SO/WTPS/XI/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '485000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '485000.0000', 'completed', 'pending', 7, '2023-11-26', 2, NULL, NULL, 5, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, 'e45bdc06b086dc6af4a7887d6a5bcf4a284e8ef2aec61e89501f7ef88f3b5fb3', NULL, NULL, NULL, NULL, NULL),
(37, '2023-11-25 02:27:00', '0025/SO/WTPS/XI/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '10000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '10000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 1, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '2ea7795489c5c1b82bbd0708ce72582271222deee2327056d10e576d3d0e3a5a', NULL, NULL, NULL, NULL, NULL),
(50, '2023-11-26 07:09:00', '0026/SO/WTPS/XI/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '250000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '250000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 25, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '9a46e28db7fffa02f7ab7d01bac3b1007ddb2693b2057217dca00f8b1cae7a34', NULL, NULL, NULL, NULL, NULL),
(51, '2023-11-26 07:49:00', '0027/SO/WTPS/XI/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '750000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '750000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 50, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '1e13307ec01d3cb31b70f8e433cb13535d8e55cbb5dc0592ea039bbee73f9c02', NULL, NULL, NULL, NULL, NULL),
(52, '2023-11-29 12:27:00', '0028/SO/WTPS/XI/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '200000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 2, '22000.0000', '22000.0000', '0.0000', '222000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 20, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '5c59d600352fa654b1851c389121e801c440eb9792f5545089cc49d5c1a03830', NULL, NULL, NULL, NULL, NULL),
(53, '2023-12-08 13:25:00', '0029/SO/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '3900000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '3900000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 300, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '356d4810b4a78a561acbd6791d1f1372ebc133bac036f3d5be223c9822e4d9ec', NULL, NULL, NULL, NULL, NULL),
(54, '2023-12-10 06:59:00', '0030/SO/WTPS/XII/2023', 1, 'Walk-in Customer', 3, 'Test Biller', 1, '', '', '2000000.0000', '0.0000', '', '0.0000', '0.0000', '0.0000', 1, '0.0000', '0.0000', '0.0000', '2000000.0000', 'completed', 'pending', 0, NULL, 2, NULL, NULL, 80, 0, '0.0000', NULL, '0.0000', NULL, NULL, NULL, '0.0000', NULL, NULL, 0, 0, NULL, NULL, '5a4a0647ad13506c6b355f882e655d5cae44aee1a078f3f628158c0b12578c84', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_sale_items`
--

CREATE TABLE `sma_sale_items` (
  `id` int(11) NOT NULL,
  `sale_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `sale_item_id` int(11) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_sale_items`
--

INSERT INTO `sma_sale_items` (`id`, `sale_id`, `product_id`, `product_code`, `product_name`, `product_type`, `option_id`, `net_unit_price`, `unit_price`, `quantity`, `warehouse_id`, `item_tax`, `tax_rate_id`, `tax`, `discount`, `item_discount`, `subtotal`, `serial_no`, `real_unit_price`, `sale_item_id`, `product_unit_id`, `product_unit_code`, `unit_quantity`, `comment`, `gst`, `cgst`, `sgst`, `igst`) VALUES
(1, 1, 2, '62765470', 'Mie Kering', 'combo', NULL, '100000.0000', '100000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '100000.0000', '', '100000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(2, 2, 1, '57750585', 'Terigu', 'standard', NULL, '20000.0000', '20000.0000', '3.0000', 2, '0.0000', 1, '0', '0', '0.0000', '60000.0000', '', '20000.0000', NULL, 1, 'raw01', '3.0000', '', NULL, NULL, NULL, NULL),
(3, 3, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 2, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(4, 4, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 2, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(5, 5, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(6, 6, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(7, 7, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(8, 8, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(9, 9, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(10, 10, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(11, 11, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(12, 12, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(13, 13, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(14, 14, 11, '79009910', 'Mie Gacor', 'combo', NULL, '20000.0000', '20000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '20000.0000', '', '20000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(15, 14, 13, '03732412', 'mie kering 2', 'combo', NULL, '40000.0000', '40000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '40000.0000', '', '40000.0000', NULL, NULL, NULL, '1.0000', '', NULL, NULL, NULL, NULL),
(16, 15, 21, 'RM0003', 'Pewarna Merah', 'standard', NULL, '1000.0000', '1000.0000', '5.0000', 1, '0.0000', 1, '0', '0', '0.0000', '5000.0000', '', '1000.0000', NULL, 4, 'GRAM', '5.0000', '', NULL, NULL, NULL, NULL),
(19, 18, 19, 'RM0002', 'Garam Klosok', 'standard', NULL, '15000.0000', '15000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '150000.0000', '', '15000.0000', NULL, 1, 'Pcs', '10.0000', '', NULL, NULL, NULL, NULL),
(20, 19, 19, 'RM0002', 'Garam Klosok', 'standard', NULL, '15000.0000', '15000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '150000.0000', '', '15000.0000', NULL, 1, 'Pcs', '10.0000', '', NULL, NULL, NULL, NULL),
(21, 20, 19, 'RM0002', 'Garam Klosok', 'standard', NULL, '15000.0000', '15000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '150000.0000', '', '15000.0000', NULL, 1, 'Pcs', '10.0000', '', NULL, NULL, NULL, NULL),
(22, 21, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 'combo', NULL, '97000.0000', '97000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '970000.0000', '', '97000.0000', NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL),
(23, 22, 22, 'RM0004', 'Primephos 578', 'standard', NULL, '12000.0000', '12000.0000', '5.0000', 1, '0.0000', 1, '0', '0', '0.0000', '60000.0000', '', '12000.0000', NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, NULL),
(24, 23, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 'combo', NULL, '97000.0000', '97000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '970000.0000', '', '97000.0000', NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL),
(25, 24, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 'combo', NULL, '97000.0000', '97000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '970000.0000', '', '97000.0000', NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL),
(26, 25, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 'combo', NULL, '97000.0000', '97000.0000', '10.0000', 1, '0.0000', 1, '0', '0', '0.0000', '970000.0000', '', '97000.0000', NULL, 2, 'ZAK', '10.0000', NULL, NULL, NULL, NULL, NULL),
(27, 26, 20, 'FG0001', 'Mie Kering Tujuh Mangkok - Bal', 'combo', NULL, '97000.0000', '97000.0000', '5.0000', 1, '0.0000', 1, '0', '0', '0.0000', '485000.0000', '', '97000.0000', NULL, 2, 'ZAK', '5.0000', NULL, NULL, NULL, NULL, NULL),
(38, 37, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '1.0000', 1, '0.0000', 1, '0', '0', '0.0000', '10000.0000', '', '10000.0000', NULL, 2, 'ZAK', '1.0000', NULL, NULL, NULL, NULL, NULL),
(50, 50, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '25.0000', 1, '0.0000', 1, '0', '0', '0.0000', '250000.0000', '', '10000.0000', NULL, 2, 'ZAK', '25.0000', NULL, NULL, NULL, NULL, NULL),
(51, 51, 24, 'FG0003', 'Mie Kwetiaw', 'combo', NULL, '15000.0000', '15000.0000', '50.0000', 1, '0.0000', 1, '0', '0', '0.0000', '750000.0000', '', '15000.0000', NULL, 2, 'ZAK', '50.0000', NULL, NULL, NULL, NULL, NULL),
(52, 52, 23, 'FG0002', 'Mie Bihun', 'combo', NULL, '10000.0000', '10000.0000', '20.0000', 1, '0.0000', 1, '0', '0', '0.0000', '200000.0000', '', '10000.0000', NULL, 2, 'ZAK', '20.0000', NULL, NULL, NULL, NULL, NULL),
(53, 53, 28, 'FG0007', 'Mie Retur', 'combo', NULL, '13000.0000', '13000.0000', '300.0000', 1, '0.0000', 1, '0', '0', '0.0000', '3900000.0000', '', '13000.0000', NULL, 2, 'ZAK', '300.0000', NULL, NULL, NULL, NULL, NULL),
(54, 54, 29, 'FG0008', 'Mie Damage', 'combo', NULL, '25000.0000', '25000.0000', '80.0000', 1, '0.0000', 1, '0', '0', '0.0000', '2000000.0000', '', '25000.0000', NULL, 2, 'ZAK', '80.0000', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_sessions`
--

CREATE TABLE `sma_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_sessions`
--

INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('0833ljepnj4dl5nf922e52qd5kf4koc7', '127.0.0.1', 1702197289, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373238393b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0g6dhhd9eua79g9f560hr8fk6j69bh9t', '127.0.0.1', 1702046473, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034363437333b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('0p2lhba0c8v8ilm1ucvrqksq0dv28qjn', '127.0.0.1', 1702138810, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133383831303b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032303431303534223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('129qqlcv5fgbkt07tr0g0hq8rfkv0ldk', '127.0.0.1', 1700986359, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938363335393b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('134lc917nm2m8lqmai0enueboakvnv1o', '127.0.0.1', 1700985160, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938353136303b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1mmuetv5g1hmulgv25ei5m3gf1p6iptn', '127.0.0.1', 1702045527, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034353532373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('1ph2simceut8s4ta02cp3c94912bk981', '127.0.0.1', 1702133995, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133333939353b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032303431303534223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('20d4qnmo59oj21fm4236434hjqossq51', '127.0.0.1', 1700284610, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238343631303b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('21qurhf6ha69tqrbi0oigpvlu88ofnv1', '127.0.0.1', 1700277511, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237373531313b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2264554e497a576b684173324b5258385a53663671223b),
('2868v9fobqcurq55qhgq9knlprjtfofl', '127.0.0.1', 1701865110, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836353131303b7265717565737465645f706167657c733a31373a2261646d696e2f72657475726e732f616464223b),
('2deqa7f80intb4980cq4nr1st19mm1rd', '127.0.0.1', 1701446294, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434363239343b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2e7gsrg075j39flefb5ivcu5ah62ocdv', '127.0.0.1', 1700985723, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938353732333b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2g37lq8i5scgtbnj60q06l2r8kpg0c0b', '127.0.0.1', 1700284912, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238343931323b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('2jb830p2bmbfdahka8oq46na15gs608m', '127.0.0.1', 1701257789, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235373738393b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f7072696e745f626172636f646573223b),
('2kvb5ae579egb2kp7pd2il219d7ta2cl', '127.0.0.1', 1700319310, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331393331303b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2lsi39p6s80dp30id5v508dhfh3q6sp7', '127.0.0.1', 1701259847, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235393834373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2nv00s5qn1juf2tb36e6r2ka2dtsp53m', '127.0.0.1', 1701864992, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836343939323b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2pgkga6m5p0uenqjb2o144rfhb7bnbcj', '127.0.0.1', 1702041388, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034313338383b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('2rs8eolgqnla7ahj9pvccaa3bracoo1r', '127.0.0.1', 1701260395, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236303339353b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b),
('2sr99nghh9f6v4059uge0bkt73q46g1p', '127.0.0.1', 1700879348, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837393232373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b6c6173745f61637469766974797c693a313730303837383732363b),
('2u47kq5ekdt79e1liu80s21dgd6vumb1', '127.0.0.1', 1701174715, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137343731353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3bs3ogj7gac12kq7qeiqeks61e9hcakj', '127.0.0.1', 1702138903, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133383930333b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f6164645f64616d616765223b),
('3cbv4l0d9p67d1mgm1jf11u9ht6uv434', '127.0.0.1', 1700381763, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338313736333b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338313434383b),
('3dronk673ouh4777lf9aripgnbhp53hs', '127.0.0.1', 1701079230, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313037393034343b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303637373038223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38393a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f73746f72616765223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('3es6udi0qv20vjnsb7mmk39salnkkao9', '127.0.0.1', 1702043420, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034333432303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3ii139f4sr1jv367gk5gjsh2ai4huhku', '127.0.0.1', 1700321766, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332313736363b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('3n5u0lqsa9ffevpo6lk1vc4m39bs7eff', '127.0.0.1', 1700978820, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937383832303b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('41mhil06j4950bvj49qphvf3r222kisk', '127.0.0.1', 1701444353, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434343335333b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('46usfhfkjdbt0c281qucq75nfd88so9a', '127.0.0.1', 1700326786, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332363738363b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('474t1khfpi24ktmcovbtui2vm2ppmavg', '127.0.0.1', 1700978517, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937383531373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('4a2bhil5qa6h34hb1ium01vr2aabke05', '127.0.0.1', 1700282479, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238323437393b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b6d6573736167657c733a32393a2250726f64756b736920626572686173696c20646974616d6261686b616e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('4d99dnmrkh3s9ks25pvgqa5c3pdns5qt', '127.0.0.1', 1702197350, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373335303b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f6164645f64616d616765223b),
('4nlu6t50v4r4krbm21o7oh07fl5vd0qj', '127.0.0.1', 1701265053, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236353035333b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('5deqjshpl9tbprcptb03f9o0jg46gm0f', '127.0.0.1', 1701867402, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836373430323b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('5etckq6uia35qiu16u4reabfkt3ebivf', '127.0.0.1', 1701262507, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236323530373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('5gddgt1h2b9s7et1n7baia87agncsuj2', '127.0.0.1', 1702189984, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323138393938343b),
('5k86gg1b8vkektcj1d4g3kma3ma624gl', '127.0.0.1', 1700281350, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238313335303b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b72656d6f76655f706f6c737c733a313a2231223b),
('5p1gb3mfamqdcugk2fom7le9otp36e2g', '127.0.0.1', 1700385854, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338353835343b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('603af1dtjl6gdpvtb543sbr8o9fp9ghd', '127.0.0.1', 1701444040, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434343034303b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('607pn9n9cvl6tgdfmo6jfsnjeqe3fkah', '127.0.0.1', 1702191446, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139313434363b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('619275fmat0b5picguja353nvj6ck6bh', '127.0.0.1', 1701258190, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235383139303b7265717565737465645f706167657c733a33313a2261646d696e2f70726f64756374696f6e2f6164645f70726f64756374696f6e223b),
('63pu13bodhosa9afl4po0gfcknteo9cm', '127.0.0.1', 1700282147, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238323134373b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b6d6573736167657c733a32393a2250726f64756b736920626572686173696c20646974616d6261686b616e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('66bf1v7mg5e9ifnp3soklcmf2jqthk8j', '127.0.0.1', 1701179365, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137393232363b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('69opn9bdsj006v7t3lhnq9ducs00tc0a', '127.0.0.1', 1702045919, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034353931393b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6bkbagvn7c9e5fj86nuffmcr9kfbg98b', '127.0.0.1', 1700982783, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938323738333b7265717565737465645f706167657c733a32323a2261646d696e2f73616c65732f64656c69766572696573223b),
('6f0602j6uskcm9m3gf3658op4agb1h0a', '127.0.0.1', 1701483684, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438333638343b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343830303434223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a39353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f7472616e73666572732f616464223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('6f7nkq2kf67nsieuf444sphpuiaep9jg', '127.0.0.1', 1701970949, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937303934393b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6feic8qln42lhnft2ekma7t7ed7f86u8', '::1', 1701261292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313239323b7265717565737465645f706167657c733a353a2261646d696e223b),
('6h2vdqmks8oo3o5oip2h1cuu1up1atin', '127.0.0.1', 1701177942, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137373934323b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('6ho12qci7t7gvtvk5busoi24eboe3jqs', '127.0.0.1', 1700320389, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332303338393b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6jk4kceo3kkkqb90gkfd3iqmhv7gnduq', '127.0.0.1', 1701873604, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313837333630343b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6lbovl52rvon2r1ufk85cbmtsce0mqne', '127.0.0.1', 1700297314, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303239373331343b7265717565737465645f706167657c733a33343a2261646d696e2f70726f64756374732f66696e6973685f70726f64756374696f6e2f31223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323639333336223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6pc8vugs2fmcnsjmb02620pkdkthk4hm', '127.0.0.1', 1700977733, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937373733333b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6q9jqv88qigp7r4n9tttnktb0onmf2nu', '127.0.0.1', 1700983158, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938333135383b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('6tleu9bh9arc13i3r92ddnsq2atofu0p', '127.0.0.1', 1700321160, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332313136303b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('79bceb0pebvgsmrucufqu67av5un2776', '127.0.0.1', 1700978935, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937383933353b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('7f7imgrumoho084g6ueajcup7tl6m3p4', '127.0.0.1', 1700983484, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938333438343b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7ksj6h3lvi74dofu18t7c4n46niso1qg', '127.0.0.1', 1701178895, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137383839353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('7spj09ncev9j10607qck2lpcl58ko3f7', '127.0.0.1', 1700383365, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338333336353b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338323730323b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('802sharo6ucjiqsdn23abvrkan28e7fv', '127.0.0.1', 1700385854, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338353835343b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333739393230223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('842qgf4lr7a12tb43i6rbpg360au745b', '127.0.0.1', 1701259257, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235393235373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8bugo3sghgfbfujsp77e580qdlbpjp4h', '127.0.0.1', 1700978161, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937383136313b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8f84c6q0i6a8shbetta9os2d185etk2j', '127.0.0.1', 1700981422, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938313432323b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8hl321p2isugsuoq64p9evt78pcv3rrq', '127.0.0.1', 1701482867, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438323836373b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b6572726f727c733a39353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f7472616e73666572732f616464223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('8k2reb6p13kcmv7cvd7ib41mork9l6uf', '127.0.0.1', 1701448712, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434383437393b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8q775msh12bighqpatbhdgc0jscjg5sp', '127.0.0.1', 1701175190, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137353139303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('8rvshtv2688lfhq92di2jkednv18a580', '127.0.0.1', 1700386017, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338363031373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('8ss2uojlcu4tpl9l3427hrcm72v0jta2', '127.0.0.1', 1700980763, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938303736333b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b),
('8uksukah1e4l1lar8fb2gesga28tbbm9', '127.0.0.1', 1700984100, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938343130303b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('903d9qpdr5nplua66l369nvmpq9q5oqj', '127.0.0.1', 1702139123, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133393132333b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032303431303534223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38373a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f73616c6573223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('9134olebc1pu623i3d3pv41j60cbamg6', '127.0.0.1', 1701068032, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313036383033323b7265717565737465645f706167657c733a31323a2261646d696e2f71756f746573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303535373232223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9cbo5d943sv8obk1ggbill8dhpqp7ukd', '127.0.0.1', 1700286996, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238363939363b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b6572726f727c733a3130353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('9dkn08o7mrmpfub4vk4a21jmkg4is2kn', '127.0.0.1', 1700989906, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938393930363b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('9kkf7dll81hen4lgp2b1ncjq05do9hvo', '127.0.0.1', 1700279311, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237393331313b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2264554e497a576b684173324b5258385a53663671223b6572726f727c733a33313a2253746f636b20524d3030303320746964616b20616461206469677564616e67223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('9lillbqdumv1q95hc63l4lriaisqirqs', '127.0.0.1', 1700878125, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837383132353b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b),
('9ru7p36eolvp2ehh2hcagnh424p4f827', '127.0.0.1', 1701177156, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137373135363b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('9vhj4vr4hlenuknk18ci26o1nfsipqhl', '127.0.0.1', 1700327119, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332373131393b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('a4t1gklep5dp7f9cut60s9gnlfulvfgh', '127.0.0.1', 1701055787, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313035353732303b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832353535223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22587a46546675457049387750744a326848597142223b),
('ag0ir7a1b7h19s4su2gf4rqlstflthqn', '127.0.0.1', 1701258605, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235383630353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6d6573736167657c733a31383a22556e69742073756b73657320646975626168223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226e6577223b7d),
('aje0e4p1l46tfumlb4t96mc3ohnk28ap', '127.0.0.1', 1700296608, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303239363630383b7265717565737465645f706167657c733a33343a2261646d696e2f70726f64756374732f66696e6973685f70726f64756374696f6e2f31223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323639333336223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('am86dpkh8iqqpi8m4k4ghlr88r0l7lgg', '127.0.0.1', 1702197609, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373630393b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f6164645f64616d616765223b),
('aru2nams7v3jojlpmlpltpf2stbfjhqk', '127.0.0.1', 1700327349, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332373131393b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('b6os9vrt1q57p9u7u5t63sibckr3invk', '127.0.0.1', 1700319006, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331393030363b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a3130313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f70726f64756374732f70726f64756374696f6e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('b8ippkfhvu4fedmq86miv0vf2fk7ha45', '127.0.0.1', 1700325804, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332353830343b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bcbntuqbv0o2112ptcqlbl5k6ndffgi6', '127.0.0.1', 1701068391, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313036383339313b7265717565737465645f706167657c733a31323a2261646d696e2f71756f746573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303535373232223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2234535a694f566151323862657746396a354b4555223b),
('bds04m66pne454se2a8vjt6i4c7d5d6g', '127.0.0.1', 1700296977, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303239363937373b7265717565737465645f706167657c733a33343a2261646d696e2f70726f64756374732f66696e6973685f70726f64756374696f6e2f31223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323639333336223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('benaip84gj2h79p032u8pj00ubgfa0t5', '127.0.0.1', 1702190072, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139303037323b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bjv7ti1ravq2bhbkl2aa9ofe9td67mgd', '127.0.0.1', 1701443674, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434333637343b7265717565737465645f706167657c733a31363a2261646d696e2f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343334303936223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bpf86d7uohidkcia7be01sfmrjq926de', '127.0.0.1', 1700319846, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331393834363b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bu23511a0b2h7c8h5anl782cm48ho9ub', '127.0.0.1', 1701970090, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937303039303b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('bvr3undpl8o4fru8kuvmd1udcmedk479', '127.0.0.1', 1701481769, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438313736393b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('c8p1s67ua32hekb68q6s4c4k0sjv0vs5', '127.0.0.1', 1700382164, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338323136343b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338313736333b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('c9h76o7bckn61krl2a3n9pb4hgd48t0i', '127.0.0.1', 1700988098, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938383039383b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('cba3pnme18fpphjs232uht4jjmc9ccuj', '127.0.0.1', 1700821599, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303832313539393b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030353733383132223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730303832303131343b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('ccvj0ernshobnvqacpmks64f4mnc30a5', '127.0.0.1', 1700387860, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338373836303b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333739393230223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ckgqnrema8g5ubo4ri0rgkpvi5i3jfct', '127.0.0.1', 1701971976, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937313937363b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('cokgr7ne4s5prfcpjt1rsn18b8a3eacm', '127.0.0.1', 1701446279, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434363237393b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b),
('ct8b6ec98hjd922440685f3lsd00kllt', '127.0.0.1', 1700382641, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338323634313b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338313736333b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('cvkonk8fic5jbs2or38kom347lfe3kdh', '127.0.0.1', 1700878525, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837383532353b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b),
('d0dskcf65ujlopp3ds8sjejb6irbhrdh', '127.0.0.1', 1700982528, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938323532383b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393736303636223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('d0gsnt606guhsrj8pa3kct7a5d7tn19k', '127.0.0.1', 1701265367, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236353336373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('d5fn3grfp50vi76flop97fom7r9hs22i', '127.0.0.1', 1700380932, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338303933323b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b),
('dcbnl175coimaiu8eobdk891mtd65imv', '127.0.0.1', 1701445974, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434353937343b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('dhbmoibici00j0utsj9bvppq7bgofsgp', '127.0.0.1', 1700384974, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338343937343b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338323730323b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('dlco9dvdlvhq8cpq104hbj1qqbr2mltr', '127.0.0.1', 1701176595, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137363539353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('dlekbdhk5jiiop8l4842siu5r3plvdto', '127.0.0.1', 1700287106, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238363939363b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('doo2gvoi2f7iie0d1sbe1ahcl8up916s', '127.0.0.1', 1700878860, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837383836303b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b6c6173745f61637469766974797c693a313730303837383732363b),
('dtr342is45mmaj3ukkcm8v0d48oop95r', '127.0.0.1', 1701258304, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235383330343b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('duaamsfd2siks0a6hq0q4dlcb29tirjj', '127.0.0.1', 1701866723, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836363732333b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('dupv7bkq9ghvq43t8gvavk7rt179e1v3', '127.0.0.1', 1700324171, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332343137313b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('dvkd6hkd82ukr5ak80cjelef5vcgrshk', '127.0.0.1', 1701068703, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313036383730333b7265717565737465645f706167657c733a31323a2261646d696e2f71756f746573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303535373232223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2234535a694f566151323862657746396a354b4555223b),
('eep4dbp4iu7adeooschf86mu6uhcp498', '::1', 1701434082, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313433343037343b7265717565737465645f706167657c733a353a2261646d696e223b6572726f727c733a33373a223c703e4c6f67696e20476167616c2c2053696c616b616e20636f6261206c6167693c2f703e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('emi47i826cjlo3dmgcmbv8c08u94r9h8', '127.0.0.1', 1701969305, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313936393330353b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('enm4mi2svmipsnhhc27obuhirpt4q9h2', '127.0.0.1', 1702046930, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034363933303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('eq09h7qk8g3s8tvdt0ucc9pj018bpj82', '127.0.0.1', 1701970429, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937303432393b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('f2dphldlies3d79f04vt0i7031dmrers', '127.0.0.1', 1700983047, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938333034373b7265717565737465645f706167657c733a32323a2261646d696e2f73616c65732f64656c69766572696573223b),
('f712vrnbtme030d1h7clihhfrin7g8cm', '127.0.0.1', 1701482240, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438323234303b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b),
('fo5shfse7mvr1gnc664oco07uscckh2a', '127.0.0.1', 1700297342, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303239373331343b7265717565737465645f706167657c733a33343a2261646d696e2f70726f64756374732f66696e6973685f70726f64756374696f6e2f31223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323639333336223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('g0rpb3mmb3k8h7t66b9lqt2qk2d0ll93', '127.0.0.1', 1700976914, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937363931343b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('g2t9u8c48k20g2pvr3pbg8g8grvma5mh', '127.0.0.1', 1700285536, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238353533363b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('gccmp8gt219p977pqd608pan80amobot', '127.0.0.1', 1700876215, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837363231353b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('gefl7pduc98nk82r6dlmjfvu2876nl40', '127.0.0.1', 1701265419, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236353336373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('gijmri3rc84q0d889upa9n5f6ruqt2d2', '127.0.0.1', 1700279994, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237393939343b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2264554e497a576b684173324b5258385a53663671223b),
('gjt7bs377vlfmdne4b34e13v3fjto969', '127.0.0.1', 1701264667, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236343636373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('gl1ae07f6guhv6co766jg86d76i3rarr', '127.0.0.1', 1701971288, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937313238383b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a37383a225175616e7469747920726574757220746964616b20626f6c6568206d656c65626968692064656c69766572792028464730303032202d204d696520426968756e205b32303233313132352d385d29223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('go70pqc10g8lpaj3vfd4p979jfgki0np', '127.0.0.1', 1700380617, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338303631373b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b),
('grj6i418ipkrv4c7d9crdfj4u3tq023e', '127.0.0.1', 1701261255, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313235353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('h0lisrm77h5piofm6h3nfaguiu106cp2', '127.0.0.1', 1701972168, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937313937363b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('h4273j0ainnqbs29va8d77nai7frb9dp', '127.0.0.1', 1700320080, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332303038303b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b),
('h9r8bsmjb01s7815c4c4elgtqhp1j2hv', '127.0.0.1', 1701448136, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434383133363b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('hele2267vtr0894srbm04niukq1mvklr', '127.0.0.1', 1700381348, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338313334383b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b),
('hlfreslhk9kb2agm6ldlv6f4tv76nuus', '127.0.0.1', 1700984849, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938343834393b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('hpfr5rm4gh7ku9pel3tdin2tkjaeeg6o', '127.0.0.1', 1702191849, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139313834393b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('hqdprh2o0knke1k2a1vmk94v42s12k7g', '127.0.0.1', 1700388193, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338383139333b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333739393230223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a37363a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('hqqs5ta6r71dtjafjf97sknkacf5rhpb', '127.0.0.1', 1700318663, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331383636333b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a3130313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f70726f64756374732f70726f64756374696f6e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('hrfq5s08v8i3p8ab1crms37j77ajc9i0', '127.0.0.1', 1701078738, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313037383733383b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303637373038223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38393a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f73746f72616765223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('hv2m1s5ivi77fuma54jea3o2inspjsad', '127.0.0.1', 1700976411, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937363431313b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('hvmptud8tni6n6o95ssvpc47eae5qobr', '127.0.0.1', 1701068998, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313036383730333b7265717565737465645f706167657c733a31323a2261646d696e2f71756f746573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303535373232223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2234535a694f566151323862657746396a354b4555223b),
('ienpfnj6kfudvdu0a6tcu3bv6fi3ccda', '127.0.0.1', 1700380280, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338303238303b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b),
('ifot6o28eq7u50eof77vpkvo2mgq1hgq', '127.0.0.1', 1702197314, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373331343b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f6164645f64616d616765223b),
('ih9tk6bbt991f8u20log7k7n4i5kovb8', '127.0.0.1', 1701480422, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438303432323b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b),
('ir0sfr460nt4b7u5cko6va0ifvuj4d3l', '127.0.0.1', 1700277191, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237373139313b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22596d66754b6c524f795a5047614d483945727033223b),
('j2lapo0bp03isc7lefpk53kmjh1p5llh', '127.0.0.1', 1700321464, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332313436343b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('jgencif82qbfqbq0jddrokukjedju7im', '127.0.0.1', 1700286668, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238363636383b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('jhquqf3eoplj733vqf6fj8rm34mnkm8v', '127.0.0.1', 1701448479, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313434383437393b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f766965775f73746f636b223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433333430223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('jk4mfap4k5beo5asf399uoo6o37rkujh', '127.0.0.1', 1700979308, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937393330383b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('jof83q7upg8d5qoh243r070og3sag48u', '127.0.0.1', 1700280843, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238303834333b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b72656d6f76655f706f6c737c733a313a2231223b),
('jp6ml1npe7vhdhbb0219k71s7unic3kl', '127.0.0.1', 1701144547, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313134343534373b7265717565737465645f706167657c733a31383a2261646d696e2f70726f64756374732f616464223b),
('jqumqkujg0qn3qa07vhl4qvpsdmpr6kc', '127.0.0.1', 1700318333, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331383333333b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a3130313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f70726f64756374732f70726f64756374696f6e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('jtarpeo0vgmelbsrmk13jldji5cf8415', '127.0.0.1', 1700879227, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837393232373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b6c6173745f61637469766974797c693a313730303837383732363b),
('k3j74906sa30k4di68pnsjcvno61jdrr', '127.0.0.1', 1700821193, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303832313139333b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030353733383132223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730303832303131343b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('k59lqc722v8qtq59hud1n3avc0sjshpo', '127.0.0.1', 1702138471, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133383437313b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032303431303534223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('k7mt16ac76jn40q8q7mm55c8cpviltk1', '127.0.0.1', 1701178561, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137383536313b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('kdnffmjb40ievstcaf9qbjo8rkvlq3c3', '127.0.0.1', 1700387398, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338373339383b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333739393230223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('kpagg2ooquffk4ff6at0a6o5se9coj8i', '127.0.0.1', 1700977267, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937373236373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a32383a2253746f636b2046473030303220746964616b206d656e63756b757069223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('krii1rebsiiitc5fdg1vatsskqn9mpdj', '127.0.0.1', 1701067975, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313036373937353b7265717565737465645f706167657c733a33323a2261646d696e2f73797374656d5f73657474696e67732f77617265686f75736573223b),
('ksmdkqck009vqgsno4ovkv8tb61gg763', '127.0.0.1', 1700978477, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937383437373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ksmvckbvpsoua3lnh459mvbmaicfcqj4', '127.0.0.1', 1700388343, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338383139333b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333739393230223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a37363a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('l0370ibsdphk5ovoootoj5mg3lrf448g', '127.0.0.1', 1701868970, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836383937303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('l2959cg70l697pckla66omasuf2d49c2', '127.0.0.1', 1700317992, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331373939323b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('l3j27lhbbjvtubv4mee7879p6a88msfv', '127.0.0.1', 1701875749, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313837353631303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('l75r872f2pod8n1p04a4lv19h9mfta1k', '127.0.0.1', 1700285233, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238353233333b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('laba5i0pmcr3vasio162nhv1fek3u7cu', '127.0.0.1', 1701144777, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313134343737373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303738303639223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('ldbqaa56hkfe8mua139dl2gj4l21jack', '127.0.0.1', 1700981049, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938313034393b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('lej0f913r10em1ljrntjru2t4vpo0274', '127.0.0.1', 1702139255, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323133393132333b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032303431303534223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('li9euc7bc14rks2vu42v9rhn8ov46h7p', '127.0.0.1', 1700326480, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332363438303b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('llfbf1uqtvr9pfv3bd68no3etmqb7t8g', '127.0.0.1', 1700386486, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338363438363b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('lvfn57ai9s9a1ppmt0jvqs35f73g7buj', '127.0.0.1', 1701261727, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313732373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('mjso0eqh4apeb2emoddm0p7fu0kkb6da', '127.0.0.1', 1701079044, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313037393034343b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303637373038223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38393a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f73746f72616765223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('mri08r66r4ppaj55478465aomvkqg19o', '127.0.0.1', 1700979027, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303937393032373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('mvgl8sshok27r41ir2fh71v0vvave5jl', '127.0.0.1', 1700980553, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938303535333b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383639373933223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('n40p517aj3lsa54vb8kpamk5o4q19d1o', '127.0.0.1', 1702197653, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373635333b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f72656c737c693a313b),
('n4srguo960h6qmbb0mla18u1rb2qld4k', '127.0.0.1', 1701178256, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137383235363b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('n6hpoclc91bsrfpd7cs9p2nh8ol5gg50', '127.0.0.1', 1701174412, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137343431323b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('n8tqtem8j03fm4rffcogv4da8ono8e3c', '::1', 1701261292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313239323b6572726f727c733a37363a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('namaadudjnui2sbd4repcsgm9rn1cou3', '127.0.0.1', 1702189983, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323138393938333b7265717565737465645f706167657c733a353a2261646d696e223b),
('nbip5if28bsp87cg2qs4ic8cbj4hiloh', '127.0.0.1', 1700573819, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303537333830393b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333835353537223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ndbsahopbprd4def3n8n74p6ldo1sok6', '127.0.0.1', 1700878650, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837383635303b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b),
('nfd5phru78gf52qktak31kfha7ul6sd3', '127.0.0.1', 1700877047, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837373034373b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b),
('nn6jqtcsg72b3glqpbr63v7fi0rk4rhc', '127.0.0.1', 1700278883, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237383838333b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2264554e497a576b684173324b5258385a53663671223b),
('nt3rsv1hin503gq6v08tlji3io122jeu', '127.0.0.1', 1700317309, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303331373330393b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ntmmtn7v5q7g87854t1rumi6k1uugos1', '127.0.0.1', 1701869464, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313836393436343b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('o21cqm2s6rc6c7q0qfkqcchb2qjon320', '127.0.0.1', 1702041804, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034313830343b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('o6676hjh339b27hqsl5e4gb4h03f3tdv', '127.0.0.1', 1700381594, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338313539343b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b),
('o6eabar058au21cunl1842d88sg52j1g', '127.0.0.1', 1701484350, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438343335303b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343830303434223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b),
('o8haesn1c3d58a3ah9n04eebnme69uuj', '127.0.0.1', 1701260430, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236303433303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('oh2vqd25q17g03hta3sjcld3jcu1u7m0', '127.0.0.1', 1701484004, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438343030343b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343830303434223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a39353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f7472616e73666572732f616464223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('ohk6rvq2m8509h6m5b48g33p7tom8oa4', '127.0.0.1', 1701078414, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313037383431343b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303637373038223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38393a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f73746f72616765223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('oive1kuqbp6vl0nt5qcg1jns7jkov2ct', '127.0.0.1', 1701971298, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937313239383b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b),
('ojkd7ift8peoeft0q6bi5cj31ahh33t4', '127.0.0.1', 1701257977, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313235373937373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('ompfhthv9lshfj0eucdn919mncljkulr', '127.0.0.1', 1700825205, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303832353230353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030353733383132223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730303832303131343b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('otuv6tdhdp0k8sesd5gqcpjfv04u5bj4', '127.0.0.1', 1701481451, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438313435313b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('p6opvg4ud2t7gdbm71ghkeuus48cmoku', '127.0.0.1', 1701262829, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236323832393b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('pj8s30b4sngbe1j7ahpfj74jmo28pjk2', '127.0.0.1', 1702042145, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034323134353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('pq5o6ofshsjvm1g7t6jn9e9f6vrpv08f', '127.0.0.1', 1701971597, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313937313539373b7265717565737465645f706167657c733a32343a2261646d696e2f72657475726e732f61646470726f63657373223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031383634303138223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a37383a225175616e7469747920726574757220746964616b20626f6c6568206d656c65626968692064656c69766572792028464730303032202d204d696520426968756e205b32303233313132352d385d29223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('ptj2r0c3pod7bv77skepsnm18qle7j1i', '127.0.0.1', 1701484658, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438343635383b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343830303434223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a39353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f7472616e73666572732f616464223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226f6c64223b7d),
('q1g73p8o1eufhbbvvvtq1qhdqnpksu1f', '127.0.0.1', 1700383063, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338333036333b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338323730323b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('q3n82ung21bfv3b6dfqoode97shrruj2', '127.0.0.1', 1702047401, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034363933303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('q489q54js90diae9descl7rnrq6hbkso', '::1', 1701261292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313239323b),
('q4f879um0ka2cj0hsiilvr09edgo0jro', '127.0.0.1', 1700877762, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837373736323b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b),
('q9rqi2ld0riacfvdl6oi8sv96403p5ah', '127.0.0.1', 1702190702, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139303730323b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('qdii7mqnn16i06vu6teea1netf0f9iqe', '127.0.0.1', 1701483256, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438333235363b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('qhevkd4ap9qu7ogcnpv1n2ts8lf53b79', '127.0.0.1', 1702189983, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323138393938333b),
('qiv72cr9t3edddo3q538vdkps52bdvi9', '127.0.0.1', 1701875610, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313837353631303b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343833323735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('qj48dl22bus2olccvagufgo6ijt4lk87', '127.0.0.1', 1701435971, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313433353937313b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031323537363639223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b),
('qofo5nga53788mmhnqrpcg1bbg2e7d8u', '127.0.0.1', 1701482565, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438323536353b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a39353a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e2f7472616e73666572732f616464223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('qrebat5oobeh072vb2ja77hkdm7kktta', '127.0.0.1', 1702190374, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139303337343b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('qvbdqnsle1efu9eh5873buvcrigc3avd', '127.0.0.1', 1700987426, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938373432363b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('r51vk4je05vpkrtth3m96htdvr77vle9', '127.0.0.1', 1700385426, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338353432363b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030333136333532223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a225657786934504e4168735472384376474c463642223b6c6173745f61637469766974797c693a313730303338323730323b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('rebm13c7bjojfus1gp2p7bj7du79fdms', '127.0.0.1', 1700323858, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332333835383b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('rhrtskafc09ql1j2klefn3aq4s8bm8q5', '::1', 1701261292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313239323b),
('s3n9n61s3sfkpf1hqbqmde8o3vp4ckvm', '127.0.0.1', 1700387466, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303338373436363b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b),
('seqv3rkmo0h450p4nmh3m53mr2sivmru', '127.0.0.1', 1701176626, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137363632363b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b),
('smtoukkni0msqudqei1n5naufhm3jglg', '::1', 1701261292, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236313239313b),
('snqmvchm3c8c5aetrm5rfioce6lj6tst', '127.0.0.1', 1700284282, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238343238323b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b6d6573736167657c733a32393a2250726f64756b736920626572686173696c20646974616d6261686b616e223b5f5f63695f766172737c613a313a7b733a373a226d657373616765223b733a333a226f6c64223b7d),
('sqhr2he32ut2t05pod8gt2adia075ocv', '127.0.0.1', 1700278576, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237383537363b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2264554e497a576b684173324b5258385a53663671223b),
('tm1jesdtbnrtef30sdj0ocihq349lkp4', '127.0.0.1', 1701436091, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313433353937313b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031323537363639223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b),
('tsn6pohkf9khli347pva4g6abjn12nin', '127.0.0.1', 1700984419, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938343431393b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('tsv5hjorlipah0ftromcepokab83ei3l', '127.0.0.1', 1702190758, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139303735383b7265717565737465645f706167657c733a32343a2261646d696e2f73746f726167652f6164645f64616d616765223b),
('tvfdvptv2bmpgsg7b772a3g8r7kk080a', '127.0.0.1', 1700286345, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238363334353b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('u0j994ou9evc9o16sefsr3bj6eo0j84g', '127.0.0.1', 1700989907, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938393930363b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('u7578roaod4i26q2fvfrs3egnca692pu', '127.0.0.1', 1700987119, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303938373131393b7265717565737465645f706167657c733a31353a2261646d696e2f73616c65732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030393832323133223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('u9bh9atgnbpkir3o7aibksg6jpr0nu2l', '127.0.0.1', 1701260801, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313236303830313b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313733353035223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730313236303131313b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b),
('uagj4gmomg1l4lod1ci27mdr6asfa02d', '127.0.0.1', 1702197785, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323139373635333b7265717565737465645f706167657c733a31333a2261646d696e2f73746f72616765223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373032313333353533223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f72656c737c693a313b),
('umak9j9ch10e8rvf0173muhgs1nu43dv', '127.0.0.1', 1700276882, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303237363838323b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a22596d66754b6c524f795a5047614d483945727033223b),
('v8gbh664hg5uehflr8pjhe8mmgt6vb8l', '127.0.0.1', 1701179226, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313137393232363b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031313434343735223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('v8sa94dj2r46fm7h3du1obmcqoblo8rn', '127.0.0.1', 1700282937, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238323933373b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('vb5gn0pnkgs8mffnovkcbihr2ekhppkg', '127.0.0.1', 1700326158, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303332363135383b7265717565737465645f706167657c733a32353a2261646d696e2f70726f64756374732f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323934343032223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b);
INSERT INTO `sma_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('veummdkcq6guldp5t7c5pht2jipgr5vq', '127.0.0.1', 1701482183, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438323138333b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343433363835223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b),
('vhkhuab87so6ku5ugum2ddosa70ipqbh', '127.0.0.1', 1700876516, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303837363531363b7265717565737465645f706167657c733a31313a2261646d696e2f73616c6573223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030383139393731223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a226c4c6d536a46584f57337678556e594369623145223b),
('vkaplchkdm32do3kk6gag3e1p6b5fqon', '127.0.0.1', 1702043786, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730323034333738363b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031393638383738223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('vl9qao266dvf166lrec29enpt1tftqjk', '127.0.0.1', 1701484664, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313438343635383b7265717565737465645f706167657c733a31393a2261646d696e2f7472616e73666572732f616464223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031343830303434223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b72656d6f76655f746f6c737c693a313b),
('vlg9ub3ebeh28637sbpr3630d02jkdka', '127.0.0.1', 1701144777, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730313134343737373b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373031303738303639223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6572726f727c733a38313a223c68343e343034204e6f7420466f756e64213c2f68343e3c703e546865207061676520796f7520617265206c6f6f6b696e6720666f722063616e206e6f7420626520666f756e642e3c2f703e61646d696e223b5f5f63695f766172737c613a313a7b733a353a226572726f72223b733a333a226e6577223b7d),
('vu2qjlcmft455l48j9fdkpdcdcls13q2', '127.0.0.1', 1700281734, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303238313733343b7265717565737465645f706167657c733a32393a2261646d696e2f70726f64756374732f6164645f70726f64756374696f6e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323239333736223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b757365725f637372667c733a32303a2237694b65764c536742576f6e4331613271396651223b),
('vudd1dj0cjdveb7sg3o80sqmhjfirdap', '127.0.0.1', 1700296245, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303239363234353b7265717565737465645f706167657c733a33343a2261646d696e2f70726f64756374732f66696e6973685f70726f64756374696f6e2f31223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030323639333336223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b),
('vvccffkpskejqld4e8lqdp1262ef80qh', '127.0.0.1', 1700825370, 0x5f5f63695f6c6173745f726567656e65726174657c693a313730303832353230353b7265717565737465645f706167657c733a353a2261646d696e223b6964656e746974797c733a393a226f776e6572746f6b6f223b757365726e616d657c733a393a226f776e6572746f6b6f223b656d61696c7c733a32333a22676f6c646c696f6e73746f726540676d61696c2e636f6d223b757365725f69647c733a313a2232223b6f6c645f6c6173745f6c6f67696e7c733a31303a2231373030353733383132223b6c6173745f69707c733a393a223132372e302e302e31223b6176617461727c4e3b67656e6465727c733a343a226d616c65223b67726f75705f69647c733a313a2231223b77617265686f7573655f69647c733a313a2230223b766965775f72696768747c733a313a2231223b656469745f72696768747c733a313a2230223b616c6c6f775f646973636f756e747c733a313a2230223b62696c6c65725f69647c733a313a2230223b636f6d70616e795f69647c4e3b73686f775f636f73747c733a313a2230223b73686f775f70726963657c733a313a2230223b6c6173745f61637469766974797c693a313730303832303131343b72656769737465725f69647c733a313a2231223b636173685f696e5f68616e647c733a31333a2232353030303030302e30303030223b72656769737465725f6f70656e5f74696d657c733a31393a22323032332d31312d30382030393a32353a3532223b);

-- --------------------------------------------------------

--
-- Table structure for table `sma_settings`
--

CREATE TABLE `sma_settings` (
  `setting_id` int(1) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `logo2` varchar(255) NOT NULL,
  `site_name` varchar(55) NOT NULL,
  `language` varchar(20) NOT NULL,
  `default_warehouse` int(2) NOT NULL,
  `accounting_method` tinyint(4) NOT NULL DEFAULT '0',
  `default_currency` varchar(3) NOT NULL,
  `default_tax_rate` int(2) NOT NULL,
  `rows_per_page` int(2) NOT NULL,
  `version` varchar(10) NOT NULL DEFAULT '1.0',
  `default_tax_rate2` int(11) NOT NULL DEFAULT '0',
  `dateformat` int(11) NOT NULL,
  `sales_prefix` varchar(20) DEFAULT NULL,
  `quote_prefix` varchar(20) DEFAULT NULL,
  `purchase_prefix` varchar(20) DEFAULT NULL,
  `transfer_prefix` varchar(20) DEFAULT NULL,
  `delivery_prefix` varchar(20) DEFAULT NULL,
  `payment_prefix` varchar(20) DEFAULT NULL,
  `return_prefix` varchar(20) DEFAULT NULL,
  `returnp_prefix` varchar(20) DEFAULT NULL,
  `expense_prefix` varchar(20) DEFAULT NULL,
  `item_addition` tinyint(1) NOT NULL DEFAULT '0',
  `theme` varchar(20) NOT NULL,
  `product_serial` tinyint(4) NOT NULL,
  `default_discount` int(11) NOT NULL,
  `product_discount` tinyint(1) NOT NULL DEFAULT '0',
  `discount_method` tinyint(4) NOT NULL,
  `tax1` tinyint(4) NOT NULL,
  `tax2` tinyint(4) NOT NULL,
  `overselling` tinyint(1) NOT NULL DEFAULT '0',
  `restrict_user` tinyint(4) NOT NULL DEFAULT '0',
  `restrict_calendar` tinyint(4) NOT NULL DEFAULT '0',
  `timezone` varchar(100) DEFAULT NULL,
  `iwidth` int(11) NOT NULL DEFAULT '0',
  `iheight` int(11) NOT NULL,
  `twidth` int(11) NOT NULL,
  `theight` int(11) NOT NULL,
  `watermark` tinyint(1) DEFAULT NULL,
  `reg_ver` tinyint(1) DEFAULT NULL,
  `allow_reg` tinyint(1) DEFAULT NULL,
  `reg_notification` tinyint(1) DEFAULT NULL,
  `auto_reg` tinyint(1) DEFAULT NULL,
  `protocol` varchar(20) NOT NULL DEFAULT 'mail',
  `mailpath` varchar(55) DEFAULT '/usr/sbin/sendmail',
  `smtp_host` varchar(100) DEFAULT NULL,
  `smtp_user` varchar(100) DEFAULT NULL,
  `smtp_pass` varchar(255) DEFAULT NULL,
  `smtp_port` varchar(10) DEFAULT '25',
  `smtp_crypto` varchar(10) DEFAULT NULL,
  `corn` datetime DEFAULT NULL,
  `customer_group` int(11) NOT NULL,
  `default_email` varchar(100) NOT NULL,
  `mmode` tinyint(1) NOT NULL,
  `bc_fix` tinyint(4) NOT NULL DEFAULT '0',
  `auto_detect_barcode` tinyint(1) NOT NULL DEFAULT '0',
  `captcha` tinyint(1) NOT NULL DEFAULT '1',
  `reference_format` tinyint(1) NOT NULL DEFAULT '1',
  `racks` tinyint(1) DEFAULT '0',
  `attributes` tinyint(1) NOT NULL DEFAULT '0',
  `product_expiry` tinyint(1) NOT NULL DEFAULT '0',
  `decimals` tinyint(2) NOT NULL DEFAULT '2',
  `qty_decimals` tinyint(2) NOT NULL DEFAULT '2',
  `decimals_sep` varchar(2) NOT NULL DEFAULT '.',
  `thousands_sep` varchar(2) NOT NULL DEFAULT ',',
  `invoice_view` tinyint(1) DEFAULT '0',
  `default_biller` int(11) DEFAULT NULL,
  `envato_username` varchar(50) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT NULL,
  `rtl` tinyint(1) DEFAULT '0',
  `each_spent` decimal(15,4) DEFAULT NULL,
  `ca_point` tinyint(4) DEFAULT NULL,
  `each_sale` decimal(15,4) DEFAULT NULL,
  `sa_point` tinyint(4) DEFAULT NULL,
  `update` tinyint(1) DEFAULT '0',
  `sac` tinyint(1) DEFAULT '0',
  `display_all_products` tinyint(1) DEFAULT '0',
  `display_symbol` tinyint(1) DEFAULT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `remove_expired` tinyint(1) DEFAULT '0',
  `barcode_separator` varchar(2) NOT NULL DEFAULT '-',
  `set_focus` tinyint(1) NOT NULL DEFAULT '0',
  `price_group` int(11) DEFAULT NULL,
  `barcode_img` tinyint(1) NOT NULL DEFAULT '1',
  `ppayment_prefix` varchar(20) DEFAULT 'POP',
  `disable_editing` smallint(6) DEFAULT '90',
  `qa_prefix` varchar(55) DEFAULT NULL,
  `update_cost` tinyint(1) DEFAULT NULL,
  `apis` tinyint(1) NOT NULL DEFAULT '0',
  `state` varchar(100) DEFAULT NULL,
  `pdf_lib` varchar(20) DEFAULT 'dompdf',
  `use_code_for_slug` tinyint(1) DEFAULT NULL,
  `ws_barcode_type` varchar(10) DEFAULT 'weight',
  `ws_barcode_chars` tinyint(4) DEFAULT NULL,
  `flag_chars` tinyint(4) DEFAULT NULL,
  `item_code_start` tinyint(4) DEFAULT NULL,
  `item_code_chars` tinyint(4) DEFAULT NULL,
  `price_start` tinyint(4) DEFAULT NULL,
  `price_chars` tinyint(4) DEFAULT NULL,
  `price_divide_by` int(11) DEFAULT NULL,
  `weight_start` tinyint(4) DEFAULT NULL,
  `weight_chars` tinyint(4) DEFAULT NULL,
  `weight_divide_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_settings`
--

INSERT INTO `sma_settings` (`setting_id`, `logo`, `logo2`, `site_name`, `language`, `default_warehouse`, `accounting_method`, `default_currency`, `default_tax_rate`, `rows_per_page`, `version`, `default_tax_rate2`, `dateformat`, `sales_prefix`, `quote_prefix`, `purchase_prefix`, `transfer_prefix`, `delivery_prefix`, `payment_prefix`, `return_prefix`, `returnp_prefix`, `expense_prefix`, `item_addition`, `theme`, `product_serial`, `default_discount`, `product_discount`, `discount_method`, `tax1`, `tax2`, `overselling`, `restrict_user`, `restrict_calendar`, `timezone`, `iwidth`, `iheight`, `twidth`, `theight`, `watermark`, `reg_ver`, `allow_reg`, `reg_notification`, `auto_reg`, `protocol`, `mailpath`, `smtp_host`, `smtp_user`, `smtp_pass`, `smtp_port`, `smtp_crypto`, `corn`, `customer_group`, `default_email`, `mmode`, `bc_fix`, `auto_detect_barcode`, `captcha`, `reference_format`, `racks`, `attributes`, `product_expiry`, `decimals`, `qty_decimals`, `decimals_sep`, `thousands_sep`, `invoice_view`, `default_biller`, `envato_username`, `purchase_code`, `rtl`, `each_spent`, `ca_point`, `each_sale`, `sa_point`, `update`, `sac`, `display_all_products`, `display_symbol`, `symbol`, `remove_expired`, `barcode_separator`, `set_focus`, `price_group`, `barcode_img`, `ppayment_prefix`, `disable_editing`, `qa_prefix`, `update_cost`, `apis`, `state`, `pdf_lib`, `use_code_for_slug`, `ws_barcode_type`, `ws_barcode_chars`, `flag_chars`, `item_code_start`, `item_code_chars`, `price_start`, `price_chars`, `price_divide_by`, `weight_start`, `weight_chars`, `weight_divide_by`) VALUES
(1, 'logo2.png', 'logo_wtps_1_fix.png', 'X', 'indonesian', 1, 0, 'IDR', 1, 10, '3.4.40', 1, 5, 'SALE', 'QUOTE', 'PO', 'TR', 'DO', 'IPAY', 'SR', 'PR', '', 0, 'default', 1, 1, 1, 1, 1, 1, 0, 1, 0, 'Asia/Jakarta', 800, 800, 150, 150, 0, 0, 0, 0, NULL, 'mail', '/usr/sbin/sendmail', 'pop.gmail.com', 'contact@sma.tecdiary.org', 'jEFTM4T63AiQ9dsidxhPKt9CIg4HQjCN58n/RW9vmdC/UDXCzRLR469ziZ0jjpFlbOg43LyoSmpJLBkcAHh0Yw==', '25', NULL, NULL, 1, 'contact@glni.com', 0, 4, 1, 0, 2, 1, 1, 0, 2, 2, '.', ',', 0, 3, 'lordliche', 'a30a355f-edd1-4b2a-9467-3acb49d21f34', 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, '', 0, '-', 0, 1, 1, 'POP', 90, '', 0, 0, 'AN', 'dompdf', 0, 'weight', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sma_skrill`
--

CREATE TABLE `sma_skrill` (
  `id` int(11) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `account_email` varchar(255) NOT NULL DEFAULT 'testaccount2@moneybookers.com',
  `secret_word` varchar(20) NOT NULL DEFAULT 'mbtest',
  `skrill_currency` varchar(3) NOT NULL DEFAULT 'USD',
  `fixed_charges` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_my` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `extra_charges_other` decimal(25,4) NOT NULL DEFAULT '0.0000'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_skrill`
--

INSERT INTO `sma_skrill` (`id`, `active`, `account_email`, `secret_word`, `skrill_currency`, `fixed_charges`, `extra_charges_my`, `extra_charges_other`) VALUES
(1, 1, 'testaccount2@moneybookers.com', 'mbtest', 'USD', '0.0000', '0.0000', '0.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_stock_counts`
--

CREATE TABLE `sma_stock_counts` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reference_no` varchar(55) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `type` varchar(10) NOT NULL,
  `initial_file` varchar(50) NOT NULL,
  `final_file` varchar(50) DEFAULT NULL,
  `brands` varchar(50) DEFAULT NULL,
  `brand_names` varchar(100) DEFAULT NULL,
  `categories` varchar(50) DEFAULT NULL,
  `category_names` varchar(100) DEFAULT NULL,
  `note` text,
  `products` int(11) DEFAULT NULL,
  `rows` int(11) DEFAULT NULL,
  `differences` int(11) DEFAULT NULL,
  `matches` int(11) DEFAULT NULL,
  `missing` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `finalized` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_stock_counts`
--

INSERT INTO `sma_stock_counts` (`id`, `date`, `reference_no`, `warehouse_id`, `type`, `initial_file`, `final_file`, `brands`, `brand_names`, `categories`, `category_names`, `note`, `products`, `rows`, `differences`, `matches`, `missing`, `created_by`, `updated_by`, `updated_at`, `finalized`) VALUES
(1, '2023-11-08 02:21:00', '', 1, 'full', '939fdf9d4f208887ae6b84a4c7a63ebb.csv', NULL, '', '', '', '', NULL, 1, 1, NULL, NULL, NULL, 2, NULL, NULL, NULL),
(2, '2023-11-08 02:22:00', '', 1, 'full', '523b281085a19124f856b700333755a4.csv', NULL, '', '', '', '', NULL, 1, 1, NULL, NULL, NULL, 2, NULL, NULL, NULL),
(3, '2023-11-08 05:16:00', '', 1, 'full', '06400e08a3572d6abf8fbe34b4b63411.csv', NULL, '', '', '', '', NULL, 2, 2, NULL, NULL, NULL, 2, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_stock_count_items`
--

CREATE TABLE `sma_stock_count_items` (
  `id` int(11) NOT NULL,
  `stock_count_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_variant` varchar(55) DEFAULT NULL,
  `product_variant_id` int(11) DEFAULT NULL,
  `expected` decimal(15,4) NOT NULL,
  `counted` decimal(15,4) NOT NULL,
  `cost` decimal(25,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_storage`
--

CREATE TABLE `sma_storage` (
  `id` int(8) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `type_storage` varchar(5) NOT NULL,
  `batch_produksi` varchar(20) NOT NULL,
  `status_storage` varchar(10) NOT NULL,
  `ref_type` varchar(15) NOT NULL,
  `ref_doc` varchar(20) NOT NULL,
  `stock_date` date NOT NULL,
  `created_date` datetime NOT NULL,
  `created_by` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sma_suspended_bills`
--

CREATE TABLE `sma_suspended_bills` (
  `id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(11) NOT NULL,
  `customer` varchar(55) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_tax_id` int(11) DEFAULT NULL,
  `total` decimal(25,4) NOT NULL,
  `biller_id` int(11) DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `suspend_note` varchar(255) DEFAULT NULL,
  `shipping` decimal(15,4) DEFAULT '0.0000',
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_suspended_items`
--

CREATE TABLE `sma_suspended_items` (
  `id` int(11) NOT NULL,
  `suspend_id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) UNSIGNED NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `net_unit_price` decimal(25,4) NOT NULL,
  `unit_price` decimal(25,4) NOT NULL,
  `quantity` decimal(15,4) DEFAULT '0.0000',
  `warehouse_id` int(11) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `discount` varchar(55) DEFAULT NULL,
  `item_discount` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) NOT NULL,
  `serial_no` varchar(255) DEFAULT NULL,
  `option_id` int(11) DEFAULT NULL,
  `product_type` varchar(20) DEFAULT NULL,
  `real_unit_price` decimal(25,4) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_tax_rates`
--

CREATE TABLE `sma_tax_rates` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `rate` decimal(12,4) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_tax_rates`
--

INSERT INTO `sma_tax_rates` (`id`, `name`, `code`, `rate`, `type`) VALUES
(1, 'No Tax', 'NT', '0.0000', '2'),
(2, 'VAT @11%', 'VAT11', '11.0000', '1'),
(3, 'GST @6%', 'GST', '6.0000', '1'),
(4, 'VAT @20%', 'VT20', '20.0000', '1');

-- --------------------------------------------------------

--
-- Table structure for table `sma_transfers`
--

CREATE TABLE `sma_transfers` (
  `id` int(11) NOT NULL,
  `transfer_no` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `from_warehouse_id` int(11) NOT NULL,
  `from_warehouse_code` varchar(55) NOT NULL,
  `from_warehouse_name` varchar(55) NOT NULL,
  `to_warehouse_id` int(11) NOT NULL,
  `to_warehouse_code` varchar(55) NOT NULL,
  `to_warehouse_name` varchar(55) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `total` decimal(25,4) DEFAULT NULL,
  `total_tax` decimal(25,4) DEFAULT NULL,
  `grand_total` decimal(25,4) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `status` varchar(55) NOT NULL DEFAULT 'pending',
  `shipping` decimal(25,4) NOT NULL DEFAULT '0.0000',
  `attachment` varchar(55) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_transfers`
--

INSERT INTO `sma_transfers` (`id`, `transfer_no`, `date`, `from_warehouse_id`, `from_warehouse_code`, `from_warehouse_name`, `to_warehouse_id`, `to_warehouse_code`, `to_warehouse_name`, `note`, `total`, `total_tax`, `grand_total`, `created_by`, `status`, `shipping`, `attachment`, `cgst`, `sgst`, `igst`) VALUES
(1, 'REF1', '2023-11-08 02:41:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '50000.0000', '0.0000', '50000.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(2, 'TR2023/12/0001', '2023-12-01 12:36:00', 3, 'R001', 'Gudang Raw Material', 2, 'WHII', 'Gudang 2', '', '1640000.0000', '0.0000', '1640000.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(3, '0003/TR/WTPS/XII/2023', '2023-12-02 01:48:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(4, '0004/TR/WTPS/XII/2023', '2023-12-02 02:07:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(14, '0005/TR/WTPS/XII/2023', '2023-12-02 02:14:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(15, '0006/TR/WTPS/XII/2023', '2023-12-02 02:26:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(16, '0007/TR/WTPS/XII/2023', '2023-12-02 02:33:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(17, '0008/TR/WTPS/XII/2023', '2023-12-02 02:36:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(18, '0009/TR/WTPS/XII/2023', '2023-12-02 02:36:00', 1, 'WHI', 'Gudang 1', 2, 'WHII', 'Gudang 2', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL),
(19, '0010/TR/WTPS/XII/2023', '2023-12-02 02:37:00', 2, 'WHII', 'Gudang 2', 1, 'WHI', 'Gudang 1', '', '0.0000', '0.0000', '0.0000', '2', 'completed', '0.0000', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_transfer_items`
--

CREATE TABLE `sma_transfer_items` (
  `id` int(11) NOT NULL,
  `transfer_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_code` varchar(55) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `option_id` int(11) DEFAULT NULL,
  `expiry` date DEFAULT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `tax_rate_id` int(11) DEFAULT NULL,
  `tax` varchar(55) DEFAULT NULL,
  `item_tax` decimal(25,4) DEFAULT NULL,
  `net_unit_cost` decimal(25,4) DEFAULT NULL,
  `subtotal` decimal(25,4) DEFAULT NULL,
  `quantity_balance` decimal(15,4) NOT NULL,
  `unit_cost` decimal(25,4) DEFAULT NULL,
  `real_unit_cost` decimal(25,4) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `warehouse_id` int(11) DEFAULT NULL,
  `product_unit_id` int(11) DEFAULT NULL,
  `product_unit_code` varchar(10) DEFAULT NULL,
  `unit_quantity` decimal(15,4) NOT NULL,
  `gst` varchar(20) DEFAULT NULL,
  `cgst` decimal(25,4) DEFAULT NULL,
  `sgst` decimal(25,4) DEFAULT NULL,
  `igst` decimal(25,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_units`
--

CREATE TABLE `sma_units` (
  `id` int(11) NOT NULL,
  `code` varchar(10) NOT NULL,
  `name` varchar(55) NOT NULL,
  `base_unit` int(11) DEFAULT NULL,
  `operator` varchar(1) DEFAULT NULL,
  `unit_value` varchar(55) DEFAULT NULL,
  `operation_value` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_units`
--

INSERT INTO `sma_units` (`id`, `code`, `name`, `base_unit`, `operator`, `unit_value`, `operation_value`) VALUES
(1, 'Pcs', 'Pcs', NULL, NULL, NULL, NULL),
(2, 'ZAK', 'ZAK', 3, '*', NULL, '25'),
(3, 'KG', 'KG', 4, '*', NULL, '1000'),
(4, 'GRAM', 'GRAM', NULL, NULL, NULL, NULL),
(5, 'ZAK - GR', 'ZAK', 4, '*', NULL, '25000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_users`
--

CREATE TABLE `sma_users` (
  `id` int(11) UNSIGNED NOT NULL,
  `last_ip_address` varbinary(45) DEFAULT NULL,
  `ip_address` varbinary(45) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(55) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `group_id` int(10) UNSIGNED NOT NULL,
  `warehouse_id` int(10) UNSIGNED DEFAULT NULL,
  `biller_id` int(10) UNSIGNED DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `show_cost` tinyint(1) DEFAULT '0',
  `show_price` tinyint(1) DEFAULT '0',
  `award_points` int(11) DEFAULT '0',
  `view_right` tinyint(1) NOT NULL DEFAULT '0',
  `edit_right` tinyint(1) NOT NULL DEFAULT '0',
  `allow_discount` tinyint(1) DEFAULT '0',
  `address_1` varchar(50) NOT NULL DEFAULT '',
  `address_2` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) NOT NULL DEFAULT '',
  `ktpid` varchar(20) NOT NULL DEFAULT '',
  `npwpid` varchar(30) NOT NULL DEFAULT '',
  `department` varchar(30) NOT NULL DEFAULT '',
  `birthday_date` date DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_users`
--

INSERT INTO `sma_users` (`id`, `last_ip_address`, `ip_address`, `username`, `password`, `salt`, `email`, `activation_code`, `forgotten_password_code`, `forgotten_password_time`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`, `avatar`, `gender`, `group_id`, `warehouse_id`, `biller_id`, `company_id`, `show_cost`, `show_price`, `award_points`, `view_right`, `edit_right`, `allow_discount`, `address_1`, `address_2`, `city`, `ktpid`, `npwpid`, `department`, `birthday_date`, `join_date`, `end_date`) VALUES
(2, 0x3132372e302e302e31, 0x3131342e3132342e3231302e3531, 'ownertoko', '0275fad25408ebdac05e8ae56a0a4cc75c1fecef', NULL, 'goldlionstore@gmail.com', NULL, NULL, NULL, 'a13488d06ac5a85f82ae37f516efad8c99e091c5', 1699403060, 1702189685, 1, 'Admin', 'Toko Fauzi', 'Toko Fauzi', '08123456', NULL, 'male', 1, 0, 0, NULL, 0, 0, 0, 1, 0, 0, '', '', '', '', '', '', NULL, NULL, NULL),
(3, NULL, 0x3139322e3136382e312e3935, 'k-wtps-0001', '80e7cb4352c0e2792019973d12e980d00baabee3', NULL, '', NULL, NULL, NULL, NULL, 1699880473, 1699880473, 1, 'Ahmad', 'Fauzi', 'PT. WTPS', '08123123213', 'd9db2f0386d0f634d025ca7518f09e30.png', 'male', 2, 0, 0, NULL, 0, 0, 0, 1, 0, 0, 'Jl. kebantenan 5', 'Semper Timur, Cilincing', 'Jakarta Utara', '123123123123', '444444444444', 'Packing', '0000-00-00', '0000-00-00', NULL),
(4, 0x3139322e3136382e312e3939, 0x3139322e3136382e312e3939, 'k-wtps-0002', '0dd4f9339b630a34c33b321a79f1bebe4b220bc6', NULL, 'nugroho.hari@gmail.com', NULL, NULL, NULL, NULL, 1699881304, 1699884758, 1, 'Nugroho', 'Hari', 'PT. WTPS', '087654331123', NULL, 'male', 1, 0, 0, NULL, 0, 0, 0, 1, 0, 0, 'Jl. Melati 1', 'Bekasi Utara', 'Bekasi', '1234567788990987', '91.111.111.2-345.000', 'Consultant Mie', '2023-01-04', '2023-01-11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sma_user_logins`
--

CREATE TABLE `sma_user_logins` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_user_logins`
--

INSERT INTO `sma_user_logins` (`id`, `user_id`, `company_id`, `ip_address`, `login`, `time`) VALUES
(1, 1, NULL, 0x3131342e3132342e3231302e3531, 'owner@tecdiary.com', '2023-11-08 00:18:48'),
(2, 2, NULL, 0x3131342e3132342e3231302e3531, 'ownertoko', '2023-11-08 00:24:36'),
(3, 2, NULL, 0x3131342e3132342e3231302e3531, 'ownertoko', '2023-11-08 00:31:48'),
(4, 2, NULL, 0x3131342e3132342e3231302e3531, 'ownertoko', '2023-11-08 01:27:34'),
(5, 2, NULL, 0x3130332e38352e3134392e323236, 'ownertoko', '2023-11-08 01:50:35'),
(6, 2, NULL, 0x3132302e3138382e352e3634, 'ownertoko', '2023-11-08 02:31:43'),
(7, 2, NULL, 0x3132302e3138382e33372e3536, 'ownertoko', '2023-11-09 01:44:04'),
(8, 2, NULL, 0x3130332e38352e3134392e323236, 'ownertoko', '2023-11-09 02:04:47'),
(9, 2, NULL, 0x3138322e302e3138342e313032, 'ownertoko', '2023-11-09 17:42:36'),
(10, 2, NULL, 0x3131342e352e3233372e323232, 'ownertoko', '2023-11-10 02:15:08'),
(11, 2, NULL, 0x3138322e302e3138342e313032, 'ownertoko', '2023-11-10 02:36:25'),
(12, 2, NULL, 0x3131342e3132342e3234332e323431, 'ownertoko', '2023-11-11 02:00:31'),
(13, 2, NULL, 0x3138302e3235322e3131382e313435, 'ownertoko', '2023-11-11 06:38:47'),
(14, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-12 10:00:25'),
(15, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-12 11:58:13'),
(16, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-13 11:48:16'),
(17, 2, NULL, 0x3139322e3136382e312e3939, 'Ownertoko', '2023-11-13 12:02:50'),
(18, 2, NULL, 0x3139322e3136382e312e3939, 'Ownertoko', '2023-11-13 12:03:16'),
(19, 2, NULL, 0x3139322e3136382e312e3939, 'Ownertoko', '2023-11-13 12:03:50'),
(20, 2, NULL, 0x3139322e3136382e312e3935, 'ownertoko', '2023-11-13 12:06:15'),
(21, 4, NULL, 0x3139322e3136382e312e3939, 'K-WTPS-0002', '2023-11-13 13:16:53'),
(22, 2, NULL, 0x3139322e3136382e312e3935, 'ownertoko', '2023-11-13 14:07:12'),
(23, 2, NULL, 0x3139322e3136382e312e3939, 'Ownertoko', '2023-11-13 14:09:35'),
(24, 4, NULL, 0x3139322e3136382e312e3939, 'K-WTPS-0002', '2023-11-13 14:12:38'),
(25, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-14 00:53:46'),
(26, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-14 03:21:14'),
(27, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-14 04:28:35'),
(28, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-14 06:48:34'),
(29, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-14 12:06:46'),
(30, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-15 00:42:03'),
(31, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-16 12:40:01'),
(32, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-17 13:56:16'),
(33, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-18 01:02:16'),
(34, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-18 08:00:02'),
(35, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-18 14:05:52'),
(36, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-19 07:45:20'),
(37, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-19 09:19:17'),
(38, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-21 13:36:52'),
(39, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-24 09:59:31'),
(40, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-24 23:49:53'),
(41, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-26 05:21:06'),
(42, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-26 07:03:33'),
(43, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-26 07:09:15'),
(44, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-27 03:28:42'),
(45, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-27 06:48:28'),
(46, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-27 09:41:09'),
(47, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-28 04:07:55'),
(48, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-28 12:11:45'),
(49, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-11-29 11:34:29'),
(50, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-01 12:34:56'),
(51, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-01 15:09:00'),
(52, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-01 15:14:45'),
(53, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-02 01:20:44'),
(54, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-02 02:14:35'),
(55, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-06 12:00:18'),
(56, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-07 17:07:58'),
(57, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-08 13:10:54'),
(58, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-09 14:52:33'),
(59, 2, NULL, 0x3132372e302e302e31, 'ownertoko', '2023-12-10 06:28:05');

-- --------------------------------------------------------

--
-- Table structure for table `sma_variants`
--

CREATE TABLE `sma_variants` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses`
--

CREATE TABLE `sma_warehouses` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `map` varchar(255) DEFAULT NULL,
  `phone` varchar(55) DEFAULT NULL,
  `email` varchar(55) DEFAULT NULL,
  `price_group_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_warehouses`
--

INSERT INTO `sma_warehouses` (`id`, `code`, `name`, `address`, `map`, `phone`, `email`, `price_group_id`) VALUES
(1, 'WHI', 'Gudang 1', '<p>Jkt</p>', NULL, '012345678', 'whi@glni.com', 0),
(2, 'WHII', 'Gudang 2', '<p>YGY</p>', NULL, '0105292122', 'whii@glni.com', 0),
(3, 'R001', 'Gudang Raw Material', '', NULL, '', '', 1),
(4, 'R002', 'Gudang Retur', '<p>-</p>', NULL, '', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses_products`
--

CREATE TABLE `sma_warehouses_products` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `product_batch` varchar(20) NOT NULL DEFAULT '',
  `rack` varchar(55) DEFAULT NULL,
  `avg_cost` decimal(25,4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sma_warehouses_products`
--

INSERT INTO `sma_warehouses_products` (`id`, `product_id`, `warehouse_id`, `quantity`, `product_batch`, `rack`, `avg_cost`) VALUES
(31, 18, 1, '0.0000', '', NULL, '82000.0000'),
(32, 18, 2, '2.0000', '', NULL, '82000.0000'),
(33, 19, 1, '5.0000', '', NULL, '15000.0000'),
(34, 19, 2, '0.0000', '', NULL, '15000.0000'),
(35, 20, 1, '72.0000', '', NULL, '0.0000'),
(36, 20, 2, '0.0000', '', NULL, '0.0000'),
(37, 21, 1, '9689.9000', '', NULL, '1000000.0000'),
(38, 21, 2, '0.0000', '', NULL, '1000.0000'),
(39, 22, 1, '45.6000', '', NULL, '10000.0000'),
(40, 22, 2, '0.0000', '', NULL, '10000.0000'),
(41, 22, 3, '0.0000', '', NULL, '10000.0000'),
(42, 18, 3, '1.0000', '', NULL, '82000.0000'),
(43, 23, 1, '6.0000', '', NULL, '0.0000'),
(44, 23, 2, '6.0000', '', NULL, '0.0000'),
(45, 23, 3, '0.0000', '', NULL, '0.0000'),
(46, 23, 3, '0.0000', '20231125-8', NULL, '10000.0000'),
(47, 23, 1, '0.0000', '20231126-1', NULL, '10000.0000'),
(48, 24, 1, '5.0000', '', NULL, '0.0000'),
(49, 24, 2, '2.0000', '', NULL, '0.0000'),
(50, 24, 3, '0.0000', '', NULL, '0.0000'),
(51, 24, 1, '0.0000', '20231126-2', NULL, '15000.0000'),
(52, 25, 1, '0.0000', '', NULL, '0.0000'),
(53, 25, 2, '0.0000', '', NULL, '0.0000'),
(54, 25, 3, '0.0000', '', NULL, '0.0000'),
(55, 24, 1, '2.0000', '20231126-3', NULL, '15000.0000'),
(56, 23, 1, '0.0000', '20231129-1', NULL, '10000.0000'),
(57, 20, 1, '5.0000', '20231129-1', NULL, '97000.0000'),
(58, 19, 3, '0.0000', '', NULL, '15000.0000'),
(59, 20, 1, '4.0000', '20231201-1', NULL, '97000.0000'),
(60, 24, 1, '5.0000', '20231201-2', NULL, '15000.0000'),
(61, 23, 1, '6.0000', '20231201-3', NULL, '10000.0000'),
(62, 26, 1, '98.0000', '', NULL, '0.0000'),
(63, 26, 2, '2.0000', '', NULL, '0.0000'),
(64, 26, 3, '0.0000', '', NULL, '0.0000'),
(65, 26, 1, '88.0000', '20231202-1', NULL, '150000.0000'),
(66, 26, 2, '12.0000', '20231202-1', NULL, '150000.0000'),
(67, 26, 3, '0.0000', '20231202-1', NULL, '150000.0000'),
(68, 27, 1, '0.0000', '', NULL, '0.0000'),
(69, 27, 2, '0.0000', '', NULL, '0.0000'),
(70, 27, 3, '0.0000', '', NULL, '0.0000'),
(71, 27, 1, '88.0000', '20231202-2', NULL, '12000.0000'),
(72, 27, 2, '12.0000', '20231202-2', NULL, '12000.0000'),
(73, 27, 3, '0.0000', '20231202-2', NULL, '12000.0000'),
(74, 23, 2, '0.0000', '20231129-1', NULL, '10000.0000'),
(75, 23, 3, '0.0000', '20231129-1', NULL, '10000.0000'),
(76, 23, 4, '1.0000', '20231129-1', NULL, '10000.0000'),
(77, 23, 2, '0.0000', '20231126-1', NULL, '10000.0000'),
(78, 23, 3, '0.0000', '20231126-1', NULL, '10000.0000'),
(79, 23, 4, '2.0000', '20231126-1', NULL, '10000.0000'),
(80, 23, 1, '0.0000', '20231125-8', NULL, '10000.0000'),
(81, 23, 2, '0.0000', '20231125-8', NULL, '10000.0000'),
(82, 23, 4, '0.0000', '20231125-8', NULL, '10000.0000'),
(83, 28, 1, '0.0000', '', NULL, '0.0000'),
(84, 28, 2, '0.0000', '', NULL, '0.0000'),
(85, 28, 3, '0.0000', '', NULL, '0.0000'),
(86, 28, 4, '0.0000', '', NULL, '0.0000'),
(87, 28, 1, '30.0000', '20231208-1', NULL, '13000.0000'),
(88, 28, 2, '0.0000', '20231208-1', NULL, '13000.0000'),
(89, 28, 3, '0.0000', '20231208-1', NULL, '13000.0000'),
(90, 28, 4, '7.0000', '20231208-1', NULL, '13000.0000'),
(91, 29, 1, '0.0000', '', NULL, '0.0000'),
(92, 29, 2, '0.0000', '', NULL, '0.0000'),
(93, 29, 3, '0.0000', '', NULL, '0.0000'),
(94, 29, 4, '0.0000', '', NULL, '0.0000'),
(95, 29, 1, '90.0000', '20231210-1', NULL, '10000.0000'),
(96, 29, 2, '0.0000', '20231210-1', NULL, '10000.0000'),
(97, 29, 3, '0.0000', '20231210-1', NULL, '10000.0000'),
(98, 29, 4, '3.0000', '20231210-1', NULL, '10000.0000');

-- --------------------------------------------------------

--
-- Table structure for table `sma_warehouses_products_variants`
--

CREATE TABLE `sma_warehouses_products_variants` (
  `id` int(11) NOT NULL,
  `option_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(15,4) NOT NULL,
  `rack` varchar(55) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sma_addresses`
--
ALTER TABLE `sma_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sma_adjustment_items`
--
ALTER TABLE `sma_adjustment_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adjustment_id` (`adjustment_id`);

--
-- Indexes for table `sma_brands`
--
ALTER TABLE `sma_brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `sma_calendar`
--
ALTER TABLE `sma_calendar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_captcha`
--
ALTER TABLE `sma_captcha`
  ADD PRIMARY KEY (`captcha_id`),
  ADD KEY `word` (`word`);

--
-- Indexes for table `sma_categories`
--
ALTER TABLE `sma_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_companies`
--
ALTER TABLE `sma_companies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`),
  ADD KEY `group_id_2` (`group_id`);

--
-- Indexes for table `sma_costing`
--
ALTER TABLE `sma_costing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_currencies`
--
ALTER TABLE `sma_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_damage`
--
ALTER TABLE `sma_damage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_damage_items`
--
ALTER TABLE `sma_damage_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_date_format`
--
ALTER TABLE `sma_date_format`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_delivery_item`
--
ALTER TABLE `sma_delivery_item`
  ADD PRIMARY KEY (`delivery_id`,`seq`);

--
-- Indexes for table `sma_deposits`
--
ALTER TABLE `sma_deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_expenses`
--
ALTER TABLE `sma_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_expense_categories`
--
ALTER TABLE `sma_expense_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `card_no` (`card_no`);

--
-- Indexes for table `sma_gift_card_topups`
--
ALTER TABLE `sma_gift_card_topups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `card_id` (`card_id`);

--
-- Indexes for table `sma_groups`
--
ALTER TABLE `sma_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_logs`
--
ALTER TABLE `sma_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_notifications`
--
ALTER TABLE `sma_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  ADD PRIMARY KEY (`ref_id`);

--
-- Indexes for table `sma_payments`
--
ALTER TABLE `sma_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_paypal`
--
ALTER TABLE `sma_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_permissions`
--
ALTER TABLE `sma_permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_pos_settings`
--
ALTER TABLE `sma_pos_settings`
  ADD PRIMARY KEY (`pos_id`);

--
-- Indexes for table `sma_price_groups`
--
ALTER TABLE `sma_price_groups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `sma_printers`
--
ALTER TABLE `sma_printers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_production`
--
ALTER TABLE `sma_production`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_production_items`
--
ALTER TABLE `sma_production_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_products`
--
ALTER TABLE `sma_products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`),
  ADD KEY `category_id_2` (`category_id`),
  ADD KEY `unit` (`unit`),
  ADD KEY `brand` (`brand`);

--
-- Indexes for table `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_product_prices`
--
ALTER TABLE `sma_product_prices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `price_group_id` (`price_group_id`);

--
-- Indexes for table `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_product_id_name` (`product_id`,`name`);

--
-- Indexes for table `sma_promos`
--
ALTER TABLE `sma_promos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_purchases`
--
ALTER TABLE `sma_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_id` (`purchase_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_quotes`
--
ALTER TABLE `sma_quotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quote_id` (`quote_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_returns`
--
ALTER TABLE `sma_returns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_return_items`
--
ALTER TABLE `sma_return_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `return_id` (`return_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`return_id`),
  ADD KEY `return_id_2` (`return_id`,`product_id`);

--
-- Indexes for table `sma_sales`
--
ALTER TABLE `sma_sales`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale_id` (`sale_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_id_2` (`product_id`,`sale_id`),
  ADD KEY `sale_id_2` (`sale_id`,`product_id`);

--
-- Indexes for table `sma_sessions`
--
ALTER TABLE `sma_sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `sma_settings`
--
ALTER TABLE `sma_settings`
  ADD PRIMARY KEY (`setting_id`);

--
-- Indexes for table `sma_skrill`
--
ALTER TABLE `sma_skrill`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_stock_counts`
--
ALTER TABLE `sma_stock_counts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sma_stock_count_items`
--
ALTER TABLE `sma_stock_count_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stock_count_id` (`stock_count_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_storage`
--
ALTER TABLE `sma_storage`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_transfers`
--
ALTER TABLE `sma_transfers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transfer_id` (`transfer_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `sma_units`
--
ALTER TABLE `sma_units`
  ADD PRIMARY KEY (`id`),
  ADD KEY `base_unit` (`base_unit`);

--
-- Indexes for table `sma_users`
--
ALTER TABLE `sma_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `group_id` (`group_id`,`warehouse_id`,`biller_id`),
  ADD KEY `group_id_2` (`group_id`,`company_id`);

--
-- Indexes for table `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_variants`
--
ALTER TABLE `sma_variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- Indexes for table `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `option_id` (`option_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `warehouse_id` (`warehouse_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sma_addresses`
--
ALTER TABLE `sma_addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_adjustments`
--
ALTER TABLE `sma_adjustments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_adjustment_items`
--
ALTER TABLE `sma_adjustment_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sma_brands`
--
ALTER TABLE `sma_brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sma_calendar`
--
ALTER TABLE `sma_calendar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_captcha`
--
ALTER TABLE `sma_captcha`
  MODIFY `captcha_id` bigint(13) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_categories`
--
ALTER TABLE `sma_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_combo_items`
--
ALTER TABLE `sma_combo_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `sma_companies`
--
ALTER TABLE `sma_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_costing`
--
ALTER TABLE `sma_costing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `sma_currencies`
--
ALTER TABLE `sma_currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sma_customer_groups`
--
ALTER TABLE `sma_customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_damage`
--
ALTER TABLE `sma_damage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_damage_items`
--
ALTER TABLE `sma_damage_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sma_date_format`
--
ALTER TABLE `sma_date_format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sma_deliveries`
--
ALTER TABLE `sma_deliveries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sma_deposits`
--
ALTER TABLE `sma_deposits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_expenses`
--
ALTER TABLE `sma_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_expense_categories`
--
ALTER TABLE `sma_expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_gift_cards`
--
ALTER TABLE `sma_gift_cards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_gift_card_topups`
--
ALTER TABLE `sma_gift_card_topups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_groups`
--
ALTER TABLE `sma_groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sma_login_attempts`
--
ALTER TABLE `sma_login_attempts`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_logs`
--
ALTER TABLE `sma_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `sma_notifications`
--
ALTER TABLE `sma_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_order_ref`
--
ALTER TABLE `sma_order_ref`
  MODIFY `ref_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sma_payments`
--
ALTER TABLE `sma_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sma_permissions`
--
ALTER TABLE `sma_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sma_pos_register`
--
ALTER TABLE `sma_pos_register`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sma_price_groups`
--
ALTER TABLE `sma_price_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `sma_printers`
--
ALTER TABLE `sma_printers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_production`
--
ALTER TABLE `sma_production`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `sma_production_items`
--
ALTER TABLE `sma_production_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `sma_products`
--
ALTER TABLE `sma_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `sma_product_photos`
--
ALTER TABLE `sma_product_photos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_product_prices`
--
ALTER TABLE `sma_product_prices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_product_variants`
--
ALTER TABLE `sma_product_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_promos`
--
ALTER TABLE `sma_promos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_purchases`
--
ALTER TABLE `sma_purchases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `sma_purchase_items`
--
ALTER TABLE `sma_purchase_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `sma_quotes`
--
ALTER TABLE `sma_quotes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_quote_items`
--
ALTER TABLE `sma_quote_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_returns`
--
ALTER TABLE `sma_returns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `sma_return_items`
--
ALTER TABLE `sma_return_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sma_sales`
--
ALTER TABLE `sma_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `sma_sale_items`
--
ALTER TABLE `sma_sale_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `sma_stock_counts`
--
ALTER TABLE `sma_stock_counts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sma_stock_count_items`
--
ALTER TABLE `sma_stock_count_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_storage`
--
ALTER TABLE `sma_storage`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_suspended_bills`
--
ALTER TABLE `sma_suspended_bills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_suspended_items`
--
ALTER TABLE `sma_suspended_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_tax_rates`
--
ALTER TABLE `sma_tax_rates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_transfers`
--
ALTER TABLE `sma_transfers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `sma_transfer_items`
--
ALTER TABLE `sma_transfer_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_units`
--
ALTER TABLE `sma_units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sma_users`
--
ALTER TABLE `sma_users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_user_logins`
--
ALTER TABLE `sma_user_logins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `sma_variants`
--
ALTER TABLE `sma_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sma_warehouses`
--
ALTER TABLE `sma_warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sma_warehouses_products`
--
ALTER TABLE `sma_warehouses_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT for table `sma_warehouses_products_variants`
--
ALTER TABLE `sma_warehouses_products_variants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
