-- MySQL dump 10.13  Distrib 5.1.67, for redhat-linux-gnu (x86_64)
--
-- Host: 127.8.172.129    Database: statusnet
-- ------------------------------------------------------
-- Server version	5.1.67

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
-- Table structure for table `avatar`
--

DROP TABLE IF EXISTS `avatar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avatar` (
  `profile_id` int(11) NOT NULL COMMENT 'foreign key to profile table',
  `original` tinyint(4) DEFAULT '0' COMMENT 'uploaded by user or generated?',
  `width` int(11) NOT NULL COMMENT 'image width',
  `height` int(11) NOT NULL COMMENT 'image height',
  `mediatype` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'file type',
  `filename` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'local filename, if local',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'avatar location',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`profile_id`,`width`,`height`),
  UNIQUE KEY `avatar_url_key` (`url`),
  KEY `avatar_profile_id_idx` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avatar`
--

LOCK TABLES `avatar` WRITE;
/*!40000 ALTER TABLE `avatar` DISABLE KEYS */;
/*!40000 ALTER TABLE `avatar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookmark`
--

DROP TABLE IF EXISTS `bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bookmark` (
  `id` char(36) COLLATE utf8_bin NOT NULL,
  `profile_id` int(11) NOT NULL,
  `url` varchar(255) COLLATE utf8_bin NOT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `uri` varchar(255) COLLATE utf8_bin NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookmark_uri_idx` (`uri`),
  KEY `bookmark_profile_id_idx` (`profile_id`),
  KEY `bookmark_url_idx` (`url`),
  KEY `bookmark_created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookmark`
--

LOCK TABLES `bookmark` WRITE;
/*!40000 ALTER TABLE `bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `section` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'configuration section',
  `setting` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'configuration setting',
  `value` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'configuration value',
  PRIMARY KEY (`section`,`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `confirm_address`
--

DROP TABLE IF EXISTS `confirm_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confirm_address` (
  `code` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'good random code',
  `user_id` int(11) NOT NULL COMMENT 'user who requested confirmation',
  `address` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'address (email, xmpp, SMS, etc.)',
  `address_extra` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'carrier ID, for SMS',
  `address_type` varchar(8) COLLATE utf8_bin NOT NULL COMMENT 'address type ("email", "xmpp", "sms")',
  `claimed` datetime DEFAULT NULL COMMENT 'date this was claimed for queueing',
  `sent` datetime DEFAULT NULL COMMENT 'date this was sent for queueing',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confirm_address`
--

LOCK TABLES `confirm_address` WRITE;
/*!40000 ALTER TABLE `confirm_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `confirm_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumer`
--

DROP TABLE IF EXISTS `consumer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumer` (
  `consumer_key` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'unique identifier, root URL',
  `consumer_secret` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'secret value',
  `seed` char(32) COLLATE utf8_bin NOT NULL COMMENT 'seed for new tokens by this consumer',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`consumer_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumer`
--

LOCK TABLES `consumer` WRITE;
/*!40000 ALTER TABLE `consumer` DISABLE KEYS */;
/*!40000 ALTER TABLE `consumer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conversation`
--

DROP TABLE IF EXISTS `conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `uri` varchar(225) COLLATE utf8_bin DEFAULT NULL COMMENT 'URI of the conversation',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `conversation_uri_key` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conversation`
--

LOCK TABLES `conversation` WRITE;
/*!40000 ALTER TABLE `conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deleted_notice`
--

DROP TABLE IF EXISTS `deleted_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deleted_notice` (
  `id` int(11) NOT NULL COMMENT 'identity of notice',
  `profile_id` int(11) NOT NULL COMMENT 'author of the notice',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier, usually a tag URI',
  `created` datetime NOT NULL COMMENT 'date the notice record was created',
  `deleted` datetime NOT NULL COMMENT 'date the notice record was created',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deleted_notice_uri_key` (`uri`),
  KEY `deleted_notice_profile_id_idx` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deleted_notice`
--

LOCK TABLES `deleted_notice` WRITE;
/*!40000 ALTER TABLE `deleted_notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `deleted_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fave`
--

DROP TABLE IF EXISTS `fave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fave` (
  `notice_id` int(11) NOT NULL COMMENT 'notice that is the favorite',
  `user_id` int(11) NOT NULL COMMENT 'user who likes this notice',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier, usually a tag URI',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`notice_id`,`user_id`),
  UNIQUE KEY `fave_uri_key` (`uri`),
  KEY `fave_notice_id_idx` (`notice_id`),
  KEY `fave_user_id_idx` (`user_id`,`modified`),
  KEY `fave_modified_idx` (`modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fave`
--

LOCK TABLES `fave` WRITE;
/*!40000 ALTER TABLE `fave` DISABLE KEYS */;
/*!40000 ALTER TABLE `fave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'destination URL after following redirections',
  `mimetype` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'mime type of resource',
  `size` int(11) DEFAULT NULL COMMENT 'size of resource when available',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'title of resource when available',
  `date` int(11) DEFAULT NULL COMMENT 'date of resource according to http query',
  `protected` int(11) DEFAULT NULL COMMENT 'true when URL is private (needs login)',
  `filename` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'if a local file, name of the file',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `file_url_key` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_oembed`
--

DROP TABLE IF EXISTS `file_oembed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_oembed` (
  `file_id` int(11) NOT NULL COMMENT 'oEmbed for that URL/file',
  `version` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'oEmbed spec. version',
  `type` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT 'oEmbed type: photo, video, link, rich',
  `mimetype` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'mime type of resource',
  `provider` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'name of this oEmbed provider',
  `provider_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL of this oEmbed provider',
  `width` int(11) DEFAULT NULL COMMENT 'width of oEmbed resource when available',
  `height` int(11) DEFAULT NULL COMMENT 'height of oEmbed resource when available',
  `html` text COLLATE utf8_bin COMMENT 'html representation of this oEmbed resource when applicable',
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'title of oEmbed resource when available',
  `author_name` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'author name for this oEmbed resource',
  `author_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'author URL for this oEmbed resource',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL for this oEmbed resource when applicable (photo, link)',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_oembed`
--

LOCK TABLES `file_oembed` WRITE;
/*!40000 ALTER TABLE `file_oembed` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_oembed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_redirection`
--

DROP TABLE IF EXISTS `file_redirection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_redirection` (
  `url` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'short URL (or any other kind of redirect) for file (id)',
  `file_id` int(11) DEFAULT NULL COMMENT 'short URL for what URL/file',
  `redirections` int(11) DEFAULT NULL COMMENT 'redirect count',
  `httpcode` int(11) DEFAULT NULL COMMENT 'HTTP status code (20x, 30x, etc.)',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_redirection`
--

LOCK TABLES `file_redirection` WRITE;
/*!40000 ALTER TABLE `file_redirection` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_redirection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_thumbnail`
--

DROP TABLE IF EXISTS `file_thumbnail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_thumbnail` (
  `file_id` int(11) NOT NULL COMMENT 'thumbnail for what URL/file',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL of thumbnail',
  `width` int(11) DEFAULT NULL COMMENT 'width of thumbnail',
  `height` int(11) DEFAULT NULL COMMENT 'height of thumbnail',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_thumbnail`
--

LOCK TABLES `file_thumbnail` WRITE;
/*!40000 ALTER TABLE `file_thumbnail` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_thumbnail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file_to_post`
--

DROP TABLE IF EXISTS `file_to_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file_to_post` (
  `file_id` int(11) NOT NULL COMMENT 'id of URL/file',
  `post_id` int(11) NOT NULL COMMENT 'id of the notice it belongs to',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`file_id`,`post_id`),
  KEY `post_id_idx` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file_to_post`
--

LOCK TABLES `file_to_post` WRITE;
/*!40000 ALTER TABLE `file_to_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `file_to_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foreign_link`
--

DROP TABLE IF EXISTS `foreign_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreign_link` (
  `user_id` int(11) NOT NULL COMMENT 'link to user on this system, if exists',
  `foreign_id` bigint(20) NOT NULL COMMENT 'link to user on foreign service, if exists',
  `service` int(11) NOT NULL COMMENT 'foreign key to service',
  `credentials` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'authc credentials, typically a password',
  `noticesync` tinyint(4) DEFAULT '1' COMMENT 'notice synchronization, bit 1 = sync outgoing, bit 2 = sync incoming, bit 3 = filter local replies',
  `friendsync` tinyint(4) DEFAULT '2' COMMENT 'friend synchronization, bit 1 = sync outgoing, bit 2 = sync incoming',
  `profilesync` tinyint(4) DEFAULT '1' COMMENT 'profile synchronization, bit 1 = sync outgoing, bit 2 = sync incoming',
  `last_noticesync` datetime DEFAULT NULL COMMENT 'last time notices were imported',
  `last_friendsync` datetime DEFAULT NULL COMMENT 'last time friends were imported',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`,`foreign_id`,`service`),
  KEY `foreign_user_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foreign_link`
--

LOCK TABLES `foreign_link` WRITE;
/*!40000 ALTER TABLE `foreign_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `foreign_link` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foreign_service`
--

DROP TABLE IF EXISTS `foreign_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreign_service` (
  `id` int(11) NOT NULL COMMENT 'numeric key for service',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'name of the service',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'description',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `foreign_service_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foreign_service`
--

LOCK TABLES `foreign_service` WRITE;
/*!40000 ALTER TABLE `foreign_service` DISABLE KEYS */;
INSERT INTO `foreign_service` VALUES (1,'Twitter','Twitter Micro-blogging service','2013-03-29 17:30:54','2013-03-29 21:30:54'),(2,'Facebook','Facebook','2013-03-29 17:30:54','2013-03-29 21:30:54'),(3,'FacebookConnect','Facebook Connect','2013-03-29 17:30:54','2013-03-29 21:30:54');
/*!40000 ALTER TABLE `foreign_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foreign_subscription`
--

DROP TABLE IF EXISTS `foreign_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreign_subscription` (
  `service` int(11) NOT NULL COMMENT 'service where relationship happens',
  `subscriber` bigint(20) NOT NULL COMMENT 'subscriber on foreign service',
  `subscribed` bigint(20) NOT NULL COMMENT 'subscribed user',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`service`,`subscriber`,`subscribed`),
  KEY `foreign_subscription_subscriber_idx` (`service`,`subscriber`),
  KEY `foreign_subscription_subscribed_idx` (`service`,`subscribed`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foreign_subscription`
--

LOCK TABLES `foreign_subscription` WRITE;
/*!40000 ALTER TABLE `foreign_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `foreign_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `foreign_user`
--

DROP TABLE IF EXISTS `foreign_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `foreign_user` (
  `id` bigint(20) NOT NULL COMMENT 'unique numeric key on foreign service',
  `service` int(11) NOT NULL COMMENT 'foreign key to service',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'identifying URI',
  `nickname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'nickname on foreign service',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`,`service`),
  UNIQUE KEY `foreign_user_uri_key` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foreign_user`
--

LOCK TABLES `foreign_user` WRITE;
/*!40000 ALTER TABLE `foreign_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `foreign_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_alias`
--

DROP TABLE IF EXISTS `group_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_alias` (
  `alias` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'additional nickname for the group',
  `group_id` int(11) NOT NULL COMMENT 'group profile is blocked from',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date alias was created',
  PRIMARY KEY (`alias`),
  KEY `group_alias_group_id_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_alias`
--

LOCK TABLES `group_alias` WRITE;
/*!40000 ALTER TABLE `group_alias` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_alias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_block`
--

DROP TABLE IF EXISTS `group_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_block` (
  `group_id` int(11) NOT NULL COMMENT 'group profile is blocked from',
  `blocked` int(11) NOT NULL COMMENT 'profile that is blocked',
  `blocker` int(11) NOT NULL COMMENT 'user making the block',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date of blocking',
  PRIMARY KEY (`group_id`,`blocked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_block`
--

LOCK TABLES `group_block` WRITE;
/*!40000 ALTER TABLE `group_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_inbox`
--

DROP TABLE IF EXISTS `group_inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_inbox` (
  `group_id` int(11) NOT NULL COMMENT 'group receiving the message',
  `notice_id` int(11) NOT NULL COMMENT 'notice received',
  `created` datetime NOT NULL COMMENT 'date the notice was created',
  PRIMARY KEY (`group_id`,`notice_id`),
  KEY `group_inbox_created_idx` (`created`),
  KEY `group_inbox_notice_id_idx` (`notice_id`),
  KEY `group_inbox_group_id_created_notice_id_idx` (`group_id`,`created`,`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_inbox`
--

LOCK TABLES `group_inbox` WRITE;
/*!40000 ALTER TABLE `group_inbox` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_join_queue`
--

DROP TABLE IF EXISTS `group_join_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_join_queue` (
  `profile_id` int(11) NOT NULL COMMENT 'remote or local profile making the request',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'remote or local group to join, if any',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`profile_id`,`group_id`),
  KEY `group_join_queue_profile_id_created_idx` (`profile_id`,`created`),
  KEY `group_join_queue_group_id_created_idx` (`group_id`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_join_queue`
--

LOCK TABLES `group_join_queue` WRITE;
/*!40000 ALTER TABLE `group_join_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_join_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_member`
--

DROP TABLE IF EXISTS `group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_member` (
  `group_id` int(11) NOT NULL COMMENT 'foreign key to user_group',
  `profile_id` int(11) NOT NULL COMMENT 'foreign key to profile table',
  `is_admin` tinyint(4) DEFAULT '0' COMMENT 'is this user an admin?',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universal identifier',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`group_id`,`profile_id`),
  UNIQUE KEY `group_member_uri_key` (`uri`),
  KEY `group_member_profile_id_idx` (`profile_id`),
  KEY `group_member_created_idx` (`created`),
  KEY `group_member_profile_id_created_idx` (`profile_id`,`created`),
  KEY `group_member_group_id_created_idx` (`group_id`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_member`
--

LOCK TABLES `group_member` WRITE;
/*!40000 ALTER TABLE `group_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `happening`
--

DROP TABLE IF EXISTS `happening`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `happening` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL,
  `profile_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `title` varchar(255) COLLATE utf8_bin NOT NULL,
  `location` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `happening_uri_key` (`uri`),
  KEY `happening_created_idx` (`created`),
  KEY `happening_start_end_idx` (`start_time`,`end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `happening`
--

LOCK TABLES `happening` WRITE;
/*!40000 ALTER TABLE `happening` DISABLE KEYS */;
/*!40000 ALTER TABLE `happening` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inbox`
--

DROP TABLE IF EXISTS `inbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inbox` (
  `user_id` int(11) NOT NULL COMMENT 'user receiving the notice',
  `notice_ids` blob COMMENT 'packed list of notice ids',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inbox`
--

LOCK TABLES `inbox` WRITE;
/*!40000 ALTER TABLE `inbox` DISABLE KEYS */;
INSERT INTO `inbox` VALUES (1,'');
/*!40000 ALTER TABLE `inbox` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invitation`
--

DROP TABLE IF EXISTS `invitation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invitation` (
  `code` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'random code for an invitation',
  `user_id` int(11) NOT NULL COMMENT 'who sent the invitation',
  `address` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'invitation sent to',
  `address_type` varchar(8) COLLATE utf8_bin NOT NULL COMMENT 'address type ("email", "xmpp", "sms")',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `registered_user_id` int(11) DEFAULT NULL COMMENT 'if the invitation is converted, who the new user is',
  PRIMARY KEY (`code`),
  KEY `invitation_address_idx` (`address`,`address_type`),
  KEY `invitation_user_id_idx` (`user_id`),
  KEY `invitation_registered_user_id_idx` (`registered_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invitation`
--

LOCK TABLES `invitation` WRITE;
/*!40000 ALTER TABLE `invitation` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_group`
--

DROP TABLE IF EXISTS `local_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `local_group` (
  `group_id` int(11) NOT NULL COMMENT 'group represented',
  `nickname` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'group represented',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`group_id`),
  UNIQUE KEY `local_group_nickname_key` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_group`
--

LOCK TABLES `local_group` WRITE;
/*!40000 ALTER TABLE `local_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `local_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location_namespace`
--

DROP TABLE IF EXISTS `location_namespace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location_namespace` (
  `id` int(11) NOT NULL COMMENT 'identity for this namespace',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'description of the namespace',
  `created` datetime NOT NULL COMMENT 'date the record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location_namespace`
--

LOCK TABLES `location_namespace` WRITE;
/*!40000 ALTER TABLE `location_namespace` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_namespace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_token`
--

DROP TABLE IF EXISTS `login_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_token` (
  `user_id` int(11) NOT NULL COMMENT 'user owning this token',
  `token` char(32) COLLATE utf8_bin NOT NULL COMMENT 'token useable for logging in',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_token`
--

LOCK TABLES `login_token` WRITE;
/*!40000 ALTER TABLE `login_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `login_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier',
  `from_profile` int(11) NOT NULL COMMENT 'who the message is from',
  `to_profile` int(11) NOT NULL COMMENT 'who the message is to',
  `content` text COLLATE utf8_bin COMMENT 'message content',
  `rendered` text COLLATE utf8_bin COMMENT 'HTML version of the content',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL of any attachment (image, video, bookmark, whatever)',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  `source` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'source of comment, like "web", "im", or "clientname"',
  PRIMARY KEY (`id`),
  UNIQUE KEY `message_uri_key` (`uri`),
  KEY `message_from_idx` (`from_profile`),
  KEY `message_to_idx` (`to_profile`),
  KEY `message_created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nonce`
--

DROP TABLE IF EXISTS `nonce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nonce` (
  `consumer_key` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'unique identifier, root URL',
  `tok` char(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'buggy old value, ignored',
  `nonce` char(32) COLLATE utf8_bin NOT NULL COMMENT 'nonce',
  `ts` datetime NOT NULL COMMENT 'timestamp sent',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`consumer_key`,`ts`,`nonce`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nonce`
--

LOCK TABLES `nonce` WRITE;
/*!40000 ALTER TABLE `nonce` DISABLE KEYS */;
/*!40000 ALTER TABLE `nonce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `profile_id` int(11) NOT NULL COMMENT 'who made the update',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier, usually a tag URI',
  `content` text CHARACTER SET utf8 COMMENT 'update content',
  `rendered` text COLLATE utf8_bin COMMENT 'HTML version of the content',
  `url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL of any attachment (image, video, bookmark, whatever)',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  `reply_to` int(11) DEFAULT NULL COMMENT 'notice replied to (usually a guess)',
  `is_local` tinyint(4) DEFAULT '0' COMMENT 'notice was generated by a user',
  `source` varchar(32) COLLATE utf8_bin DEFAULT NULL COMMENT 'source of comment, like "web", "im", or "clientname"',
  `conversation` int(11) DEFAULT NULL COMMENT 'id of root notice in this conversation',
  `lat` decimal(10,7) DEFAULT NULL COMMENT 'latitude',
  `lon` decimal(10,7) DEFAULT NULL COMMENT 'longitude',
  `location_id` int(11) DEFAULT NULL COMMENT 'location id if possible',
  `location_ns` int(11) DEFAULT NULL COMMENT 'namespace for location',
  `repeat_of` int(11) DEFAULT NULL COMMENT 'notice this is a repeat of',
  `object_type` varchar(255) COLLATE utf8_bin DEFAULT 'http://activitystrea.ms/schema/1.0/note' COMMENT 'URI representing activity streams object type',
  `verb` varchar(255) COLLATE utf8_bin DEFAULT 'http://activitystrea.ms/schema/1.0/post' COMMENT 'URI representing activity streams verb',
  `scope` int(11) DEFAULT NULL COMMENT 'bit map for distribution scope; 0 = everywhere; 1 = this server only; 2 = addressees; 4 = followers; null = default',
  PRIMARY KEY (`id`),
  UNIQUE KEY `notice_uri_key` (`uri`),
  KEY `notice_created_id_is_local_idx` (`created`,`id`,`is_local`),
  KEY `notice_profile_id_idx` (`profile_id`,`created`,`id`),
  KEY `notice_repeat_of_created_id_idx` (`repeat_of`,`created`,`id`),
  KEY `notice_conversation_created_id_idx` (`conversation`,`created`,`id`),
  KEY `notice_replyto_idx` (`reply_to`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_source`
--

DROP TABLE IF EXISTS `notice_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice_source` (
  `code` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'source code',
  `name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'name of the source',
  `url` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'url to link to',
  `notice_id` int(11) NOT NULL COMMENT 'date this record was created',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_source`
--

LOCK TABLES `notice_source` WRITE;
/*!40000 ALTER TABLE `notice_source` DISABLE KEYS */;
INSERT INTO `notice_source` VALUES ('Afficheur','Afficheur','http://afficheur.sourceforge.jp/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('AgentSolo.com','AgentSolo.com','http://www.agentsolo.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('DarterosStatus','Darteros Status','http://www.darteros.com/doc/Darteros_Status',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Do','Gnome Do','http://do.davebsd.com/wiki/index.php?title=Microblog_Plugin',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Facebook','Facebook','http://apps.facebook.com/identica/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Gwibber','Gwibber','http://launchpad.net/gwibber',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('HelloTxt','HelloTxt','http://hellotxt.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('IdentiCurse','IdentiCurse','http://identicurse.net/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('IdentiFox','IdentiFox','http://www.bitbucket.org/uncryptic/identifox/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Jiminy','Jiminy','http://code.google.com/p/jiminy/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('LaTwit','LaTwit','http://latwit.mac65.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('LiveTweeter','LiveTweeter','http://addons.songbirdnest.com/addon/1204',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Mobidentica','Mobidentica','http://www.substanceofcode.com/software/mobidentica/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Pikchur','Pikchur','http://www.pikchur.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Ping.fm','Ping.fm','http://ping.fm/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('StatusNet Android','Android','http://status.net/android',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('StatusNet Blackberry','Blackberry','http://status.net/blackberry',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('StatusNet Desktop','StatusNet Desktop','http://status.net/desktop',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('StatusNet Mobile','StatusNet Mobile','http://status.net/mobile',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('StatusNet iPhone','iPhone','http://status.net/iphone',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('TweetDeck','TweetDeck','http://www.tweetdeck.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Twidge','Twidge','http://software.complete.org/twidge',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('Updating.Me','Updating.Me','http://updating.me/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('adium','Adium','http://www.adiumx.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('anyio','Any.IO','http://any.io/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('betwittered','BeTwittered','http://www.32hours.com/betwitteredinfo/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('bti','bti','http://gregkh.github.com/bti/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('choqok','Choqok','http://choqok.gnufolks.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('cliqset','Cliqset','http://www.cliqset.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('deskbar','Deskbar-Applet','http://www.gnome.org/projects/deskbar-applet/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('drupal','Drupal','http://drupal.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('eventbox','EventBox','http://thecosmicmachine.com/eventbox/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('feed2omb','feed2omb','http://projects.ciarang.com/p/feed2omb/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('gNewBook','gNewBook','http://www.gnewbook.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('get2gnow','get2gnow','http://uberchicgeekchick.com/?projects=get2gnow',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('gravity','Gravity','http://mobileways.de/gravity',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('identica-mode','Emacs Identica-mode','http://nongnu.org/identica-mode/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('identicatools','Laconica Tools','http://bitbucketlabs.net/laconica-tools/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('identichat','identichat','http://identichat.prosody.im/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('identitwitch','IdentiTwitch','http://richfish.org/identitwitch/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('livetweeter','livetweeter','http://addons.songbirdnest.com/addon/1204',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('maisha','Maisha','http://maisha.grango.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('mbpidgin','mbpidgin','http://code.google.com/p/microblog-purple/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('moconica','Moconica','http://moconica.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('mustard','mustard','http://mustard.macno.org',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('nambu','Nambu','http://www.nambu.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('peoplebrowsr','PeopleBrowsr','http://www.peoplebrowsr.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('pingvine','PingVine','http://pingvine.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('pocketwit','PockeTwit','http://code.google.com/p/pocketwit/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('posty','Posty','http://spreadingfunkyness.com/posty/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('qtwitter','qTwitter','http://qtwitter.ayoy.net/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('qwit','Qwit','http://code.google.com/p/qwit/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('royalewithcheese','Royale With Cheese','http://p.hellyeah.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('rss.me','rss.me','http://rss.me/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('rssdent','rssdent','http://github.com/zcopley/rssdent/tree/master',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('rygh.no','rygh.no','http://rygh.no/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('ryghsms','ryghsms','http://sms.rygh.no/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('smob','SMOB','http://smob.sioc-project.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('socialoomphBfD4pMqz31','SocialOomph','http://www.socialoomph.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('spaz','Spaz','http://funkatron.com/spaz',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('tarpipe','tarpipe','http://tarpipe.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('tjunar','Tjunar','http://nederflash.nl/boek/titels/tjunar-air',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('tr.im','tr.im','http://tr.im/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('triklepost','Tricklepost','http://github.com/zcopley/tricklepost/tree/master',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('tweenky','Tweenky','http://beta.tweenky.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twhirl','Twhirl','http://www.twhirl.org/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twibble','twibble','http://www.twibble.de/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twidge','Twidge','http://software.complete.org/twidge',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twidroid','twidroid','http://www.twidroid.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twittelator','Twittelator','http://www.stone.com/iPhone/Twittelator/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitter','Twitter','http://twitter.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitterfeed','twitterfeed','http://twitterfeed.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitterphoto','TwitterPhoto','http://richfish.org/twitterphoto/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitterpm','Net::Twitter','http://search.cpan.org/dist/Net-Twitter/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twittertools','Twitter Tools','http://wordpress.org/extend/plugins/twitter-tools/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitux','Twitux','http://live.gnome.org/DanielMorales/Twitux',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('twitvim','TwitVim','http://vim.sourceforge.net/scripts/script.php?script_id=2204',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('urfastr','urfastr','http://urfastr.net/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54'),('yatca','Yatca','http://www.yatca.com/',0,'2013-03-29 17:30:54','2013-03-29 21:30:54');
/*!40000 ALTER TABLE `notice_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice_tag`
--

DROP TABLE IF EXISTS `notice_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice_tag` (
  `tag` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'hash tag associated with this notice',
  `notice_id` int(11) NOT NULL COMMENT 'notice tagged',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`tag`,`notice_id`),
  KEY `notice_tag_created_idx` (`created`),
  KEY `notice_tag_notice_id_idx` (`notice_id`),
  KEY `notice_tag_tag_created_notice_id_idx` (`tag`,`created`,`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice_tag`
--

LOCK TABLES `notice_tag` WRITE;
/*!40000 ALTER TABLE `notice_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_application`
--

DROP TABLE IF EXISTS `oauth_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `owner` int(11) NOT NULL COMMENT 'owner of the application',
  `consumer_key` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'application consumer key',
  `name` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'name of the application',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'description of the application',
  `icon` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'application icon',
  `source_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'application homepage - used for source link',
  `organization` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'name of the organization running the application',
  `homepage` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'homepage for the organization',
  `callback_url` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'url to redirect to after authentication',
  `type` tinyint(4) DEFAULT '0' COMMENT 'type of app, 1 = browser, 2 = desktop',
  `access_type` tinyint(4) DEFAULT '0' COMMENT 'default access type, bit 1 = read, bit 2 = write',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth_application_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_application`
--

LOCK TABLES `oauth_application` WRITE;
/*!40000 ALTER TABLE `oauth_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_application_user`
--

DROP TABLE IF EXISTS `oauth_application_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_application_user` (
  `profile_id` int(11) NOT NULL COMMENT 'user of the application',
  `application_id` int(11) NOT NULL COMMENT 'id of the application',
  `access_type` tinyint(4) DEFAULT '0' COMMENT 'access type, bit 1 = read, bit 2 = write',
  `token` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'request or access token',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`profile_id`,`application_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_application_user`
--

LOCK TABLES `oauth_application_user` WRITE;
/*!40000 ALTER TABLE `oauth_application_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_application_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth_token_association`
--

DROP TABLE IF EXISTS `oauth_token_association`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_token_association` (
  `profile_id` int(11) NOT NULL COMMENT 'associated user',
  `application_id` int(11) NOT NULL COMMENT 'the application',
  `token` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'token used for this association',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`profile_id`,`application_id`,`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_token_association`
--

LOCK TABLES `oauth_token_association` WRITE;
/*!40000 ALTER TABLE `oauth_token_association` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_token_association` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oid_associations`
--

DROP TABLE IF EXISTS `oid_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oid_associations` (
  `server_url` blob NOT NULL,
  `handle` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `secret` blob,
  `issued` int(11) DEFAULT NULL,
  `lifetime` int(11) DEFAULT NULL,
  `assoc_type` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`server_url`(255),`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oid_associations`
--

LOCK TABLES `oid_associations` WRITE;
/*!40000 ALTER TABLE `oid_associations` DISABLE KEYS */;
/*!40000 ALTER TABLE `oid_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oid_nonces`
--

DROP TABLE IF EXISTS `oid_nonces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oid_nonces` (
  `server_url` varchar(2047) COLLATE utf8_bin DEFAULT NULL,
  `timestamp` int(11) DEFAULT NULL,
  `salt` char(40) COLLATE utf8_bin DEFAULT NULL,
  UNIQUE KEY `oid_nonces_server_url_timestamp_salt_key` (`server_url`(255),`timestamp`,`salt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oid_nonces`
--

LOCK TABLES `oid_nonces` WRITE;
/*!40000 ALTER TABLE `oid_nonces` DISABLE KEYS */;
/*!40000 ALTER TABLE `oid_nonces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `old_school_prefs`
--

DROP TABLE IF EXISTS `old_school_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `old_school_prefs` (
  `user_id` int(11) NOT NULL COMMENT 'user who has the preference',
  `stream_mode_only` tinyint(4) DEFAULT '1' COMMENT 'No conversation streams',
  `conversation_tree` tinyint(4) DEFAULT '1' COMMENT 'Hierarchical tree view for conversations',
  `stream_nicknames` tinyint(4) DEFAULT '1' COMMENT 'Show nicknames for authors and addressees in streams',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `old_school_prefs`
--

LOCK TABLES `old_school_prefs` WRITE;
/*!40000 ALTER TABLE `old_school_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `old_school_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll`
--

DROP TABLE IF EXISTS `poll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `question` text COLLATE utf8_bin,
  `options` text COLLATE utf8_bin,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `poll_uri_key` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll`
--

LOCK TABLES `poll` WRITE;
/*!40000 ALTER TABLE `poll` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poll_response`
--

DROP TABLE IF EXISTS `poll_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poll_response` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of the response',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'UUID to the response notice',
  `poll_id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of poll being responded to',
  `profile_id` int(11) DEFAULT NULL,
  `selection` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `poll_uri_key` (`uri`),
  UNIQUE KEY `poll_response_poll_id_profile_id_key` (`poll_id`,`profile_id`),
  KEY `poll_response_profile_id_poll_id_index` (`profile_id`,`poll_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poll_response`
--

LOCK TABLES `poll_response` WRITE;
/*!40000 ALTER TABLE `poll_response` DISABLE KEYS */;
/*!40000 ALTER TABLE `poll_response` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `nickname` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT 'nickname or username',
  `fullname` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'display name',
  `profileurl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL, cached so we dont regenerate',
  `homepage` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'identifying URL',
  `bio` text CHARACTER SET utf8 COMMENT 'descriptive biography',
  `location` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'physical location',
  `lat` decimal(10,7) DEFAULT NULL COMMENT 'latitude',
  `lon` decimal(10,7) DEFAULT NULL COMMENT 'longitude',
  `location_id` int(11) DEFAULT NULL COMMENT 'location id if possible',
  `location_ns` int(11) DEFAULT NULL COMMENT 'namespace for location',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  KEY `profile_nickname_idx` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile`
--

LOCK TABLES `profile` WRITE;
/*!40000 ALTER TABLE `profile` DISABLE KEYS */;
INSERT INTO `profile` VALUES (1,'admin','admin','http://statusnet-mahut.rhcloud.com/index.php/admin',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2013-03-29 21:30:55','2013-03-29 21:30:55');
/*!40000 ALTER TABLE `profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_block`
--

DROP TABLE IF EXISTS `profile_block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_block` (
  `blocker` int(11) NOT NULL COMMENT 'user making the block',
  `blocked` int(11) NOT NULL COMMENT 'profile that is blocked',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date of blocking',
  PRIMARY KEY (`blocker`,`blocked`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_block`
--

LOCK TABLES `profile_block` WRITE;
/*!40000 ALTER TABLE `profile_block` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_detail`
--

DROP TABLE IF EXISTS `profile_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` int(11) NOT NULL,
  `field_name` varchar(16) COLLATE utf8_bin NOT NULL,
  `value_index` int(11) DEFAULT NULL,
  `field_value` text COLLATE utf8_bin,
  `date` datetime DEFAULT NULL,
  `rel` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `rel_profile` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `profile_detail_profile_id_field_name_value_index` (`profile_id`,`field_name`,`value_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_detail`
--

LOCK TABLES `profile_detail` WRITE;
/*!40000 ALTER TABLE `profile_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_list`
--

DROP TABLE IF EXISTS `profile_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `tagger` int(11) NOT NULL COMMENT 'user making the tag',
  `tag` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'people tag',
  `description` text COLLATE utf8_bin COMMENT 'description of the people tag',
  `private` tinyint(4) DEFAULT '0' COMMENT 'is this tag private',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date the tag was added',
  `modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'date the tag was modified',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universal identifier',
  `mainpage` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'page to link to',
  `tagged_count` int(11) DEFAULT '0' COMMENT 'number of people tagged with this tag by this user',
  `subscriber_count` int(11) DEFAULT '0' COMMENT 'number of subscribers to this tag',
  PRIMARY KEY (`tagger`,`tag`),
  UNIQUE KEY `profile_list_id_key` (`id`),
  KEY `profile_list_modified_idx` (`modified`),
  KEY `profile_list_tag_idx` (`tag`),
  KEY `profile_list_tagger_tag_idx` (`tagger`,`tag`),
  KEY `profile_list_tagged_count_idx` (`tagged_count`),
  KEY `profile_list_subscriber_count_idx` (`subscriber_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_list`
--

LOCK TABLES `profile_list` WRITE;
/*!40000 ALTER TABLE `profile_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_role`
--

DROP TABLE IF EXISTS `profile_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_role` (
  `profile_id` int(11) NOT NULL COMMENT 'account having the role',
  `role` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'string representing the role',
  `created` datetime NOT NULL COMMENT 'date the role was granted',
  PRIMARY KEY (`profile_id`,`role`),
  KEY `profile_role_role_created_profile_id_idx` (`role`,`created`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_role`
--

LOCK TABLES `profile_role` WRITE;
/*!40000 ALTER TABLE `profile_role` DISABLE KEYS */;
INSERT INTO `profile_role` VALUES (1,'administrator','2013-03-29 21:30:55'),(1,'moderator','2013-03-29 21:30:55'),(1,'owner','2013-03-29 21:30:55');
/*!40000 ALTER TABLE `profile_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_tag`
--

DROP TABLE IF EXISTS `profile_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_tag` (
  `tagger` int(11) NOT NULL COMMENT 'user making the tag',
  `tagged` int(11) NOT NULL COMMENT 'profile tagged',
  `tag` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'hash tag associated with this notice',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date the tag was added',
  PRIMARY KEY (`tagger`,`tagged`,`tag`),
  KEY `profile_tag_modified_idx` (`modified`),
  KEY `profile_tag_tagger_tag_idx` (`tagger`,`tag`),
  KEY `profile_tag_tagged_idx` (`tagged`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_tag`
--

LOCK TABLES `profile_tag` WRITE;
/*!40000 ALTER TABLE `profile_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_tag_subscription`
--

DROP TABLE IF EXISTS `profile_tag_subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_tag_subscription` (
  `profile_tag_id` int(11) NOT NULL COMMENT 'foreign key to profile_tag',
  `profile_id` int(11) NOT NULL COMMENT 'foreign key to profile table',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`profile_tag_id`,`profile_id`),
  KEY `profile_tag_subscription_profile_id_idx` (`profile_id`),
  KEY `profile_tag_subscription_created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_tag_subscription`
--

LOCK TABLES `profile_tag_subscription` WRITE;
/*!40000 ALTER TABLE `profile_tag_subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `profile_tag_subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_answer`
--

DROP TABLE IF EXISTS `qna_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qna_answer` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of the response',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'UUID to the answer notice',
  `question_id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of question being responded to',
  `content` text COLLATE utf8_bin,
  `best` tinyint(4) DEFAULT NULL,
  `revisions` int(11) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_uri_key` (`uri`),
  UNIQUE KEY `question_id_profile_id_key` (`question_id`,`profile_id`),
  KEY `profile_id_question_id_index` (`profile_id`,`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_answer`
--

LOCK TABLES `qna_answer` WRITE;
/*!40000 ALTER TABLE `qna_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_question`
--

DROP TABLE IF EXISTS `qna_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qna_question` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `title` text COLLATE utf8_bin,
  `closed` tinyint(4) DEFAULT NULL,
  `description` text COLLATE utf8_bin,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_uri_key` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_question`
--

LOCK TABLES `qna_question` WRITE;
/*!40000 ALTER TABLE `qna_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qna_vote`
--

DROP TABLE IF EXISTS `qna_vote`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qna_vote` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of the vote',
  `question_id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of question being voted on',
  `answer_id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID of answer being voted on',
  `vote` tinyint(4) DEFAULT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `profile_id_question_Id_index` (`profile_id`,`answer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qna_vote`
--

LOCK TABLES `qna_vote` WRITE;
/*!40000 ALTER TABLE `qna_vote` DISABLE KEYS */;
/*!40000 ALTER TABLE `qna_vote` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue_item`
--

DROP TABLE IF EXISTS `queue_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `frame` blob NOT NULL COMMENT 'data: object reference or opaque string',
  `transport` varchar(8) COLLATE utf8_bin NOT NULL COMMENT 'queue for what? "email", "xmpp", "sms", "irc", ...',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `claimed` datetime DEFAULT NULL COMMENT 'date this item was claimed',
  PRIMARY KEY (`id`),
  KEY `queue_item_created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue_item`
--

LOCK TABLES `queue_item` WRITE;
/*!40000 ALTER TABLE `queue_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `related_group`
--

DROP TABLE IF EXISTS `related_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `related_group` (
  `group_id` int(11) NOT NULL COMMENT 'foreign key to user_group',
  `related_group_id` int(11) NOT NULL COMMENT 'foreign key to user_group',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`group_id`,`related_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `related_group`
--

LOCK TABLES `related_group` WRITE;
/*!40000 ALTER TABLE `related_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `related_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remember_me`
--

DROP TABLE IF EXISTS `remember_me`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remember_me` (
  `code` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'good random code',
  `user_id` int(11) NOT NULL COMMENT 'user who is logged in',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remember_me`
--

LOCK TABLES `remember_me` WRITE;
/*!40000 ALTER TABLE `remember_me` DISABLE KEYS */;
/*!40000 ALTER TABLE `remember_me` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `remote_profile`
--

DROP TABLE IF EXISTS `remote_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remote_profile` (
  `id` int(11) NOT NULL COMMENT 'foreign key to profile table',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier, usually a tag URI',
  `postnoticeurl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL we use for posting notices',
  `updateprofileurl` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL we use for updates to this profile',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `remote_profile_uri_key` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remote_profile`
--

LOCK TABLES `remote_profile` WRITE;
/*!40000 ALTER TABLE `remote_profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `remote_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `notice_id` int(11) NOT NULL COMMENT 'notice that is the reply',
  `profile_id` int(11) NOT NULL COMMENT 'profile replied to',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  `replied_id` int(11) DEFAULT NULL COMMENT 'notice replied to (not used, see notice.reply_to)',
  PRIMARY KEY (`notice_id`,`profile_id`),
  KEY `reply_notice_id_idx` (`notice_id`),
  KEY `reply_profile_id_idx` (`profile_id`),
  KEY `reply_replied_id_idx` (`replied_id`),
  KEY `reply_profile_id_modified_notice_id_idx` (`profile_id`,`modified`,`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rsvp`
--

DROP TABLE IF EXISTS `rsvp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rsvp` (
  `id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID',
  `uri` varchar(255) COLLATE utf8_bin NOT NULL,
  `profile_id` int(11) DEFAULT NULL,
  `event_id` char(36) COLLATE utf8_bin NOT NULL COMMENT 'UUID',
  `response` char(1) COLLATE utf8_bin DEFAULT NULL COMMENT 'Y, N, or ? for three-state yes, no, maybe',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rsvp_uri_key` (`uri`),
  UNIQUE KEY `rsvp_profile_event_key` (`profile_id`,`event_id`),
  KEY `rsvp_created_idx` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rsvp`
--

LOCK TABLES `rsvp` WRITE;
/*!40000 ALTER TABLE `rsvp` DISABLE KEYS */;
/*!40000 ALTER TABLE `rsvp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Table name',
  `checksum` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'Checksum of schema array; a mismatch indicates we should check the table more thoroughly.',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchsub`
--

DROP TABLE IF EXISTS `searchsub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchsub` (
  `search` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'hash search associated with this subscription',
  `profile_id` int(11) NOT NULL COMMENT 'profile ID of subscribing user',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`search`,`profile_id`),
  KEY `searchsub_created_idx` (`created`),
  KEY `searchsub_profile_id_tag_idx` (`profile_id`,`search`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchsub`
--

LOCK TABLES `searchsub` WRITE;
/*!40000 ALTER TABLE `searchsub` DISABLE KEYS */;
/*!40000 ALTER TABLE `searchsub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` varchar(32) COLLATE utf8_bin NOT NULL COMMENT 'session ID',
  `session_data` text COLLATE utf8_bin COMMENT 'session data',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  KEY `session_modified_idx` (`modified`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms_carrier`
--

DROP TABLE IF EXISTS `sms_carrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms_carrier` (
  `id` int(11) NOT NULL COMMENT 'primary key for SMS carrier',
  `name` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'name of the carrier',
  `email_pattern` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'sprintf pattern for making an email address from a phone number',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sms_carrier_name_key` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms_carrier`
--

LOCK TABLES `sms_carrier` WRITE;
/*!40000 ALTER TABLE `sms_carrier` DISABLE KEYS */;
INSERT INTO `sms_carrier` VALUES (100056,'3 River Wireless','%s@sms.3rivers.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100057,'7-11 Speakout','%s@cingularme.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100058,'Airtel (Karnataka, India)','%s@airtelkk.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100059,'Alaska Communications Systems','%s@msg.acsalaska.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100060,'Alltel Wireless','%s@message.alltel.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100061,'AT&T Wireless','%s@txt.att.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100062,'Bell Mobility (Canada)','%s@txt.bell.ca','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100063,'Boost Mobile','%s@myboostmobile.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100064,'Cellular One (Dobson)','%s@mobile.celloneusa.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100065,'Cingular (Postpaid)','%s@cingularme.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100066,'Centennial Wireless','%s@cwemail.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100067,'Cingular (GoPhone prepaid)','%s@cingularme.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100068,'Claro (Nicaragua)','%s@ideasclaro-ca.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100069,'Comcel','%s@comcel.com.co','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100070,'Cricket','%s@sms.mycricket.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100071,'CTI','%s@sms.ctimovil.com.ar','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100072,'Emtel (Mauritius)','%s@emtelworld.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100073,'Fido (Canada)','%s@fido.ca','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100074,'General Communications Inc.','%s@msg.gci.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100075,'Globalstar','%s@msg.globalstarusa.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100076,'Helio','%s@myhelio.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100077,'Illinois Valley Cellular','%s@ivctext.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100078,'i wireless','%s.iws@iwspcs.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100079,'Meteor (Ireland)','%s@sms.mymeteor.ie','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100080,'Mero Mobile (Nepal)','%s@sms.spicenepal.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100081,'MetroPCS','%s@mymetropcs.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100082,'Movicom','%s@movimensaje.com.ar','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100083,'Mobitel (Sri Lanka)','%s@sms.mobitel.lk','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100084,'Movistar (Colombia)','%s@movistar.com.co','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100085,'MTN (South Africa)','%s@sms.co.za','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100086,'MTS (Canada)','%s@text.mtsmobility.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100087,'Nextel (Argentina)','%s@nextel.net.ar','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100088,'Orange (Poland)','%s@orange.pl','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100089,'Personal (Argentina)','%s@personal-net.com.ar','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100090,'Plus GSM (Poland)','%s@text.plusgsm.pl','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100091,'President\'s Choice (Canada)','%s@txt.bell.ca','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100092,'Qwest','%s@qwestmp.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100093,'Rogers (Canada)','%s@pcs.rogers.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100094,'Sasktel (Canada)','%s@sms.sasktel.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100095,'Setar Mobile email (Aruba)','%s@mas.aw','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100096,'Solo Mobile','%s@txt.bell.ca','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100097,'Sprint (PCS)','%s@messaging.sprintpcs.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100098,'Sprint (Nextel)','%s@page.nextel.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100099,'Suncom','%s@tms.suncom.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100100,'T-Mobile','%s@tmomail.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100101,'T-Mobile (Austria)','%s@sms.t-mobile.at','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100102,'Telus Mobility (Canada)','%s@msg.telus.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100103,'Thumb Cellular','%s@sms.thumbcellular.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100104,'Tigo (Formerly Ola)','%s@sms.tigo.com.co','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100105,'Unicel','%s@utext.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100106,'US Cellular','%s@email.uscc.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100107,'Verizon','%s@vtext.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100108,'Virgin Mobile (Canada)','%s@vmobile.ca','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100109,'Virgin Mobile (USA)','%s@vmobl.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100110,'YCC','%s@sms.ycc.ru','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100111,'Orange (UK)','%s@orange.net','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100112,'Cincinnati Bell Wireless','%s@gocbw.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100113,'T-Mobile Germany','%s@t-mobile-sms.de','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100114,'Vodafone Germany','%s@vodafone-sms.de','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100115,'E-Plus','%s@smsmail.eplus.de','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100116,'Cellular South','%s@csouth1.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100117,'ChinaMobile (139)','%s@139.com','2013-03-29 17:30:54','2013-03-29 21:30:54'),(100118,'Dialog Axiata','%s@dialog.lk','2013-03-29 17:30:54','2013-03-29 21:30:54');
/*!40000 ALTER TABLE `sms_carrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription`
--

DROP TABLE IF EXISTS `subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription` (
  `subscriber` int(11) NOT NULL COMMENT 'profile listening',
  `subscribed` int(11) NOT NULL COMMENT 'profile being listened to',
  `jabber` tinyint(4) DEFAULT '1' COMMENT 'deliver jabber messages',
  `sms` tinyint(4) DEFAULT '1' COMMENT 'deliver sms messages',
  `token` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'authorization token',
  `secret` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'token secret',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`subscriber`,`subscribed`),
  UNIQUE KEY `subscription_uri_key` (`uri`),
  KEY `subscription_subscriber_idx` (`subscriber`,`created`),
  KEY `subscription_subscribed_idx` (`subscribed`,`created`),
  KEY `subscription_token_idx` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription`
--

LOCK TABLES `subscription` WRITE;
/*!40000 ALTER TABLE `subscription` DISABLE KEYS */;
INSERT INTO `subscription` VALUES (1,1,1,1,NULL,NULL,NULL,'2013-03-29 21:30:55','2013-03-29 21:30:55');
/*!40000 ALTER TABLE `subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_queue`
--

DROP TABLE IF EXISTS `subscription_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subscription_queue` (
  `subscriber` int(11) NOT NULL COMMENT 'remote or local profile making the request',
  `subscribed` int(11) NOT NULL COMMENT 'remote or local profile being subscribed to',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`subscriber`,`subscribed`),
  KEY `subscription_queue_subscriber_created_idx` (`subscriber`,`created`),
  KEY `subscription_queue_subscribed_created_idx` (`subscribed`,`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_queue`
--

LOCK TABLES `subscription_queue` WRITE;
/*!40000 ALTER TABLE `subscription_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagsub`
--

DROP TABLE IF EXISTS `tagsub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagsub` (
  `tag` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'hash tag associated with this subscription',
  `profile_id` int(11) NOT NULL COMMENT 'profile ID of subscribing user',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  PRIMARY KEY (`tag`,`profile_id`),
  KEY `tagsub_created_idx` (`created`),
  KEY `tagsub_profile_id_tag_idx` (`profile_id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagsub`
--

LOCK TABLES `tagsub` WRITE;
/*!40000 ALTER TABLE `tagsub` DISABLE KEYS */;
/*!40000 ALTER TABLE `tagsub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `consumer_key` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'unique identifier, root URL',
  `tok` char(32) COLLATE utf8_bin NOT NULL COMMENT 'identifying value',
  `secret` char(32) COLLATE utf8_bin NOT NULL COMMENT 'secret value',
  `type` tinyint(4) DEFAULT '0' COMMENT 'request or access',
  `state` tinyint(4) DEFAULT '0' COMMENT 'for requests, 0 = initial, 1 = authorized, 2 = used',
  `verifier` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'verifier string for OAuth 1.0a',
  `verified_callback` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'verified callback URL for OAuth 1.0a',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`consumer_key`,`tok`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL COMMENT 'foreign key to profile table',
  `nickname` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'nickname or username, duped in profile',
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'salted password, can be null for OpenID users',
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'email address for password recovery etc.',
  `incomingemail` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'email address for post-by-email',
  `emailnotifysub` tinyint(4) DEFAULT '1' COMMENT 'Notify by email of subscriptions',
  `emailnotifyfav` tinyint(4) DEFAULT '1' COMMENT 'Notify by email of favorites',
  `emailnotifynudge` tinyint(4) DEFAULT '1' COMMENT 'Notify by email of nudges',
  `emailnotifymsg` tinyint(4) DEFAULT '1' COMMENT 'Notify by email of direct messages',
  `emailnotifyattn` tinyint(4) DEFAULT '1' COMMENT 'Notify by email of @-replies',
  `emailmicroid` tinyint(4) DEFAULT '1' COMMENT 'whether to publish email microid',
  `language` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'preferred language',
  `timezone` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT 'timezone',
  `emailpost` tinyint(4) DEFAULT '1' COMMENT 'Post by email',
  `sms` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'sms phone number',
  `carrier` int(11) DEFAULT NULL COMMENT 'foreign key to sms_carrier',
  `smsnotify` tinyint(4) DEFAULT '0' COMMENT 'whether to send notices to SMS',
  `smsreplies` tinyint(4) DEFAULT '0' COMMENT 'whether to send notices to SMS on replies',
  `smsemail` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'built from sms and carrier',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universally unique identifier, usually a tag URI',
  `autosubscribe` tinyint(4) DEFAULT '0' COMMENT 'automatically subscribe to users who subscribe to us',
  `subscribe_policy` tinyint(4) DEFAULT '0' COMMENT '0 = anybody can subscribe; 1 = require approval',
  `urlshorteningservice` varchar(50) COLLATE utf8_bin DEFAULT 'internal' COMMENT 'service to use for auto-shortening URLs',
  `inboxed` tinyint(4) DEFAULT '0' COMMENT 'has an inbox been created for this user?',
  `private_stream` tinyint(4) DEFAULT '0' COMMENT 'whether to limit all notices to followers only',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_nickname_key` (`nickname`),
  UNIQUE KEY `user_email_key` (`email`),
  UNIQUE KEY `user_incomingemail_key` (`incomingemail`),
  UNIQUE KEY `user_sms_key` (`sms`),
  UNIQUE KEY `user_uri_key` (`uri`),
  KEY `user_smsemail_idx` (`smsemail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','782c355b9e1015682ac30e173452d340',NULL,NULL,1,1,1,1,1,1,NULL,NULL,1,NULL,NULL,0,0,NULL,'http://statusnet-mahut.rhcloud.com/index.php/user/1',0,0,'internal',1,0,'2013-03-29 21:30:55','2013-03-29 21:30:55');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group`
--

DROP TABLE IF EXISTS `user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'unique identifier',
  `nickname` varchar(64) COLLATE utf8_bin DEFAULT NULL COMMENT 'nickname for addressing',
  `fullname` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'display name',
  `homepage` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'URL, cached so we dont regenerate',
  `description` text COLLATE utf8_bin COMMENT 'group description',
  `location` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'related physical location, if any',
  `original_logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'original size logo',
  `homepage_logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'homepage (profile) size logo',
  `stream_logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'stream-sized logo',
  `mini_logo` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'mini logo',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  `uri` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'universal identifier',
  `mainpage` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT 'page for group info to link to',
  `join_policy` tinyint(4) DEFAULT NULL COMMENT '0=open; 1=requires admin approval',
  `force_scope` tinyint(4) DEFAULT NULL COMMENT '0=never,1=sometimes,-1=always',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_group_uri_key` (`uri`),
  KEY `user_group_nickname_idx` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group`
--

LOCK TABLES `user_group` WRITE;
/*!40000 ALTER TABLE `user_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_im_prefs`
--

DROP TABLE IF EXISTS `user_im_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_im_prefs` (
  `user_id` int(11) NOT NULL COMMENT 'user',
  `screenname` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'screenname on this service',
  `transport` varchar(255) COLLATE utf8_bin NOT NULL COMMENT 'transport (ex xmpp, aim)',
  `notify` tinyint(4) DEFAULT '0' COMMENT 'Notify when a new notice is sent',
  `replies` tinyint(4) DEFAULT '0' COMMENT 'Send replies  from people not subscribed to',
  `microid` tinyint(4) DEFAULT '1' COMMENT 'Publish a MicroID',
  `updatefrompresence` tinyint(4) DEFAULT '0' COMMENT 'Send replies from people not subscribed to.',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`,`transport`),
  UNIQUE KEY `transport_screenname_key` (`transport`,`screenname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_im_prefs`
--

LOCK TABLES `user_im_prefs` WRITE;
/*!40000 ALTER TABLE `user_im_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_im_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_location_prefs`
--

DROP TABLE IF EXISTS `user_location_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_location_prefs` (
  `user_id` int(11) NOT NULL COMMENT 'user who has the preference',
  `share_location` tinyint(4) DEFAULT '1' COMMENT 'Whether to share location data',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_location_prefs`
--

LOCK TABLES `user_location_prefs` WRITE;
/*!40000 ALTER TABLE `user_location_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_location_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_openid`
--

DROP TABLE IF EXISTS `user_openid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_openid` (
  `canonical` varchar(255) COLLATE utf8_bin NOT NULL,
  `display` varchar(255) COLLATE utf8_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`canonical`),
  UNIQUE KEY `user_openid_display_idx` (`display`),
  KEY `user_openid_user_id_idx` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_openid`
--

LOCK TABLES `user_openid` WRITE;
/*!40000 ALTER TABLE `user_openid` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_openid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_openid_trustroot`
--

DROP TABLE IF EXISTS `user_openid_trustroot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_openid_trustroot` (
  `trustroot` varchar(255) COLLATE utf8_bin NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`trustroot`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_openid_trustroot`
--

LOCK TABLES `user_openid_trustroot` WRITE;
/*!40000 ALTER TABLE `user_openid_trustroot` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_openid_trustroot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_urlshortener_prefs`
--

DROP TABLE IF EXISTS `user_urlshortener_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_urlshortener_prefs` (
  `user_id` int(11) NOT NULL COMMENT 'user',
  `urlshorteningservice` varchar(50) COLLATE utf8_bin DEFAULT 'internal' COMMENT 'service to use for auto-shortening URLs',
  `maxurllength` int(11) NOT NULL COMMENT 'urls greater than this length will be shortened, 0 = always, null = never',
  `maxnoticelength` int(11) NOT NULL COMMENT 'notices with content greater than this value will have all urls shortened, 0 = always, null = never',
  `created` datetime NOT NULL COMMENT 'date this record was created',
  `modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'date this record was modified',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_urlshortener_prefs`
--

LOCK TABLES `user_urlshortener_prefs` WRITE;
/*!40000 ALTER TABLE `user_urlshortener_prefs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_urlshortener_prefs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-03-29 17:43:44
