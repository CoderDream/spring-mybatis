/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : onlinetest

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-11-22 09:28:15
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`onlinetest` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `onlinetest`;

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for operator
-- ----------------------------
DROP TABLE IF EXISTS `operator`;
CREATE TABLE `operator` (
  `optID` varchar(10) NOT NULL COMMENT '登录帐号',
  `optName` varchar(10) DEFAULT NULL COMMENT '登录用户名',
  `password` varchar(10) DEFAULT NULL COMMENT '密码',
  `isAdmin` varchar(1) DEFAULT NULL COMMENT '是否管理员',
  PRIMARY KEY (`optID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='操作人员';

-- ----------------------------
-- Records of operator
-- ----------------------------
INSERT INTO `operator` VALUES ('110', '110', '110', '0');
INSERT INTO `operator` VALUES ('12', '小王', '123', '0');
INSERT INTO `operator` VALUES ('A0030', 'admin', 'admin', '1');
INSERT INTO `operator` VALUES ('admin', '系统管理员', 'admin', '1');
INSERT INTO `operator` VALUES ('李金刚', '李金刚', '123', '2');

-- ----------------------------
-- Table structure for paper
-- ----------------------------
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

-- ----------------------------
-- Records of paper
-- ----------------------------
INSERT INTO `paper` VALUES ('2', '12', '2017-03-03 09:16:41', '99', '卷子1', '232', '2017-05-08 09:16:41');
INSERT INTO `paper` VALUES ('3', '5', '2017-02-03 17:00:22', '2', 'num2卷子', 'asdf', '2017-04-27 09:16:41');
INSERT INTO `paper` VALUES ('4', '34', '2017-02-03 18:13:13', '1', 'thrid卷子', '3434', '2017-06-27 09:16:41');
INSERT INTO `paper` VALUES ('11', '100', '2017-04-28 09:16:41', '2', '二卷', 'admin', '2017-06-27 09:16:41');
INSERT INTO `paper` VALUES ('19', '1', '2017-04-28 10:28:19', '-1', '1', '1', '2017-06-29 10:28:19');

-- ----------------------------
-- Table structure for paperdetail
-- ----------------------------
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

-- ----------------------------
-- Records of paperdetail
-- ----------------------------
INSERT INTO `paperdetail` VALUES ('4', '2', '6');
INSERT INTO `paperdetail` VALUES ('7', '2', '9');
INSERT INTO `paperdetail` VALUES ('8', '2', '8');
INSERT INTO `paperdetail` VALUES ('9', '2', '2');
INSERT INTO `paperdetail` VALUES ('10', '3', '2');
INSERT INTO `paperdetail` VALUES ('11', '3', '7');
INSERT INTO `paperdetail` VALUES ('12', '3', '6');
INSERT INTO `paperdetail` VALUES ('26', null, null);
INSERT INTO `paperdetail` VALUES ('29', '3', '10');
INSERT INTO `paperdetail` VALUES ('34', '3', '8');
INSERT INTO `paperdetail` VALUES ('35', '3', '10');
INSERT INTO `paperdetail` VALUES ('36', '3', '11');
INSERT INTO `paperdetail` VALUES ('37', '4', '7');
INSERT INTO `paperdetail` VALUES ('39', '11', '2');
INSERT INTO `paperdetail` VALUES ('40', '11', '6');
INSERT INTO `paperdetail` VALUES ('41', '11', '7');
INSERT INTO `paperdetail` VALUES ('47', '19', '7');
INSERT INTO `paperdetail` VALUES ('48', '19', '2');
INSERT INTO `paperdetail` VALUES ('49', '19', '12');

-- ----------------------------
-- Table structure for question
-- ----------------------------
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

-- ----------------------------
-- Records of question
-- ----------------------------
INSERT INTO `question` VALUES ('2', '地理', '地理第一道题', '6', '困难', 'B');
INSERT INTO `question` VALUES ('6', null, 'ppppp', '6', '困难', 'C');
INSERT INTO `question` VALUES ('7', null, 'tttttttttttttttt', '3', '简单', 'B');
INSERT INTO `question` VALUES ('8', '数学', '数学第一道题', '6', '困难', 'B, C, D');
INSERT INTO `question` VALUES ('9', '英语', '英语第一道题', '6', '简单', 'C');
INSERT INTO `question` VALUES ('10', '英语', '英语第二道题', '3', '简单', 'B, C');
INSERT INTO `question` VALUES ('11', null, 'qwqweqweqe', '3', '简单', 'C');
INSERT INTO `question` VALUES ('12', null, 'asfda', '2', '简单', 'B');
INSERT INTO `question` VALUES ('13', null, 'sdafa', '12', '简单', 'B');
INSERT INTO `question` VALUES ('16', null, 'aerfadf', '6', '简单', 'B');
INSERT INTO `question` VALUES ('18', '历史', '中国建国时间', '10', '困难', 'b');

-- ----------------------------
-- Table structure for questiondetail
-- ----------------------------
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

-- ----------------------------
-- Records of questiondetail
-- ----------------------------
INSERT INTO `questiondetail` VALUES ('5', 'B', null, '2');
INSERT INTO `questiondetail` VALUES ('6', 'D', '上海', '2');
INSERT INTO `questiondetail` VALUES ('7', 'A', '深圳', '2');
INSERT INTO `questiondetail` VALUES ('8', 'C', '成都', '2');
INSERT INTO `questiondetail` VALUES ('21', 'D', 'ppp', '6');
INSERT INTO `questiondetail` VALUES ('22', 'B', 'pppp', '6');
INSERT INTO `questiondetail` VALUES ('23', 'A', 'ppppp', '6');
INSERT INTO `questiondetail` VALUES ('24', 'C', 'ppp', '6');
INSERT INTO `questiondetail` VALUES ('25', 'B', 'ttttttttt', '7');
INSERT INTO `questiondetail` VALUES ('26', 'D', 'tttttt', '7');
INSERT INTO `questiondetail` VALUES ('27', 'C', 'ttttttt', '7');
INSERT INTO `questiondetail` VALUES ('28', 'A', 'tttttttttttt', '7');
INSERT INTO `questiondetail` VALUES ('29', 'B', 'jjjjj', '8');
INSERT INTO `questiondetail` VALUES ('30', 'A', 'jjjjj', '8');
INSERT INTO `questiondetail` VALUES ('31', 'D', 'j', '8');
INSERT INTO `questiondetail` VALUES ('32', 'C', 'jjjjjjjj', '8');
INSERT INTO `questiondetail` VALUES ('33', 'D', 'qqqqqqq', '9');
INSERT INTO `questiondetail` VALUES ('34', 'A', 'qqqqqqqq', '9');
INSERT INTO `questiondetail` VALUES ('35', 'B', 'qqqqqqqqq', '9');
INSERT INTO `questiondetail` VALUES ('36', 'C', 'qqqqqqqqqqq', '9');
INSERT INTO `questiondetail` VALUES ('37', 'A', 'xccxc', '10');
INSERT INTO `questiondetail` VALUES ('38', 'D', 'cxcx', '10');
INSERT INTO `questiondetail` VALUES ('39', 'B', 'xcxcxc', '10');
INSERT INTO `questiondetail` VALUES ('40', 'C', 'x', '10');
INSERT INTO `questiondetail` VALUES ('41', 'D', 'weqewqwe', '11');
INSERT INTO `questiondetail` VALUES ('42', 'B', 'qweq', '11');
INSERT INTO `questiondetail` VALUES ('43', 'A', 'qweqwe', '11');
INSERT INTO `questiondetail` VALUES ('44', 'C', 'weqewq', '11');
INSERT INTO `questiondetail` VALUES ('45', 'B', 'sfdadfa', '12');
INSERT INTO `questiondetail` VALUES ('46', 'C', 'dfadf', '12');
INSERT INTO `questiondetail` VALUES ('47', 'D', 'asdfadf', '12');
INSERT INTO `questiondetail` VALUES ('48', 'A', 'sfdasdfa', '12');
INSERT INTO `questiondetail` VALUES ('49', 'B', 'asdfa', '13');
INSERT INTO `questiondetail` VALUES ('50', 'D', 'adfasdf', '13');
INSERT INTO `questiondetail` VALUES ('51', 'C', 'sdfasdf', '13');
INSERT INTO `questiondetail` VALUES ('52', 'A', 'sdfasdf', '13');
INSERT INTO `questiondetail` VALUES ('53', 'A', '1969', '18');
INSERT INTO `questiondetail` VALUES ('54', 'B', '1990', '18');
INSERT INTO `questiondetail` VALUES ('55', 'C', '1974', '18');
INSERT INTO `questiondetail` VALUES ('56', 'D', '1975', '18');

-- ----------------------------
-- Table structure for studentinfo
-- ----------------------------
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

-- ----------------------------
-- Records of studentinfo
-- ----------------------------
INSERT INTO `studentinfo` VALUES ('1', 'alice', '13140103', '110', '软件3班', 'A0030');
INSERT INTO `studentinfo` VALUES ('4', null, '1', '1', '1', '12');
INSERT INTO `studentinfo` VALUES ('5', '110', '110', '110', '110', '110');

-- ----------------------------
-- Table structure for studscore
-- ----------------------------
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

-- ----------------------------
-- Records of studscore
-- ----------------------------
INSERT INTO `studscore` VALUES ('25', '4', '3', null, '110');
INSERT INTO `studscore` VALUES ('26', '11', '0', null, '110');
INSERT INTO `studscore` VALUES ('27', '19', '9', null, '110');

-- ----------------------------
-- Table structure for studscoredetail
-- ----------------------------
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

-- ----------------------------
-- Records of studscoredetail
-- ----------------------------
INSERT INTO `studscoredetail` VALUES ('25', '110', '37', 'none', '3', 'B, C');
INSERT INTO `studscoredetail` VALUES ('26', '110', '39', 'none', '6', 'B');
INSERT INTO `studscoredetail` VALUES ('27', '110', '40', 'none', '6', 'C');
INSERT INTO `studscoredetail` VALUES ('28', '110', '41', 'none', '3', 'B');
INSERT INTO `studscoredetail` VALUES ('29', '110', '49', 'A', '2', 'B');
SET FOREIGN_KEY_CHECKS=1;
