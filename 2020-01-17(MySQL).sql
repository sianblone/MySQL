-- mysql에서는 사용자 등록시 접속경로를 설정하도록 되어있다
-- @'localhost'는 localhost에서만 접속할 수 있도록
create user 'iouser'@'localhost' identified by '1234';
grant all privileges on *.* to 'iouser'@'localhost';

-- @'%'는 모든 곳에서 원격, 로컬로 접속할 수 있다
create user 'iouser'@'%' identified by '1234';
grant all privileges on *.* to 'iouser'@'%';

-- IP 대역이 192.168.*.* 에서만 접속 허가
create user 'iouser'@'192.168.%' identified by '1234';
grant all privileges on *.* to 'iouser'@'192.168.%';




-- 2020-01-21
-- ems는 모든 곳에서 원격, 로컬로 접속할 수 있다
create user 'ems'@'%' identified by 'ems';
grant all privileges on *.* to 'ems'@'%';

-- schema DB 생성
create database emsDB;

use emsDB;
show tables;
desc tbl_ems;
select * from tbl_ems;