-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 09, 2022 at 02:58 AM
-- Server version: 10.3.32-MariaDB-log-cll-lve
-- PHP Version: 7.3.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rasanchy_flutter1`
--

-- --------------------------------------------------------

--
-- Table structure for table `calories`
--

CREATE TABLE `calories` (
  `email` varchar(70) NOT NULL,
  `date` varchar(70) NOT NULL,
  `calories` varchar(70) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `calories`
--

INSERT INTO `calories` (`email`, `date`, `calories`, `id`) VALUES
('admin', '1/19/2022', '25', 1),
('admin', '2022-01-20 17:29:39.410241', '456', 8),
('user', '2022-01-20 14:13:19.994351', '56', 5),
('user', '2022-01-20 14:51:05.109847', '50', 6),
('user', '2022-01-20 15:10:47.017375', '89', 7);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--

CREATE TABLE `ingredient` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `calories` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`id`, `name`, `calories`) VALUES
(10, 'Chicken', '35'),
(18, 'Yougurt', '58'),
(17, 'Tomato', '58'),
(16, 'Meat', '58'),
(26, 'cauliflower', '11'),
(14, 'Onion', '15'),
(27, 'garlic', '12'),
(22, 'salt', '66'),
(29, 'water', ''),
(28, 'olive oil', '121'),
(30, 'jelly sachet', '33'),
(31, 'cream', '33'),
(32, '', ''),
(33, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `recipie`
--

CREATE TABLE `recipie` (
  `id` int(11) NOT NULL,
  `name` varchar(70) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `imageurl` varchar(1000) NOT NULL,
  `imageurls` varchar(1000) NOT NULL,
  `totaltime` varchar(50) NOT NULL,
  `totalcalories` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipie`
--

INSERT INTO `recipie` (`id`, `name`, `description`, `imageurl`, `imageurls`, `totaltime`, `totalcalories`) VALUES
(1, 'Chicken Tikka Biryani', 'Line a baking tray with parchment paper, grease it,\r\nPlace your chicken pieces, spray on top of the chicken\r\nAnd bake, ending with the gas griller for the char.', 'https://lh3.googleusercontent.com/JrMaWYKr7R1Mly8_YO_mKsi6v_4gtwey1f2KpNoGJmKej6el1juXaOLvDd4yPUG4acax0HJAe4jdkDAZ1zboKHwtbhhYH_fvdDc=s360', 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', '120 Min', '150'),
(6, 'ItalianMeatballs', 'Tender meatballs just like your Italian grandma would make, in a fraction of the time. A simple mix of ground beef, seasonings, and Parmesan cheese form these meatballs that get baked in the oven before taking a quick simmer in your favorite marinara sauce.', 'https://lh3.googleusercontent.com/z7jNUZH4FkOZNwgB1yloPvacmlhmI5-h1ftZkisNcptFDOGDI9Azm36uZOSgOQr9HGvKedvqHZ7Na7CSX4sLYQ5a9ecY3c0ubOk', 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', '60 Min', '150'),
(9, 'Roasted Cauliflower', 'Perfectly roasted cauliflower with garlicky flavor in every bite', 'https://lh3.googleusercontent.com/tnWFcP5OaStB1ayXnhX6t--2LJa04me3G_mWMwj9RpdVhZGTrF4K2jdwaUvggR6xQgaCHPKDOMi2MtHME1Q7dXLWGFWr7CMlUA', 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', '20 mins', '100'),
(10, 'Apple flavoured Jelly', 'A tasty desert to enjoy in the evening. you will need hot water, Apple flavoured jelly sachet. First boil the water for 10nmins, add jelly sachet and freeze it for half an hour', 'https://lh3.googleusercontent.com/ymiQX3CM5saFP8hDkL3K6iZnKZ7HLHa7cFwtnK450z8gOSkP9EM4rXFcOjTXMAILHA5jZ52-BDlM4I-G--JNlA=s320-c-rw-v1-e365', 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4', '20 min', '55');

-- --------------------------------------------------------

--
-- Table structure for table `recipieing`
--

CREATE TABLE `recipieing` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `ingredient` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `recipieing`
--

INSERT INTO `recipieing` (`id`, `name`, `ingredient`) VALUES
(6, 'Chicken Biryani', 'Chicken1'),
(8, 'Chicken Biryani', 'Tomato'),
(7, 'Chicken Biryani', 'Yougurt'),
(9, 'Chicken Biryani', 'Meat'),
(10, 'Chicken Tikka Biryani', 'Onion'),
(11, 'Chicken Tikka Biryani', 'Meat'),
(12, 'Chicken Tikka Biryani', 'Yougurt'),
(13, 'Chicken Tikka Biryani', 'Chicken'),
(22, 'Roasted Cauliflower', 'garlic'),
(23, 'Roasted Cauliflower', 'olive oil'),
(21, 'Roasted Cauliflower', 'cauliflower'),
(24, 'Apple flavoured Jelly', 'jelly sachet'),
(25, 'Apple flavoured Jelly', 'water'),
(26, 'Apple flavoured Jelly', 'cream');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `role` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `pass`, `role`) VALUES
(79, 'Qasim', 'hello123', 'q.asif123@gmail.com', 0),
(71, 'hamza', 'hamza', 'hamza', 0),
(78, '', '', '', 0),
(68, 'jameel', 'jameel', 'jameel', 0),
(60, 'Admin', 'admin', 'admin', 1),
(61, 'User', 'user', 'user1', 0),
(67, 'bajwa', 'bajwa', 'bajwa', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `calories`
--
ALTER TABLE `calories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipie`
--
ALTER TABLE `recipie`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipieing`
--
ALTER TABLE `recipieing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `calories`
--
ALTER TABLE `calories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `recipie`
--
ALTER TABLE `recipie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `recipieing`
--
ALTER TABLE `recipieing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
