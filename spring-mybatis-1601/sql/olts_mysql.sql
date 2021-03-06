--创建表空间, 最好创建到oracle安装的目录下，避免不小删除了。
create tablespace olts
datafile 'E:\app\datafiles\olts.dbf'
size 50M
autoextend on;


/*
创建用户并为用户分配表空间
新创建的用户开始是没有登录到Oracle的权限，要用系统管理员sys给lqolts授权
*/
create user lqolts
identified by olts
default tablespace olts;

grant connect,resource to lqolts;
--grant create table,create any view,create procedure to lqolts;

--修改用户密码
--alter user lqolts identified by olts;

--删除用户, cascade级联删除该用户创建的数据库对象
--drop user olts cascade;

-------------------------------------------------------------------------------------

--创建用户表 序列
--drop sequence olts_users_seq;
create sequence olts_users_seq
start with 1;

--用户表
create table olts_users(
    id integer not null primary key,
    stu_no char(18),					 --学号 
    id_card_no char(18) not null unique, --身份证号
    user_name varchar(20) not null,  --用户名
    pass_word varchar2(10) not null, --密码
    mobile varchar2(11), 			--手机
    home_tel varchar(12),			--家庭电话
    home_addr varchar(50), 			--家庭地址
    sch_addr varchar(50), 			--学校地址
    qq char(15),
    email varchar2(50),
    user_type number(2), 			--用户类型（1.老师， 9.管理员，学生为空）
	gender varchar2(5),            	--性别
    birthday date,                  --出生日期
    nation_place varchar2(20),      --籍贯
    marjor varchar2(30),            --专业
    edu_Background varchar2(20),  	--最高学历
    graduate_School varchar2(20)	--毕业院校
)

SET FOREIGN_KEY_CHECKS=0;

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
  `birthday` timestamp NOT NULL COMMENT '出生日期',
  `nation_place` varchar(256) NOT NULL COMMENT '籍贯',
  `marjor` varchar(256) NOT NULL COMMENT '专业',
  `edu_background` varchar(256) NOT NULL COMMENT '最高学历',
  `graduate_school` varchar(256) NOT NULL COMMENT '毕业院校',
  PRIMARY KEY (`id`),
  KEY `idx_olts_users` (`olts_users`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

/*
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word,user_type) 
       values(olts_users_seq.nextval,'999999999999999999','460200197801151393','james','james',1);
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word) 
       values(olts_users_seq.nextval,'111111111111111111','460200197801151394','student','student');
commit;
*/


--课程分类

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `course_name` varchar(256) NOT NULL COMMENT '课程名',  
  PRIMARY KEY (`id`),
  KEY `idx_courses` (`courses`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='课程分类表';

insert into courses values(course_seq.nextval,'JavaSE');
insert into courses values(course_seq.nextval,'HTML');
insert into courses values(course_seq.nextval,'Javascript');
insert into courses values(course_seq.nextval,'CSS');
insert into courses values(course_seq.nextval,'Oracle');
insert into courses values(course_seq.nextval,'JDBC');
insert into courses values(course_seq.nextval,'JSP');
insert into courses values(course_seq.nextval,'Servlet');
insert into courses values(course_seq.nextval,'JUnit');
insert into courses values(course_seq.nextval,'Struts 1/2');
insert into courses values(course_seq.nextval,'Hibernate');
insert into courses values(course_seq.nextval,'ibatis/MyBatis');
insert into courses values(course_seq.nextval,'Spring');
insert into courses values(course_seq.nextval,'Spring MVC');
insert into courses values(course_seq.nextval,'jQuery');
insert into courses values(course_seq.nextval,'easyui');
insert into courses values(course_seq.nextval,'AJAX');
insert into courses values(course_seq.nextval,'Android');
insert into courses values(course_seq.nextval,'WebService');
insert into courses values(course_seq.nextval,'XML');
insert into courses values(course_seq.nextval,'UML');
insert into courses values(course_seq.nextval,'Ant');
insert into courses values(course_seq.nextval,'log4j');
insert into courses values(course_seq.nextval,'Lunix/Unix');
commit;



--知识点分类表


DROP TABLE IF EXISTS `tech_category`;
CREATE TABLE `tech_category` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `tech_ctgr` varchar(256) NOT NULL COMMENT '知识点分类',  
  `course_id` varchar(256) NOT NULL COMMENT '课程ID', 
  PRIMARY KEY (`id`),
  KEY `idx_tech_category` (`tech_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='知识点分类表';

insert into tech_category values(tech_category_seq.nextval,'数据类型',1);
insert into tech_category values(tech_category_seq.nextval,'变量、数据类型、运算符',1);
insert into tech_category values(tech_category_seq.nextval,'条件结构、循环结构、switch',1);
insert into tech_category values(tech_category_seq.nextval,'数组',1);
insert into tech_category values(tech_category_seq.nextval,'构造函数',1);
insert into tech_category values(tech_category_seq.nextval,'方法',1);
insert into tech_category values(tech_category_seq.nextval,'访问修饰符',1);
insert into tech_category values(tech_category_seq.nextval,'static、关键字',1);
insert into tech_category values(tech_category_seq.nextval,'类和对象、包',1);
insert into tech_category values(tech_category_seq.nextval,'继承、抽象类、多态',1);
insert into tech_category values(tech_category_seq.nextval,'接口',1);
insert into tech_category values(tech_category_seq.nextval,'异常',1);
insert into tech_category values(tech_category_seq.nextval,'java.lang包',1);
insert into tech_category values(tech_category_seq.nextval,'java.util包',1);
insert into tech_category values(tech_category_seq.nextval,'java.io包',1);
insert into tech_category values(tech_category_seq.nextval,'内部类',1);
insert into tech_category values(tech_category_seq.nextval,'多线程',1);
insert into tech_category values(tech_category_seq.nextval,'Socket',1);
insert into tech_category values(tech_category_seq.nextval,'AWT/SWING',1);
commit;


--创建 试题表(单选题，多选,判断题) 序列


--drop table smd_questions;
--试题表(s:单选题，m:多选, d:判断题)
DROP TABLE IF EXISTS `smd_questions`;
CREATE TABLE `smd_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `question` varchar(256) NOT NULL COMMENT '题干',  
  `correct` varchar(256) NOT NULL COMMENT '考题答案', 
  `question_type` int(1) NOT NULL COMMENT '考题类型：1.单选  2.多选  3.判断',  
  `tech_cate_id` varchar(256) NOT NULL COMMENT '考题知识点分类ID', 
  `descrpt` varchar(256) NOT NULL COMMENT '考题说明信息',  
  `pubdate` timestamp COMMENT '出题时间', 
  PRIMARY KEY (`id`),
  KEY `idx_smd_questions` (`smd_questions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='知识点分类表';

-- select * from smd_questions

--创建 单选题选项 序列


--drop table smd_options;
--单选题选项表
DROP TABLE IF EXISTS `smd_options`;
CREATE TABLE `smd_options` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `option_A` varchar(256) NOT NULL COMMENT '选项A',  
  `option_B` varchar(256) NOT NULL COMMENT '选项B',
  `option_C` varchar(256) NOT NULL COMMENT '选项C',
  `option_D` varchar(256) NOT NULL COMMENT '选项D',
  `option_E` varchar(256) NOT NULL COMMENT '选项E',
  `question_id` varchar(256) NOT NULL COMMENT '外键，单选题', 
  PRIMARY KEY (`id`),
  KEY `idx_smd_options` (`smd_options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='单选题选项表';


--drop sequence fsp_questions_seq;
create sequence fsp_questions_seq
start with 1;

--drop table fsp_questions;
--试题表(填空题，简答题，编程题)

DROP TABLE IF EXISTS `fsp_questions`;
CREATE TABLE `fsp_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `question` varchar(2048) NOT NULL COMMENT '题干',  
  `std_answer` varchar(256) NOT NULL COMMENT '标准答案',
  `question_type` int(1) NOT NULL COMMENT '考题类型：4.填空  5.简答   6.编程题',
  `tech_cate_id` varchar(256) NOT NULL COMMENT '外键，考题知识点分类ID',
  `pubdate` timestamp NOT NULL COMMENT '出题时间',
  `descrpt` varchar(512) NOT NULL COMMENT '考题说明信息', 
  PRIMARY KEY (`id`),
  KEY `idx_fsp_questions` (`fsp_questions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试题表(填空题，简答题，编程题)';
 
--select * from fsp_questions
--drop table examination;
--考卷表

DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination` (
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号系统生成（考点简称+YYYYMMDD+班级号）',  
  `user_id` varchar(256) NOT NULL COMMENT '出题老师的编号',  
  `exam_date` timestamp NOT NULL COMMENT '出题时间',
  `single_id` varchar(256) NOT NULL COMMENT '所有单选题答题的题号，逗号分隔',
  `multiple_id` varchar(256) NOT NULL COMMENT '所有多选题答题的题号，逗号分隔',
  `true_false_id` varchar(256) NOT NULL COMMENT '所有判断题答题的题号，逗号分隔',
  `fill_in_gaps_id` varchar(256) NOT NULL COMMENT '所有填空题答题的题号，逗号分隔',
  `simple_anwser_id` varchar(256) NOT NULL COMMENT '所有简答题答题的题号，逗号分隔',
  `program_id` varchar(256) NOT NULL COMMENT '所有编程题答题的题号，逗号分隔',
  `descrpt` varchar(512) NOT NULL COMMENT '考题说明信息', 
  `valid_flag` int(1) NOT NULL COMMENT '试卷有效状态标识：1有效，0/空无效',
  PRIMARY KEY (`exam_no`),
  KEY `idx_examination` (`examination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='考卷表';


--select * from examination;
--select * from lqolts.examination
	 		where exam_no='XHDX25111104'
--学生答题表 序列

--drop table fsp_answer;
--(填空题，简答题，编程题)学生答题表

DROP TABLE IF EXISTS `fsp_answer`;
CREATE TABLE `fsp_answer` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `answer` varchar(256) NOT NULL COMMENT '答案',  
  `fsp_id` timestamp NOT NULL COMMENT '填空题，简答题，编程题的题号',
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号',
  `user_id` varchar(256) NOT NULL COMMENT '用户编号',
  PRIMARY KEY (`id`),
  KEY `idx_fsp_answer` (`fsp_answer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='(填空题，简答题，编程题)学生答题表';


--drop sequence olts_score_seq;
--创建成绩表 序列

--drop table olts_score;
--
create table olts_score(
    iscord integer not null primary key,
    score number(4,1), --成绩
    test_date date default sysdate,--考试时间
    descrpt varchar(50), --说明信息
    user_id not null references olts_users(id), --学生ID
    exam_no not null references examination(exam_no), --考试编号
    fsp_score NUMBER(4,1)
)

DROP TABLE IF EXISTS `olts_score`;
CREATE TABLE `olts_score` (
  `iscord` bigint(20) NOT NULL COMMENT 'ID',  
  `score` varchar(256) NOT NULL COMMENT '成绩',  
  `test_date` timestamp NOT NULL COMMENT '考试时间', 
  `descrpt` varchar(256) NOT NULL COMMENT '说明信息', 
  `user_id` timestamp NOT NULL COMMENT '学生ID',
  `exam_no` varchar(256) NOT NULL COMMENT '考试编号',
  `fsp_score` varchar(256) NOT NULL COMMENT '总分',
  PRIMARY KEY (`iscord`),
  KEY `idx_iscord` (`iscord`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='成绩表';


select *from olts_score;


insert into olts_score(ISCORD,SCORE,USER_ID,EXAM_NO) values(olts_score_seq.nextval,4.0,2,'XHDX25111104')


