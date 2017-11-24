/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : spring_mybatis_0902

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-11-24 10:53:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_clazz
-- ----------------------------
DROP TABLE IF EXISTS `tb_clazz`;
CREATE TABLE `tb_clazz` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(18) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tb_clazz
-- ----------------------------
INSERT INTO `tb_clazz` VALUES ('1', 'j1601');
INSERT INTO `tb_clazz` VALUES ('2', 'j1602');

-- ----------------------------
-- Table structure for tb_student
-- ----------------------------
DROP TABLE IF EXISTS `tb_student`;
CREATE TABLE `tb_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(18) COLLATE utf8_bin DEFAULT NULL,
  `sex` char(3) COLLATE utf8_bin DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `clazz_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clazz_id` (`clazz_id`),
  CONSTRAINT `tb_student_ibfk_1` FOREIGN KEY (`clazz_id`) REFERENCES `tb_clazz` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tb_student
-- ----------------------------
INSERT INTO `tb_student` VALUES ('1', 'jack', '男', '22', '1');
INSERT INTO `tb_student` VALUES ('2', 'rose', '女', '18', '1');
INSERT INTO `tb_student` VALUES ('3', 'tom', '男', '25', '2');
INSERT INTO `tb_student` VALUES ('4', 'mary', '女', '20', '2');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(18) COLLATE utf8_bin DEFAULT NULL,
  `sex` char(2) COLLATE utf8_bin DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('2', 'jack', '男', '22');
INSERT INTO `tb_user` VALUES ('3', 'rose', '女', '18');
INSERT INTO `tb_user` VALUES ('4', 'tom', '男', '25');
INSERT INTO `tb_user` VALUES ('5', 'mary', '女', '20');

-- ----------------------------
-- Table structure for tb_user2
-- ----------------------------
DROP TABLE IF EXISTS `tb_user2`;
CREATE TABLE `tb_user2` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(18) COLLATE utf8_bin DEFAULT NULL,
  `user_age` int(11) DEFAULT NULL,
  `user_sex` char(2) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of tb_user2
-- ----------------------------
INSERT INTO `tb_user2` VALUES ('1', 'jack', '22', '男');
INSERT INTO `tb_user2` VALUES ('2', 'rose', '18', '女');
INSERT INTO `tb_user2` VALUES ('3', 'tom', '25', '男');
INSERT INTO `tb_user2` VALUES ('4', 'mary', '20', '女');
SET FOREIGN_KEY_CHECKS=1;
