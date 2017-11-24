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


--�û���


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




--֪ʶ������


DROP TABLE IF EXISTS `tech_category`;
CREATE TABLE `tech_category` (
  `id` bigint(20) NOT NULL COMMENT 'ID',  
  `tech_ctgr` varchar(256) NOT NULL COMMENT '֪ʶ�����',  
  `course_id` varchar(256) NOT NULL COMMENT '�γ�ID', 
  PRIMARY KEY (`id`),
  KEY `idx_tech_category` (`tech_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='֪ʶ������';



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
DROP TABLE IF EXISTS `olts_score`;
CREATE TABLE `olts_score` (
  `iscord` bigint(20) NOT NULL COMMENT 'ID',  
  `score` double(4,1) NOT NULL COMMENT '�ɼ�',  
  `test_date` timestamp NOT NULL COMMENT '����ʱ��', 
  `descrpt` varchar(256) NOT NULL COMMENT '˵����Ϣ', 
  `user_id` timestamp NOT NULL COMMENT 'ѧ��ID',
  `exam_no` varchar(256) NOT NULL COMMENT '���Ա��',
  `fsp_score` double(4,1)  NOT NULL COMMENT '�ܷ�',
  PRIMARY KEY (`iscord`),
  KEY `idx_iscord` (`iscord`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='�ɼ���';




