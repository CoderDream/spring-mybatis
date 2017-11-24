--������ռ�, ��ô�����oracle��װ��Ŀ¼�£����ⲻСɾ���ˡ�
create tablespace olts
datafile 'E:\app\datafiles\olts.dbf'
size 50M
autoextend on;


/*
�����û���Ϊ�û������ռ�
�´������û���ʼ��û�е�¼��Oracle��Ȩ�ޣ�Ҫ��ϵͳ����Աsys��lqolts��Ȩ
*/
create user lqolts
identified by olts
default tablespace olts;

grant connect,resource to lqolts;
--grant create table,create any view,create procedure to lqolts;

--�޸��û�����
--alter user lqolts identified by olts;

--ɾ���û�, cascade����ɾ�����û����������ݿ����
--drop user olts cascade;

-------------------------------------------------------------------------------------

--�����û��� ����
--drop sequence olts_users_seq;
create sequence olts_users_seq
start with 1;

--�û���
create table olts_users(
    id integer not null primary key,
    stu_no char(18),					 --ѧ�� 
    id_card_no char(18) not null unique, --���֤��
    user_name varchar(20) not null,  --�û���
    pass_word varchar2(10) not null, --����
    mobile varchar2(11), 			--�ֻ�
    home_tel varchar(12),			--��ͥ�绰
    home_addr varchar(50), 			--��ͥ��ַ
    sch_addr varchar(50), 			--ѧУ��ַ
    qq char(15),
    email varchar2(50),
    user_type number(2), 			--�û����ͣ�1.��ʦ�� 9.����Ա��ѧ��Ϊ�գ�
	gender varchar2(5),            	--�Ա�
    birthday date,                  --��������
    nation_place varchar2(20),      --����
    marjor varchar2(30),            --רҵ
    edu_Background varchar2(20),  	--���ѧ��
    graduate_School varchar2(20)	--��ҵԺУ
)

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for olts_users
-- ----------------------------
DROP TABLE IF EXISTS `olts_users`;
CREATE TABLE `olts_users` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `stu_no` varchar(256) NOT NULL COMMENT 'ѧ��',  
  `id_card_no` varchar(256) NOT NULL COMMENT '���֤��',
  `user_name` varchar(256) NOT NULL COMMENT '�û���',
  `pass_word` varchar(256) NOT NULL COMMENT '����',
  `mobile` varchar(256) NOT NULL COMMENT '�ֻ�',
  `home_tel` varchar(256) NOT NULL COMMENT '��ͥ�绰',
  `home_addr` varchar(256) NOT NULL COMMENT '��ͥ��ַ',
  `sch_addr` varchar(256) NOT NULL COMMENT 'ѧУ��ַ',
  `qq` varchar(256) NOT NULL COMMENT 'QQ',
  `email` varchar(256) NOT NULL COMMENT 'email',
  `user_type` varchar(256) NOT NULL COMMENT '�û����ͣ�1.��ʦ�� 9.����Ա��ѧ��Ϊ�գ�',
  `gender` varchar(256) NOT NULL COMMENT '�Ա�',
  `birthday` timestamp NOT NULL COMMENT '��������',
  `nation_place` varchar(256) NOT NULL COMMENT '����',
  `marjor` varchar(256) NOT NULL COMMENT 'רҵ',
  `edu_background` varchar(256) NOT NULL COMMENT '���ѧ��',
  `graduate_school` varchar(256) NOT NULL COMMENT '��ҵԺУ',
  PRIMARY KEY (`id`),
  KEY `idx_olts_users` (`olts_users`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�û���';

/*
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word,user_type) 
       values(olts_users_seq.nextval,'999999999999999999','460200197801151393','james','james',1);
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word) 
       values(olts_users_seq.nextval,'111111111111111111','460200197801151394','student','student');
commit;
*/


--�γ̷���

DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `course_name` varchar(256) NOT NULL COMMENT '�γ���',  
  PRIMARY KEY (`id`),
  KEY `idx_courses` (`courses`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�γ̷����';

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



--֪ʶ������


DROP TABLE IF EXISTS `tech_category`;
CREATE TABLE `tech_category` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `tech_ctgr` varchar(256) NOT NULL COMMENT '֪ʶ�����',  
  `course_id` varchar(256) NOT NULL COMMENT '�γ�ID', 
  PRIMARY KEY (`id`),
  KEY `idx_tech_category` (`tech_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='֪ʶ������';

insert into tech_category values(tech_category_seq.nextval,'��������',1);
insert into tech_category values(tech_category_seq.nextval,'�������������͡������',1);
insert into tech_category values(tech_category_seq.nextval,'�����ṹ��ѭ���ṹ��switch',1);
insert into tech_category values(tech_category_seq.nextval,'����',1);
insert into tech_category values(tech_category_seq.nextval,'���캯��',1);
insert into tech_category values(tech_category_seq.nextval,'����',1);
insert into tech_category values(tech_category_seq.nextval,'�������η�',1);
insert into tech_category values(tech_category_seq.nextval,'static���ؼ���',1);
insert into tech_category values(tech_category_seq.nextval,'��Ͷ��󡢰�',1);
insert into tech_category values(tech_category_seq.nextval,'�̳С������ࡢ��̬',1);
insert into tech_category values(tech_category_seq.nextval,'�ӿ�',1);
insert into tech_category values(tech_category_seq.nextval,'�쳣',1);
insert into tech_category values(tech_category_seq.nextval,'java.lang��',1);
insert into tech_category values(tech_category_seq.nextval,'java.util��',1);
insert into tech_category values(tech_category_seq.nextval,'java.io��',1);
insert into tech_category values(tech_category_seq.nextval,'�ڲ���',1);
insert into tech_category values(tech_category_seq.nextval,'���߳�',1);
insert into tech_category values(tech_category_seq.nextval,'Socket',1);
insert into tech_category values(tech_category_seq.nextval,'AWT/SWING',1);
commit;


--���� �����(��ѡ�⣬��ѡ,�ж���) ����


--drop table smd_questions;
--�����(s:��ѡ�⣬m:��ѡ, d:�ж���)
DROP TABLE IF EXISTS `smd_questions`;
CREATE TABLE `smd_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `question` varchar(256) NOT NULL COMMENT '���',  
  `correct` varchar(256) NOT NULL COMMENT '�����', 
  `question_type` int(1) NOT NULL COMMENT '�������ͣ�1.��ѡ  2.��ѡ  3.�ж�',  
  `tech_cate_id` varchar(256) NOT NULL COMMENT '����֪ʶ�����ID', 
  `descrpt` varchar(256) NOT NULL COMMENT '����˵����Ϣ',  
  `pubdate` timestamp COMMENT '����ʱ��', 
  PRIMARY KEY (`id`),
  KEY `idx_smd_questions` (`smd_questions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='֪ʶ������';

-- select * from smd_questions

--���� ��ѡ��ѡ�� ����


--drop table smd_options;
--��ѡ��ѡ���
DROP TABLE IF EXISTS `smd_options`;
CREATE TABLE `smd_options` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `option_A` varchar(256) NOT NULL COMMENT 'ѡ��A',  
  `option_B` varchar(256) NOT NULL COMMENT 'ѡ��B',
  `option_C` varchar(256) NOT NULL COMMENT 'ѡ��C',
  `option_D` varchar(256) NOT NULL COMMENT 'ѡ��D',
  `option_E` varchar(256) NOT NULL COMMENT 'ѡ��E',
  `question_id` varchar(256) NOT NULL COMMENT '�������ѡ��', 
  PRIMARY KEY (`id`),
  KEY `idx_smd_options` (`smd_options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='��ѡ��ѡ���';


--drop sequence fsp_questions_seq;
create sequence fsp_questions_seq
start with 1;

--drop table fsp_questions;
--�����(����⣬����⣬�����)

DROP TABLE IF EXISTS `fsp_questions`;
CREATE TABLE `fsp_questions` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `question` varchar(2048) NOT NULL COMMENT '���',  
  `std_answer` varchar(256) NOT NULL COMMENT '��׼��',
  `question_type` int(1) NOT NULL COMMENT '�������ͣ�4.���  5.���   6.�����',
  `tech_cate_id` varchar(256) NOT NULL COMMENT '���������֪ʶ�����ID',
  `pubdate` timestamp NOT NULL COMMENT '����ʱ��',
  `descrpt` varchar(512) NOT NULL COMMENT '����˵����Ϣ', 
  PRIMARY KEY (`id`),
  KEY `idx_fsp_questions` (`fsp_questions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����(����⣬����⣬�����)';
 
--select * from fsp_questions
--drop table examination;
--�����

DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination` (
  `exam_no` varchar(256) NOT NULL COMMENT '���Ա��ϵͳ���ɣ�������+YYYYMMDD+�༶�ţ�',  
  `user_id` varchar(256) NOT NULL COMMENT '������ʦ�ı��',  
  `exam_date` timestamp NOT NULL COMMENT '����ʱ��',
  `single_id` varchar(256) NOT NULL COMMENT '���е�ѡ��������ţ����ŷָ�',
  `multiple_id` varchar(256) NOT NULL COMMENT '���ж�ѡ��������ţ����ŷָ�',
  `true_false_id` varchar(256) NOT NULL COMMENT '�����ж���������ţ����ŷָ�',
  `fill_in_gaps_id` varchar(256) NOT NULL COMMENT '���������������ţ����ŷָ�',
  `simple_anwser_id` varchar(256) NOT NULL COMMENT '���м����������ţ����ŷָ�',
  `program_id` varchar(256) NOT NULL COMMENT '���б����������ţ����ŷָ�',
  `descrpt` varchar(512) NOT NULL COMMENT '����˵����Ϣ', 
  `valid_flag` int(1) NOT NULL COMMENT '�Ծ���Ч״̬��ʶ��1��Ч��0/����Ч',
  PRIMARY KEY (`exam_no`),
  KEY `idx_examination` (`examination`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�����';


--select * from examination;
--select * from lqolts.examination
	 		where exam_no='XHDX25111104'
--ѧ������� ����

--drop table fsp_answer;
--(����⣬����⣬�����)ѧ�������

DROP TABLE IF EXISTS `fsp_answer`;
CREATE TABLE `fsp_answer` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `answer` varchar(256) NOT NULL COMMENT '��',  
  `fsp_id` timestamp NOT NULL COMMENT '����⣬����⣬���������',
  `exam_no` varchar(256) NOT NULL COMMENT '���Ա��',
  `user_id` varchar(256) NOT NULL COMMENT '�û����',
  PRIMARY KEY (`id`),
  KEY `idx_fsp_answer` (`fsp_answer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='(����⣬����⣬�����)ѧ�������';


--drop sequence olts_score_seq;
--�����ɼ��� ����

--drop table olts_score;
--
create table olts_score(
    iscord integer not null primary key,
    score number(4,1), --�ɼ�
    test_date date default sysdate,--����ʱ��
    descrpt varchar(50), --˵����Ϣ
    user_id not null references olts_users(id), --ѧ��ID
    exam_no not null references examination(exam_no), --���Ա��
    fsp_score NUMBER(4,1)
)

DROP TABLE IF EXISTS `olts_score`;
CREATE TABLE `olts_score` (
  `iscord` bigint(20) NOT NULL COMMENT 'ID',  
  `score` varchar(256) NOT NULL COMMENT '�ɼ�',  
  `test_date` timestamp NOT NULL COMMENT '����ʱ��', 
  `descrpt` varchar(256) NOT NULL COMMENT '˵����Ϣ', 
  `user_id` timestamp NOT NULL COMMENT 'ѧ��ID',
  `exam_no` varchar(256) NOT NULL COMMENT '���Ա��',
  `fsp_score` varchar(256) NOT NULL COMMENT '�ܷ�',
  PRIMARY KEY (`iscord`),
  KEY `idx_iscord` (`iscord`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ɼ���';


select *from olts_score;


insert into olts_score(ISCORD,SCORE,USER_ID,EXAM_NO) values(olts_score_seq.nextval,4.0,2,'XHDX25111104')


