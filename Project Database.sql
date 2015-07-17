-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.6.24-log


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema stpdb
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ stpdb;
USE stpdb;

--
-- Table structure for table `stpdb`.`group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `g_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(45) NOT NULL DEFAULT '',
  `members` varchar(1000) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`group`
--

/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` (`g_id`,`group_name`,`members`,`last_update`) VALUES 
 (1,'production_team','kalpit,codePanda','2015-07-13 22:31:18');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;


--
-- Table structure for table `stpdb`.`hashtag`
--

DROP TABLE IF EXISTS `hashtag`;
CREATE TABLE `hashtag` (
  `h_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(45) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `members` varchar(1000) NOT NULL DEFAULT '',
  `creator` int(10) unsigned NOT NULL DEFAULT '0',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`h_id`),
  KEY `creator_id` (`creator`),
  CONSTRAINT `creator_id` FOREIGN KEY (`creator`) REFERENCES `member` (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`hashtag`
--

/*!40000 ALTER TABLE `hashtag` DISABLE KEYS */;
INSERT INTO `hashtag` (`h_id`,`tag`,`description`,`members`,`creator`,`last_update`) VALUES 
 (2,'web_dev','Website developement','kalpit,codePanda',1,'2015-07-14 12:29:01'),
 (3,'product_research','Product Research Phase','kalpit',1,'2015-07-15 05:01:20'),
 (4,'inventory_mgmt','Inventory Management Module','kalpit,codePanda',2,'2015-07-15 08:08:46');
/*!40000 ALTER TABLE `hashtag` ENABLE KEYS */;


--
-- Table structure for table `stpdb`.`member`
--

DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `m_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL DEFAULT '',
  `pass` varchar(45) NOT NULL DEFAULT '',
  `username` varchar(45) NOT NULL DEFAULT '',
  `dob` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `privilige` varchar(2) NOT NULL DEFAULT '',
  `t_id` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`m_id`),
  KEY `t_id` (`t_id`),
  CONSTRAINT `t_id` FOREIGN KEY (`t_id`) REFERENCES `team` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`member`
--

/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` (`m_id`,`email`,`pass`,`username`,`dob`,`privilige`,`t_id`) VALUES 
 (1,'akapatea@gmail.com','1234','codePanda','1993-09-25 00:00:00','A',1),
 (2,'kalpitsharma2509@gmail.com','1234','kalpit','1993-09-25 00:00:00','U',1),
 (3,'csc@gmail.com','1234','csc','2015-01-15 00:07:00','A',4);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;


--
-- Table structure for table `stpdb`.`messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `message_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `body` text NOT NULL,
  `sender_id` int(10) unsigned NOT NULL DEFAULT '0',
  `receiver_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  KEY `receiver` (`receiver_id`),
  KEY `sender` (`sender_id`),
  CONSTRAINT `receiver` FOREIGN KEY (`receiver_id`) REFERENCES `member` (`m_id`),
  CONSTRAINT `sender` FOREIGN KEY (`sender_id`) REFERENCES `member` (`m_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`message_id`,`body`,`sender_id`,`receiver_id`,`last_update`) VALUES 
 (1,'Subject : Official\nI am kalpit!',1,2,'2015-07-13 13:51:01'),
 (43,'Subject : jfgcgf\ngvgvh',1,2,'2015-07-13 19:41:21'),
 (44,'Subject : tfgcf\nfyfftg',1,1,'2015-07-13 22:28:59'),
 (45,'Subject : Office\nHey! How are you?',1,1,'2015-07-14 16:30:15'),
 (46,'Subject : URGENT\nWhat about product research?',2,2,'2015-07-15 05:04:12'),
 (47,'Subject : gs\ndgfdgf',1,2,'2015-07-15 12:37:34');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Table structure for table `stpdb`.`posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `p_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `post_description` text NOT NULL,
  `creator` int(10) unsigned NOT NULL DEFAULT '0',
  `h_id` int(10) unsigned DEFAULT NULL,
  `g_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(1) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`p_id`),
  KEY `creator` (`creator`),
  KEY `h_id` (`h_id`),
  KEY `g_id` (`g_id`),
  CONSTRAINT `creator` FOREIGN KEY (`creator`) REFERENCES `member` (`m_id`),
  CONSTRAINT `g_id` FOREIGN KEY (`g_id`) REFERENCES `group` (`g_id`),
  CONSTRAINT `h_id` FOREIGN KEY (`h_id`) REFERENCES `hashtag` (`h_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`posts`
--

/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`p_id`,`post_description`,`creator`,`h_id`,`g_id`,`type`,`last_update`) VALUES 
 (1,'UI/UX design phase!',1,NULL,1,'G','2015-07-15 04:59:52'),
 (2,'Documentation started !',1,2,NULL,'H','2015-07-15 05:00:41'),
 (3,'Product Design conceived ! :)',1,3,NULL,'H','2015-07-15 05:01:45'),
 (4,'SRS completed !',1,2,NULL,'H','2015-07-15 05:02:20'),
 (5,'Design phase',1,2,NULL,'H','2015-07-15 08:04:38'),
 (6,'What is the progress of new UI design module? ',1,NULL,1,'G','2015-07-15 08:05:07'),
 (7,'What is the status of new stock?',2,4,NULL,'H','2015-07-15 08:10:00');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;


--
-- Table structure for table `stpdb`.`team`
--

DROP TABLE IF EXISTS `team`;
CREATE TABLE `team` (
  `t_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `team_name` varchar(45) NOT NULL DEFAULT '',
  `team_description` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stpdb`.`team`
--

/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` (`t_id`,`team_name`,`team_description`,`last_update`) VALUES 
 (1,'Reading Club','Reading, Writing','2015-07-15 09:31:41'),
 (2,'CSC','csc','2015-07-15 12:20:30'),
 (4,'CSC','csc','2015-07-15 12:21:33');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
