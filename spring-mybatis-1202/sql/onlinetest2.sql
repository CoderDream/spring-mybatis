/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.7.19-log : Database - onlinetest
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`onlinetest` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `onlinetest`;

/*Table structure for table `operator` */

DROP TABLE IF EXISTS `operator`;

CREATE TABLE `operator` (
  `optID` varchar(10) NOT NULL COMMENT '登录帐号',
  `optName` varchar(10) DEFAULT NULL COMMENT '登录用户名',
  `password` varchar(10) DEFAULT NULL COMMENT '密码',
  `isAdmin` varchar(1) DEFAULT NULL COMMENT '是否管理员',
  PRIMARY KEY (`optID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作人员';

/*Data for the table `operator` */

insert  into `operator`(`optID`,`optName`,`password`,`isAdmin`) values ('110','110','110','0'),('12','小王','123','0'),('A0030','admin','admin','1'),('admin','系统管理员','admin','1'),('李金刚','李金刚','123','2');

/*Table structure for table `paper` */

DROP TABLE IF EXISTS `paper`;

CREATE TABLE `paper` (
  `paperID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `fullScore` int(11) DEFAULT NULL COMMENT '满分',
  `paperTime` datetime DEFAULT NULL COMMENT '考试时间',
  `validateTime` int(5) DEFAULT NULL COMMENT '做卷时间',
  `paperName` varchar(45) NOT NULL COMMENT '试卷名称',
  `byUser` varchar(45) NOT NULL COMMENT '出卷人',
  `available` datetime DEFAULT NULL COMMENT '有效期',
  PRIMARY KEY (`paperID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='试卷主体信息';

/*Data for the table `paper` */

insert  into `paper`(`paperID`,`fullScore`,`paperTime`,`validateTime`,`paperName`,`byUser`,`available`) values (2,12,'2017-03-03 09:16:41',99,'卷子1','232','2017-05-08 09:16:41'),(3,5,'2017-02-03 17:00:22',2,'num2卷子','asdf','2017-04-27 09:16:41'),(4,34,'2017-02-03 18:13:13',1,'thrid卷子','3434','2017-06-27 09:16:41'),(11,100,'2017-04-28 09:16:41',2,'二卷','admin','2017-06-27 09:16:41'),(19,1,'2017-04-28 10:28:19',-1,'1','1','2017-06-29 10:28:19');

/*Table structure for table `paperdetail` */

DROP TABLE IF EXISTS `paperdetail`;

CREATE TABLE `paperdetail` (
  `paperDetailID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `paperID` int(11) DEFAULT NULL COMMENT '试卷ID',
  `questID` int(11) DEFAULT NULL COMMENT '题库ID',
  PRIMARY KEY (`paperDetailID`),
  KEY `FK_Reference_3` (`paperID`),
  KEY `FK_paperdetail_2` (`questID`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`paperID`) REFERENCES `paper` (`paperID`),
  CONSTRAINT `FK_paperdetail_2` FOREIGN KEY (`questID`) REFERENCES `question` (`questID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='试卷明细信息';

/*Data for the table `paperdetail` */

insert  into `paperdetail`(`paperDetailID`,`paperID`,`questID`) values (4,2,6),(7,2,9),(8,2,8),(9,2,2),(10,3,2),(11,3,7),(12,3,6),(26,NULL,NULL),(29,3,10),(34,3,8),(35,3,10),(36,3,11),(37,4,7),(39,11,2),(40,11,6),(41,11,7),(47,19,7),(48,19,2),(49,19,12);

/*Table structure for table `question` */

DROP TABLE IF EXISTS `question`;

CREATE TABLE `question` (
  `questID` int(10) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(50) DEFAULT NULL COMMENT '题型',
  `mainContent` varchar(100) DEFAULT NULL COMMENT '题干',
  `score` int(20) DEFAULT NULL COMMENT '所占分',
  `easyLevel` varchar(8) DEFAULT NULL COMMENT '难易程度',
  `answer` varchar(10) DEFAULT NULL COMMENT '答案',
  PRIMARY KEY (`questID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='题库主体信息';

/*Data for the table `question` */

insert  into `question`(`questID`,`type`,`mainContent`,`score`,`easyLevel`,`answer`) values (2,'地理','地理第一道题',6,'困难','B'),(6,NULL,'ppppp',6,'困难','C'),(7,NULL,'tttttttttttttttt',3,'简单','B'),(8,'数学','数学第一道题',6,'困难','B, C, D'),(9,'英语','英语第一道题',6,'简单','C'),(10,'英语','英语第二道题',3,'简单','B, C'),(11,NULL,'qwqweqweqe',3,'简单','C'),(12,NULL,'asfda',2,'简单','B'),(13,NULL,'sdafa',12,'简单','B'),(16,NULL,'aerfadf',6,'简单','B'),(18,'历史','中国建国时间',10,'困难','b');

/*Table structure for table `questiondetail` */

DROP TABLE IF EXISTS `questiondetail`;

CREATE TABLE `questiondetail` (
  `questDetailID` int(200) NOT NULL AUTO_INCREMENT,
  `optionNo` varchar(2) DEFAULT NULL,
  `optionContent` varchar(100) DEFAULT NULL,
  `questID` int(20) DEFAULT NULL,
  PRIMARY KEY (`questDetailID`),
  KEY `FK_Reference_2` (`questID`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`questID`) REFERENCES `question` (`questID`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='题库明细信息';

/*Data for the table `questiondetail` */

insert  into `questiondetail`(`questDetailID`,`optionNo`,`optionContent`,`questID`) values (5,'B',NULL,2),(6,'D','上海',2),(7,'A','深圳',2),(8,'C','成都',2),(21,'D','ppp',6),(22,'B','pppp',6),(23,'A','ppppp',6),(24,'C','ppp',6),(25,'B','ttttttttt',7),(26,'D','tttttt',7),(27,'C','ttttttt',7),(28,'A','tttttttttttt',7),(29,'B','jjjjj',8),(30,'A','jjjjj',8),(31,'D','j',8),(32,'C','jjjjjjjj',8),(33,'D','qqqqqqq',9),(34,'A','qqqqqqqq',9),(35,'B','qqqqqqqqq',9),(36,'C','qqqqqqqqqqq',9),(37,'A','xccxc',10),(38,'D','cxcx',10),(39,'B','xcxcxc',10),(40,'C','x',10),(41,'D','weqewqwe',11),(42,'B','qweq',11),(43,'A','qweqwe',11),(44,'C','weqewq',11),(45,'B','sfdadfa',12),(46,'C','dfadf',12),(47,'D','asdfadf',12),(48,'A','sfdasdfa',12),(49,'B','asdfa',13),(50,'D','adfasdf',13),(51,'C','sdfasdf',13),(52,'A','sdfasdf',13),(53,'A','1969',18),(54,'B','1990',18),(55,'C','1974',18),(56,'D','1975',18);

/*Table structure for table `studentinfo` */

DROP TABLE IF EXISTS `studentinfo`;

CREATE TABLE `studentinfo` (
  `stdID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(15) DEFAULT NULL COMMENT '学生姓名',
  `num` varchar(11) DEFAULT NULL COMMENT '学生年龄',
  `tel` varchar(21) DEFAULT NULL COMMENT '性别',
  `cla` varchar(10) DEFAULT NULL COMMENT '年级',
  `optID` varchar(10) DEFAULT NULL COMMENT '操作员帐号',
  PRIMARY KEY (`stdID`),
  KEY `FK_Reference_1` (`optID`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`optID`) REFERENCES `operator` (`optID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='学生信息';

/*Data for the table `studentinfo` */

insert  into `studentinfo`(`stdID`,`name`,`num`,`tel`,`cla`,`optID`) values (1,'alice','13140103','110','软件3班','A0030'),(4,NULL,'1','1','1','12'),(5,'110','110','110','110','110');

/*Table structure for table `studscore` */

DROP TABLE IF EXISTS `studscore`;

CREATE TABLE `studscore` (
  `studScoreID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `paperID` int(11) DEFAULT NULL COMMENT '试卷ID',
  `totalScore` int(11) DEFAULT NULL COMMENT '总分',
  `stdID` int(11) DEFAULT NULL COMMENT '学生',
  `optID` varchar(20) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`studScoreID`),
  KEY `FK_studscore_1` (`paperID`),
  KEY `FK_studscore_2` (`stdID`),
  CONSTRAINT `FK_studscore_1` FOREIGN KEY (`paperID`) REFERENCES `paper` (`paperID`),
  CONSTRAINT `FK_studscore_2` FOREIGN KEY (`stdID`) REFERENCES `studentinfo` (`stdID`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='学生考试成绩';

/*Data for the table `studscore` */

insert  into `studscore`(`studScoreID`,`paperID`,`totalScore`,`stdID`,`optID`) values (25,4,3,NULL,'110'),(26,11,0,NULL,'110'),(27,19,9,NULL,'110');

/*Table structure for table `studscoredetail` */

DROP TABLE IF EXISTS `studscoredetail`;

CREATE TABLE `studscoredetail` (
  `studscoreDetailID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `optID` varchar(30) NOT NULL COMMENT '考生ID',
  `paperDetailID` int(11) NOT NULL COMMENT '考试题ID号',
  `myAnswer` varchar(15) DEFAULT NULL COMMENT '考生答案',
  `score` int(11) DEFAULT NULL COMMENT '单题得分',
  `answer` varchar(15) DEFAULT NULL COMMENT '正确答案',
  PRIMARY KEY (`studscoreDetailID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `studscoredetail` */

insert  into `studscoredetail`(`studscoreDetailID`,`optID`,`paperDetailID`,`myAnswer`,`score`,`answer`) values (25,'110',37,'none',3,'B, C'),(26,'110',39,'none',6,'B'),(27,'110',40,'none',6,'C'),(28,'110',41,'none',3,'B'),(29,'110',49,'A',2,'B');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
