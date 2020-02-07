-- root 사용자로 로그인이 된 상태
-- MySQL에서는 기본적으로 설치할 때 root 사용자가 활성화 된 상태이고
-- 일반적으로 MySQL Server가 원격에서 접속이 차단된 상태이므로
-- SQL 연습을 위해서 보통 그대로 사용한다
-- root 로그인 된 상태
-- workbench에서 접속을 클릭하여 열어놓은 화면
-- MySQL은 Schema 개념이 Database라는 것으로 집중된다
-- Oracle과 다른 점은 Oracle은 물리적 저장공간은 TableSpace로 설정되고
-- Data Schema는 사용자(User) ID를 생성하므로 논리적으로 설정된다
-- MySQL root(사용자)가 Schema 개념이 아니다
-- MySQL Database가 물리적(내부), 논리적(개념) Schema가 같은 의미로 사용된다

-- 1.login(root) 절차를 수행하고
-- 2. 사용할 Database(DB)를 open 수행해야 한다
-- 현재 사용 가능한 DB를 확인하는 명령들
show databases;

-- ---------------------------------------------------------------------------
-- 새로운 DB를 생성하는 명령
create database myDB_1;
-- 만약 오라클이라면
-- create database myDB_1 datafile 'a/b/c/d.dbf' size 10m autoextend on next 10k;
-- create user USERNAME identified by PASSWORD default database myDB_1;
-- grant dba to USERNAME;
-- 식으로 해줘야 할 것이다
-- ---------------------------------------------------------------------------
show databases;

-- DB open, DB 접속(오라클에서의 Tablespace 접속)
-- MySQL에서 DB(Tablespace)는 사용자와 연관성이 Oracle에 비해 느슨하다
-- 권한만 있으면 어떤 DB에도 접속하여 다양한 SQL 명령을 수행할 수 있다
use mydb;

-- 현재 접속한 DB에 포함된 table들을 확인하는 명령
-- mydb에 접속하였으므로 Tables_in_mydb가 표시된다
show tables;
select * from tbl_test;

create table tbl_score(
	s_id	INT		Primary Key	AUTO_INCREMENT,
	s_std	nvarchar(50)	not null,
	s_sub	nvarchar(50)	not null,
	s_score	INT(3)	not null,
	s_rem	nvarchar(50)
);

show tables;
desc tbl_score;
describe tbl_score;
select * from tbl_score;

insert into tbl_score(s_id, s_std, s_sub, s_score)
values(0, '홍길동', '국어', 90);
select * from tbl_score;

-- auto_increment로 설정된 칼럼은 PK로 지정되어 있더라도
-- insert를 수행할 때 0의 값을 지정해주면 자동으로 값을 1부터 생성하여 만들어준다
insert into tbl_score(s_std, s_sub, s_score)
values('홍길동', '수학', 80);
select * from tbl_score;

-- INT형 PK에 AUTO_INCREMENT가 지정되어 있더라도 0 이외의 값을 입력하면 지정한 값이 칼럼에 저장된다
-- 0으로 지정한다면 +1 값으로 저장된다
-- 만약 이미 있는 값으로 지정한다면 PK칼럼이기 때문에 값이 중복되어 오류가 발생한다
insert into tbl_score(s_id, s_std, s_sub, s_score)
values(2, '홍길동', '과학', 90);
select * from tbl_score;

-- AUTO_INCREMENT로 지정된 칼럼은 INT TYPE으로 지정해야한다
insert into tbl_score(s_id, s_std, s_sub, s_score)
values(200, '홍길동', '과학', 90);
select * from tbl_score;

insert into tbl_score(s_std, s_sub, s_score)
values('홍길동', '영어', 90);
select * from tbl_score;

-- 만약 이미 있는 값의 중간값으로 지정한다면(빠진 값을 입력한다면), 그 값으로 INSERT된다
insert into tbl_score(s_id, s_std, s_sub, s_score)
values(100, '홍길동', '100번', 90);
select * from tbl_score;

-- 그리고 다시 AUTO_INCREMENT 칼럼을 지정하지 않는다면
-- 기존의 최대값을 기준으로 1씩 증가하여 저장된다
insert into tbl_score(s_std, s_sub, s_score)
values('홍길동', '100번', 90);
select * from tbl_score;

-- 값들을 제거하더라도 기존 값을 재활용하지 않는다
delete from tbl_score where s_id >= 100;
select * from tbl_score;

insert into tbl_score(s_std, s_sub, s_score)
values('홍길동', '100번', 90);
select * from tbl_score;

-- 전부 지우고 0부터 시작하더라도 기존의 최대 값+1부터 시작하여 저장한다
delete from tbl_score where s_id >= 0;

insert into tbl_score(s_id, s_std, s_sub, s_score)
values(0,'홍길동', '100번', 90);
insert into tbl_score(s_std, s_sub, s_score)
values('홍길동', '100번', 90);
insert into tbl_score(s_id, s_std, s_sub, s_score)
values(0,'홍길동', '100번', 90);
select * from tbl_score;

-- MySQL에서 order by를 사용하지 않고 select를 수행하면 기본값으로 AUTO_INCREMENT로 설정된 PK 순서로 정렬하여 보여준다

-- ORDER BY는 실무에서 많은 table을 JOIN하거나 SUBQUERY를 사용하는 SQL을 작성할 때
-- ORDER BY는 최소한으로 사용하는 것이 좋다
-- DBMS마다 다양한 이슈들이 ORDER BY에서 나타난다
-- SELECT 결과가 ORDER BY를 수행하는 과정에서 딜레이가 발생하는 경우도 있다

select * from tbl_score where s_std = '홍길동';

-- s_std(학생이름)으로 그룹을 묶고, 그룹의 합계를 보여주기
select s_std, sum(s_score) from tbl_score group by s_std;


select s_std,
	(case when s_sub = '국어' then s_score else 0 end) as 국어,
    (case when s_sub = '수학' then s_score else 0 end) as 수학,
    (case when s_sub = '과학' then s_score else 0 end) as 과학
from tbl_score
group by s_std;

select s_std,
	if(s_sub = '국어', s_score, 0) as 국어,
    if(s_sub = '수학', s_score, 0) as 수학,
    if(s_sub = '과학', s_score, 0) as 과학
from tbl_score;

-- pivot 방식(행과 열을 바꿈)으로 표시
select * from tbl_score where s_std = '홍길동';
/*
	원래는 이름,과목명,과목점수 순으로 나열되어 있지만
    홍길동 국어 90
    홍길동 영어 95
    홍길동 수학 100
    이순신 국어 100
    이순신 영어 90
    이순신 수학 80
    
	이것을 이름1,과목1점수,과목2점수 순으로 나열하려고 한다
    홍길동 국어90 영어95 수학100
    이순신 국어100 영어90 수학80
    
    1. select 이름,국어,영어,수학 from 테이블; 로 형식 바꾸기
    
    s_std	국어	영어	수학
    홍길동	90		0		0
	홍길동	0		95		0
    홍길동	0		95		100
    1. group by로 같은 이름을 하나로 합치기
    2. group by로 합치면 레코드 중 하나를 랜덤으로 보여주기 때문에 sum으로 묶기
*/
-- 학생 이름으로 묶고, 과목별로 표시
select s_std,
	sum(if(s_sub = '국어', s_score, 0)) as 국어,
    sum(if(s_sub = '수학', s_score, 0)) as 수학,
    sum(if(s_sub = '과학', s_score, 0)) as 과학
from tbl_score
group by s_std;

-- ROUND : 반올림으로 소수점 자릿수 맞추기
-- ROUND(값), ROUND(값, 0) : 소수점이하에서 반올림
-- ROUND(값, a) : 소수이하 a자릿수까지 표시, 그 이하에서 반올림

-- TRUNCATE(값, 0) : 소수점이하 자르기
-- TRUNCATE(값, 1) : 소수점이하 1자리까지 표시, 그 이하에서 자르기
select s_std,
	sum(if(s_sub = '국어', s_score, 0)) as 국어,
    sum(if(s_sub = '수학', s_score, 0)) as 수학,
    sum(if(s_sub = '과학', s_score, 0)) as 과학,
    sum(s_score) as 총점,
    round(avg(s_score),0) as '평균(round,0)',
    truncate(avg(s_score),0) as '평균(truncate,0)'
from tbl_score
group by s_std;

-- s_id가 3인 데이터의 데이터 바꾸기
update tbl_score set s_score = 20 where s_id = 3;
delete from tbl_score where s_id = 3;

-- UPDATE, DELETE는 반드시 WHERE를 사용하자
-- 가급적 1개의 레코드를 대상으로 UPDATE, DELETE 수행
-- WHERE 조건으로 PK를 사용하는 SQL이 권장된다

create table tbl_score2 (
	s_id	INT		Primary Key	AUTO_INCREMENT,
	s_std	nvarchar(5)	not null,
	s_sub	nvarchar(5)	not null,
	s_score	INT(3)	not null,
	s_rem	nvarchar(50)
);

create table tbl_sub (
	sb_code	varchar(5)		Primary Key,
	sb_name	nvarchar(20)	Not Null,
	sb_pro	nvarchar(20)
);

show tables;

insert into tbl_score2(s_std, s_sub, s_score)
values('S0001','B0001',90);
insert into tbl_score2(s_std, s_sub, s_score)
values('S0001','B0002',85);
insert into tbl_score2(s_std, s_sub, s_score)
values('S0001','B0003',80);
insert into tbl_score2(s_std, s_sub, s_score)
values('S0001','B0004',95);

select * from tbl_score2;

insert into tbl_sub(sb_code, sb_name)
values('B0001','국어');
insert into tbl_sub(sb_code, sb_name)
values('B0002','수학');
insert into tbl_sub(sb_code, sb_name)
values('B0003','영어');
insert into tbl_sub(sb_code, sb_name)
values('B0004','과학');

select * from tbl_sub;

-- -------------------------------------------------------------------------------------------
-- EQ JOIN
select * from tbl_score2, tbl_sub;
-- tbl_score2의 모든 레코드와 tbl_sub의 1번 레코드를,
-- tbl_score2의 모든 레코드와 tbl_sub의 2번 레코드를,
-- tbl_score2의 모든 레코드와 tbl_sub의 3번 레코드를,
-- tbl_score2의 모든 레코드와 tbl_sub의 4번 레코드를 보여준다

select * from tbl_score2, tbl_sub where s_sub = sb_code;
-- tbl_score2의 레코드와 tbl_sub의 레코드 중 s_sub과 sb_code가 같은 경우만 보여준다

select s_id, s_std, sb_name, s_score from tbl_score2, tbl_sub where s_sub = sb_code;
-- tbl_score2의 레코드와 tbl_sub의 레코드 중 s_sub과 sb_code가 같은 경우 중
-- s_id, s_std, sb_name, s_score만 보여준다
-- -------------------------------------------------------------------------------------------
-- LEFT JOIN
-- table간에 참조 무결성이 보장되지 않을 경우 사용한다
-- => EQ JOIN을 했을 때 레코드가 누락될 수 있는 경우
select s_id, s_std, sb_name, s_score from tbl_score2 left join tbl_sub on s_sub = sb_code;

-- VIEW
-- 복잡한 SELECT QUERY를 하나의 TABLE처럼 보기 위하여 만드는 OBJECT이다
-- 읽기 전용이며 INSERT, UPDATE, DELETE가 불가능하다

-- FK 제약조건 설정
-- SCORE TABLE과 SUBJECT TABLE간에 참조 무결성 관계가 유지되고 있다
-- 참조 무결성이란 기본 키와 참조 키의 관계가 항상 유지됨을 보장한다
-- 참조 무결성을 제약조건으로 설정하기
-- 칼럼은 소괄호로 묶어줘야 한다
alter table tbl_score2
add constraint FK_score2_sub
foreign key (s_sub)
references tbl_sub(sb_code);

-- MySQL FK 칼럼 설정 조건
-- INT형 : NOT NULL DEFAULT = 0
-- 문자열형 : VARCHAR() NOT NULLtbl_score2

desc tbl_score2;
desc tbl_sub;

-- 설정된 FK 수행