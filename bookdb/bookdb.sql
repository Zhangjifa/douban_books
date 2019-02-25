/*
SQLyog Ultimate v12.5.0 (64 bit)
MySQL - 5.7.17-log : Database - bookdb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bookdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bookdb`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can add permission',2,'add_permission'),
(5,'Can change permission',2,'change_permission'),
(6,'Can delete permission',2,'delete_permission'),
(7,'Can add group',3,'add_group'),
(8,'Can change group',3,'change_group'),
(9,'Can delete group',3,'delete_group'),
(10,'Can add user',4,'add_user'),
(11,'Can change user',4,'change_user'),
(12,'Can delete user',4,'delete_user'),
(13,'Can add content type',5,'add_contenttype'),
(14,'Can change content type',5,'change_contenttype'),
(15,'Can delete content type',5,'delete_contenttype'),
(16,'Can add session',6,'add_session'),
(17,'Can change session',6,'change_session'),
(18,'Can delete session',6,'delete_session');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `books` */

DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL COMMENT 'ID号',
  `name` varchar(255) DEFAULT NULL COMMENT '书名',
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `publish` varchar(255) DEFAULT NULL COMMENT '出版社',
  `original` varchar(255) DEFAULT NULL COMMENT '原作名',
  `translator` varchar(128) DEFAULT NULL COMMENT '译者',
  `year` varchar(128) DEFAULT NULL COMMENT '出版年',
  `page` int(10) unsigned DEFAULT NULL COMMENT '页数',
  `price` double(6,2) unsigned DEFAULT NULL COMMENT '定价',
  `binding` varchar(32) DEFAULT NULL COMMENT '装帧',
  `series` varchar(128) DEFAULT NULL COMMENT '丛书',
  `isbn` varchar(128) DEFAULT NULL COMMENT 'ISBN',
  `score` varchar(128) DEFAULT NULL COMMENT '评分',
  `number` int(10) unsigned DEFAULT NULL COMMENT '评论人数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `books` */

insert  into `books`(`id`,`name`,`author`,`publish`,`original`,`translator`,`year`,`page`,`price`,`binding`,`series`,`isbn`,`score`,`number`) values 
(1021379,'社会心理学','Unknown','华东师范大学出版社','None','杨中芳','2004-12',806,87.00,' 平装','当代心理科学名著译丛',' 9787561739921','8.1',203),
(1231910,'具体数学（英文版第2版）','[美] Ronald L. Graham Donald E. Knuth Oren Patashnik','机械工业出版社','Concrete Mathematics','None','2002-8',657,49.00,' 平装','经典原版书库',' 9787111105763','9.5',819),
(2079208,'Sketching User Experiences','Bill Buxton','Morgan Kaufmann','None','None','2007-4-11',448,0.00,' Paperback','Unknown',' 9780123740373','8.1',85),
(3072383,'The Algorithm Design Manual','Steven S Skiena','Springer','None','None','2011-11-14',730,0.00,' Hardcover','Unknown',' 9781848000698','8.8',98),
(3155710,'算法概论','Sanjoy Dasgupta Christos Papadimitriou Umesh Vazirani','清华大学出版社','Algorithms','王沛 唐扬斌 刘齐军','2008-7',345,39.99,' 平装','国外经典教材·计算机科学与技术',' 9787302179399','9.0',218),
(4308069,'信息设计','简·维索基·欧格雷迪(O＇Grady.J.V.)','凤凰出版传媒集团，译林出版社','None','郭瑽','2009-12',226,98.00,' 软精装','Unknown',' 9787544711128','8.4',220),
(6822276,'服务的品质是什么','畠山芳雄','东方出版社','None','包永花 方木森','2011-8',168,21.00,'Unknown','Unknown',' 9787506042413','6.1',17),
(10607365,'Data Structures and Algorithms in Python','Michael T. Goodrich Roberto Tamassia Michael H. Goldwasser','John Wiley &amp; Sons','None','None','2013-7-5',768,0.00,' Hardcover','Unknown',' 9781118290279','9.4',55),
(20507206,'众病之王','Unknown','中信出版社','The Emperor of All Maladies: A Biography of Cancer','李虎','2013-2-4',552,42.00,' 平装','Unknown',' 9787508638119','9.1',5341),
(25981171,'Lean Customer Development','Cindy Alvarez','O\'Reilly Media','None','None','2014-6-8',240,0.00,' Hardcover','The Lean Series',' 9781449356354','0',0),
(26302533,'编程珠玑（第2版•修订版）','[美] Jon Bentley 乔恩•本特利','人民邮电出版社','More Programming Pearls，Second Edition','黄倩 钱丽艳','2014-12',280,39.00,' 平装','编程珠玑（修订版）',' 9787115357618','8.5',136),
(26309060,'生命是什么','Unknown','商务印书馆','None','\n            张卜天','2014-12',97,15.00,' 平装','Unknown',' 9787100107556','9.0',365),
(26593822,'程序员的数学2','平冈和幸 堀玄','人民邮电出版社','None','陈筱烟','2015-8-1',405,0.00,' 平装','程序员的数学',' 9787115400512','8.8',121),
(26794265,'奇点来临','索恩 (Tony Thorne MBE)','人民邮电出版社','None','赵俐','2016-6-1',155,0.00,' 平装','Unknown',' 9787115420244','3.7',29),
(27109832,'趣学算法','陈小玉','人民邮电出版社','None','None','2017-7-1',587,89.00,' 平装','Unknown',' 9787115459572','8.5',14),
(27197908,'设计师要懂沟通术','[美] Tom Greever','人民邮电出版社','None','UXRen翻译组','2017-11',180,59.00,' 平装','Unknown',' 9787115471079','0',0),
(30133192,'游戏UI设计：修炼之道','师维','电子工业出版社','None','None','2018-1-1',252,79.00,' 平装','Unknown',' 9787121332548','8.9',19),
(30163021,'枕边算法书','[韩] 林栢濬','人民邮电出版社','None','崔盛一','2018-3',258,45.00,' 平装','图灵程序设计丛书',' 9787115472991','7.1',16),
(30399060,'中国游戏风云','王亚晖','中国发展出版社','None','None','2018-11-1',636,168.00,' 精装','Unknown',' 9787517705598','9.4',19);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2019-01-29 02:01:47.509898'),
(2,'auth','0001_initial','2019-01-29 02:01:53.272608'),
(3,'admin','0001_initial','2019-01-29 02:01:54.834215'),
(4,'admin','0002_logentry_remove_auto_add','2019-01-29 02:01:54.899042'),
(5,'contenttypes','0002_remove_content_type_name','2019-01-29 02:01:55.713235'),
(6,'auth','0002_alter_permission_name_max_length','2019-01-29 02:01:56.196950'),
(7,'auth','0003_alter_user_email_max_length','2019-01-29 02:01:56.734476'),
(8,'auth','0004_alter_user_username_opts','2019-01-29 02:01:56.806300'),
(9,'auth','0005_alter_user_last_login_null','2019-01-29 02:01:57.297295'),
(10,'auth','0006_require_contenttypes_0002','2019-01-29 02:01:57.348160'),
(11,'auth','0007_alter_validators_add_error_messages','2019-01-29 02:01:57.418962'),
(12,'auth','0008_alter_user_username_max_length','2019-01-29 02:01:58.647934'),
(13,'sessions','0001_initial','2019-01-29 02:01:59.060900');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `django_session` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
