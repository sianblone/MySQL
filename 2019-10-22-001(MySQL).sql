-- MySQL 화면입니다
/*
MySQL과 Oracle의 차이점

MySQL		Oracle
Database	TABLESPACE

*/
use mySQL;
-- mySQL Database를 사용하겠다
-- mySQL에 포함된 table들을 사용하겠다

-- mySQL DB에 저장되어 있는 TABLE들의 전체 목록을 보여달라
show tables;

-- TABLESPACE처럼 데이터를 저장할 공간 설정
create database myDB;

-- 지금부터 myDB에서 사용하겠다
use myDB;
show tables;

-- auto_increment는 int형 PK에 설정한다
-- 정수형으로 1부터 일련번호를 자동으로 생성한다
-- mySQL의 정수형 데이터는 최대 11자리까지 저장
create table tbl_test(
		id int PRIMARY KEY auto_increment,
        name nVARCHAR(50) NOT NULL,
        tel VARCHAR(20),
        addr nVARCHAR(125)
);

desc tbl_test;

insert into tbl_test(id, name) values(0,'홍길동');
select * from tbl_test where id between 5 and 10;

select * from tbl_test where name like '홍%';

-- 단순 연산을 수행할 때 from을 포함하지 않아도 된다
select 30 + 40;
select '대한' & '민국';
select '대한' + '민국';