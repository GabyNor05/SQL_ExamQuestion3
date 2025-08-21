-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 21, 2025 at 01:40 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `global publishing house system`
--

-- --------------------------------------------------------

--
-- Table structure for table `authors`
--

CREATE TABLE `authors` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `country_origin` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `edition_id` int(11) NOT NULL,
  `title` varchar(500) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `original_language` varchar(50) NOT NULL,
  `publication_year` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contracts`
--

CREATE TABLE `contracts` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `royalty_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `royalty_percentage` decimal(5,2) NOT NULL,
  `contract_status` enum('Active','Expired','Terminated') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `editions`
--

CREATE TABLE `editions` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `edition_number` int(11) NOT NULL,
  `language` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `editors`
--

CREATE TABLE `editors` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manuscripts`
--

CREATE TABLE `manuscripts` (
  `id` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `submission_date` date DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `approved` binary(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviewers`
--

CREATE TABLE `reviewers` (
  `id` int(11) NOT NULL,
  `editor_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `royalties`
--

CREATE TABLE `royalties` (
  `id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `sale_id` int(11) NOT NULL,
  `amount_per_book` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `edition_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `date_of_sale` date NOT NULL,
  `country` varchar(100) NOT NULL,
  `vendor` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translators`
--

CREATE TABLE `translators` (
  `id` int(11) NOT NULL,
  `edition_id` int(11) NOT NULL,
  `firstname` varchar(100) NOT NULL,
  `lastname` varchar(100) NOT NULL,
  `languages` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`book_id`),
  ADD KEY `FK2` (`contract_id`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD KEY `Foreign Key 2` (`edition_id`),
  ADD KEY `Foreign Key 3` (`editor_id`),
  ADD KEY `Foreign Key 1` (`author_id`);

--
-- Indexes for table `contracts`
--
ALTER TABLE `contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`book_id`),
  ADD KEY `FK2` (`royalty_id`);

--
-- Indexes for table `editions`
--
ALTER TABLE `editions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`book_id`);

--
-- Indexes for table `editors`
--
ALTER TABLE `editors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`book_id`),
  ADD KEY `FK2` (`editor_id`);

--
-- Indexes for table `manuscripts`
--
ALTER TABLE `manuscripts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`author_id`),
  ADD KEY `FK2` (`book_id`),
  ADD KEY `FK3` (`editor_id`);

--
-- Indexes for table `reviewers`
--
ALTER TABLE `reviewers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`editor_id`) USING BTREE,
  ADD KEY `FK2` (`book_id`) USING BTREE;

--
-- Indexes for table `royalties`
--
ALTER TABLE `royalties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `FK2` (`sale_id`),
  ADD KEY `FK1` (`contract_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `FK2` (`book_id`),
  ADD KEY `FK1` (`edition_id`);

--
-- Indexes for table `translators`
--
ALTER TABLE `translators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK1` (`edition_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contracts`
--
ALTER TABLE `contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `editions`
--
ALTER TABLE `editions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `editors`
--
ALTER TABLE `editors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manuscripts`
--
ALTER TABLE `manuscripts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviewers`
--
ALTER TABLE `reviewers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `royalties`
--
ALTER TABLE `royalties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translators`
--
ALTER TABLE `translators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `authors`
--
ALTER TABLE `authors`
  ADD CONSTRAINT `FK1` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK2` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `Foreign Key` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Foreign Key 2` FOREIGN KEY (`edition_id`) REFERENCES `editions` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `Foreign Key 3` FOREIGN KEY (`editor_id`) REFERENCES `editors` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `manuscripts`
--
ALTER TABLE `manuscripts`
  ADD CONSTRAINT `manuscripts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
