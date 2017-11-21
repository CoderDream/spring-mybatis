/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50719
Source Host           : localhost:3306
Source Database       : examination_system

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2017-11-21 17:39:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for courses
-- ----------------------------
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `course_name` varchar(256) NOT NULL COMMENT '课程名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程分类表';

-- ----------------------------
-- Records of courses
-- ----------------------------

-- ----------------------------
-- Table structure for examination
-- ----------------------------
DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination` (
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号系统生成（考点简称+YYYYMMDD+班级号）',
  `user_id` varchar(256) NOT NULL COMMENT '出题老师的编号',
  `exam_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出题时间',
  `single_id` varchar(256) NOT NULL COMMENT '所有单选题答题的题号，逗号分隔',
  `multiple_id` varchar(256) NOT NULL COMMENT '所有多选题答题的题号，逗号分隔',
  `true_false_id` varchar(256) NOT NULL COMMENT '所有判断题答题的题号，逗号分隔',
  `fill_in_gaps_id` varchar(256) NOT NULL COMMENT '所有填空题答题的题号，逗号分隔',
  `simple_anwser_id` varchar(256) NOT NULL COMMENT '所有简答题答题的题号，逗号分隔',
  `program_id` varchar(256) NOT NULL COMMENT '所有编程题答题的题号，逗号分隔',
  `descrpt` varchar(512) NOT NULL COMMENT '考题说明信息',
  `valid_flag` int(1) NOT NULL COMMENT '试卷有效状态标识：1有效，0/空无效',
  PRIMARY KEY (`exam_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考卷表';

-- ----------------------------
-- Records of examination
-- ----------------------------

-- ----------------------------
-- Table structure for fsp_answer
-- ----------------------------
DROP TABLE IF EXISTS `fsp_answer`;
CREATE TABLE `fsp_answer` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `answer` varchar(256) NOT NULL COMMENT '答案',
  `fsp_id` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '填空题，简答题，编程题的题号',
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号',
  `user_id` varchar(256) NOT NULL COMMENT '用户编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='(填空题，简答题，编程题)学生答题表';

-- ----------------------------
-- Records of fsp_answer
-- ----------------------------

-- ----------------------------
-- Table structure for fsp_questions
-- ----------------------------
DROP TABLE IF EXISTS `fsp_questions`;
CREATE TABLE `fsp_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `question` varchar(2048) NOT NULL COMMENT '题干',
  `std_answer` varchar(256) NOT NULL COMMENT '标准答案',
  `question_type` int(1) NOT NULL COMMENT '考题类型：4.填空  5.简答   6.编程题',
  `tech_cate_id` varchar(256) NOT NULL COMMENT '外键，考题知识点分类ID',
  `pubdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出题时间',
  `descrpt` varchar(512) NOT NULL COMMENT '考题说明信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试题表(填空题，简答题，编程题)';

-- ----------------------------
-- Records of fsp_questions
-- ----------------------------

-- ----------------------------
-- Table structure for olts_score
-- ----------------------------
DROP TABLE IF EXISTS `olts_score`;
CREATE TABLE `olts_score` (
  `iscord` bigint(20) NOT NULL COMMENT 'ID',
  `score` double(4,1) NOT NULL COMMENT '成绩',
  `test_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '考试时间',
  `descrpt` varchar(256) NOT NULL COMMENT '说明信息',
  `user_id` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '学生ID',
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号',
  `fsp_score` double(4,1) NOT NULL COMMENT '总分',
  PRIMARY KEY (`iscord`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成绩表';

-- ----------------------------
-- Records of olts_score
-- ----------------------------

-- ----------------------------
-- Table structure for olts_users
-- ----------------------------
DROP TABLE IF EXISTS `olts_users`;
CREATE TABLE `olts_users` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `stu_no` varchar(256) NOT NULL COMMENT '学号',
  `id_card_no` varchar(256) NOT NULL COMMENT '身份证号',
  `user_name` varchar(256) NOT NULL COMMENT '用户名',
  `pass_word` varchar(256) NOT NULL COMMENT '密码',
  `mobile` varchar(256) NOT NULL COMMENT '手机',
  `home_tel` varchar(256) NOT NULL COMMENT '家庭电话',
  `home_addr` varchar(256) NOT NULL COMMENT '家庭地址',
  `sch_addr` varchar(256) NOT NULL COMMENT '学校地址',
  `qq` varchar(256) NOT NULL COMMENT 'QQ',
  `email` varchar(256) NOT NULL COMMENT 'email',
  `user_type` varchar(256) NOT NULL COMMENT '用户类型（1.老师， 9.管理员，学生为空）',
  `gender` varchar(256) NOT NULL COMMENT '性别',
  `birthday` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出生日期',
  `nation_place` varchar(256) NOT NULL COMMENT '籍贯',
  `marjor` varchar(256) NOT NULL COMMENT '专业',
  `edu_background` varchar(256) NOT NULL COMMENT '最高学历',
  `graduate_school` varchar(256) NOT NULL COMMENT '毕业院校',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of olts_users
-- ----------------------------

-- ----------------------------
-- Table structure for smd_options
-- ----------------------------
DROP TABLE IF EXISTS `smd_options`;
CREATE TABLE `smd_options` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `option_A` varchar(256) NOT NULL COMMENT '选项A',
  `option_B` varchar(256) NOT NULL COMMENT '选项B',
  `option_C` varchar(256) NOT NULL COMMENT '选项C',
  `option_D` varchar(256) NOT NULL COMMENT '选项D',
  `option_E` varchar(256) NOT NULL COMMENT '选项E',
  `question_id` varchar(256) NOT NULL COMMENT '外键，单选题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单选题选项表';

-- ----------------------------
-- Records of smd_options
-- ----------------------------

-- ----------------------------
-- Table structure for smd_questions
-- ----------------------------
DROP TABLE IF EXISTS `smd_questions`;
CREATE TABLE `smd_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `question` varchar(256) NOT NULL COMMENT '题干',
  `correct` varchar(256) NOT NULL COMMENT '考题答案',
  `question_type` int(1) NOT NULL COMMENT '考题类型：1.单选  2.多选  3.判断',
  `tech_cate_id` varchar(256) NOT NULL COMMENT '考题知识点分类ID',
  `descrpt` varchar(256) NOT NULL COMMENT '考题说明信息',
  `pubdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '出题时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='知识点分类表';

-- ----------------------------
-- Records of smd_questions
-- ----------------------------

-- ----------------------------
-- Table structure for tech_category
-- ----------------------------
DROP TABLE IF EXISTS `tech_category`;
CREATE TABLE `tech_category` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `tech_ctgr` varchar(256) NOT NULL COMMENT '知识点分类',
  `course_id` varchar(256) NOT NULL COMMENT '课程ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='知识点分类表';

-- ----------------------------
-- Records of tech_category
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
