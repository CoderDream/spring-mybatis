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

/*
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word,user_type) 
       values(olts_users_seq.nextval,'999999999999999999','460200197801151393','james','james',1);
insert into olts_users(id,stu_no,id_card_no,user_name,pass_word) 
       values(olts_users_seq.nextval,'111111111111111111','460200197801151394','student','student');
commit;
*/



--drop sequence course_seq;
create sequence course_seq
start with 1;

--�γ̷���
create table courses(
       id integer not null primary key,
       course_name varchar2(20) not null
)
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


--drop sequence tech_category_seq;
create sequence tech_category_seq
start with 1;

--drop table tech_category cascade constraints;
--֪ʶ������
create table tech_category(
    id integer not null primary key,
    tech_ctgr varchar2(100) not null,
    course_id references courses(id)
)

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
create sequence smd_questions_seq
start with 1;

--drop table smd_questions;
--�����(s:��ѡ�⣬m:��ѡ, d:�ж���)
create table smd_questions(
    id integer not null primary key,  --����
    question varchar2(2000) not null,  --��� 
    correct VARCHAR2(5) not null,  --�����
    question_type integer not null check(question_type in(1,2,3)), --�������ͣ�1.��ѡ  2.��ѡ  3.�ж�
    tech_cate_id references tech_category(id), --����֪ʶ�����
    descrpt varchar(100),  --����˵����Ϣ
    pubdate date default sysdate --����ʱ��
    --code_body  VARCHAR2(1000)
)
select * from smd_questions

--���� ��ѡ��ѡ�� ����


--drop table smd_options;
--��ѡ��ѡ���
create table smd_options(
    id varchar2(32) not null primary key, --uuid
    option_A varchar(200) not null,
    option_B varchar(200) not null,
    option_C varchar(200) not null,
    option_D varchar(200) not null,
    option_E varchar(200),
    question_id unique references smd_questions(id) --�������ѡ��
)


--drop sequence fsp_questions_seq;
create sequence fsp_questions_seq
start with 1;

--drop table fsp_questions;
--�����(����⣬����⣬�����)
create table fsp_questions(
     id integer not null primary key,  	--����
     question varchar2(3000) not null,  --��� 
     std_answer clob, 	--��׼��
     question_type integer not null check(question_type in(4,5,6)), --�������ͣ�4.���  5.���   6.�����
     tech_cate_id references tech_category(id),--����֪ʶ�����
     pubdate date default sysdate, 	--����ʱ��
     descrpt varchar(500)  			--����˵����Ϣ
)
 
select * from fsp_questions
--drop table examination;
--�����
create table examination(
   exam_no varchar(20) not null primary key, --���Ա��ϵͳ���ɣ�������+YYYYMMDD+�༶�ţ�
   user_id references olts_users(id),        --������ʦ�ı��
   exam_date date, --����ʱ��
   single_id varchar2(500),           --���е�ѡ��������ţ����ŷָ�
   multiple_id varchar2(500),         --���ж�ѡ��������ţ����ŷָ�
   true_false_id varchar2(500),       --�����ж���������ţ����ŷָ�
   --���¼���Ϊ�����⣬����ϵͳ���
   fill_in_gaps_id varchar2(100),   --���������������ţ����ŷָ�
   simple_anwser_id varchar2(100),  --���м����������ţ����ŷָ�
   program_id varchar2(100),        --���б����������ţ����ŷָ�
   descrpt varchar(100),
   valid_flag integer --�Ծ���Ч״̬��ʶ��1��Ч��0/����Ч
)
select * from examination;
select * from lqolts.examination
	 		where exam_no='XHDX25111104'
--ѧ������� ����
create sequence fsp_answer_seq
start with 1;

--drop table fsp_answer;
--(����⣬����⣬�����)ѧ�������
create table fsp_answer(
    id integer not null primary key,
    answer clob,  --��
    fsp_id not null references fsp_questions(id), 		--����⣬����⣬���������
    exam_no not null references examination(exam_no), 	--���Ա��
    user_id not null references olts_users(id)          --�û����
)


--drop sequence olts_score_seq;
--�����ɼ��� ����
create sequence olts_score_seq
start with 1; 

--drop table olts_score;
--�ɼ���
create table olts_score(
    iscord integer not null primary key,
    score number(4,1), --�ɼ�
    test_date date default sysdate,--����ʱ��
    descrpt varchar(50), --˵����Ϣ
    user_id not null references olts_users(id), --ѧ��ID
    exam_no not null references examination(exam_no), --���Ա��
    fsp_score NUMBER(4,1)
)

select *from olts_score;


insert into olts_score(ISCORD,SCORE,USER_ID,EXAM_NO) values(olts_score_seq.nextval,4.0,2,'XHDX25111104')


