-- root 계정 비밀번호 분실 시
-- grant all 권한이 있는 id로 로그인하여 수정(grant all 사용자 미리 만들어두기)
alter user 'root'@'localhost' identified with mysql_native_password by '1234';

-- UTF-8
-- 원래는 1~4byte 이지만, 실제로 4byte 문자열은 거의 사용되지 않는 기본 다국어 평면(BMP) 바깥의 유니코드 문자이기에
-- MySQL에서는 공간절약+속도향상 등의 효율성을 위해 UTF-8을 가변 3byte(1~3byte)로 설계하였다 
-- 하지만 최근 나온 4byte 문자인 Emoji같은 문자열을 최대 3byte인 MySQL의 UTF-8에 저장하면 값이 손실되는 현상이 발생하여
-- MySQL에서 가변 4Byte utf-8 문자열을 저장할 수 있는 자료형을 추가하였다 => utf8mb4

-- MySQL8에서는 기본 문자열 인코딩이 UTF8mb4 방식으로 설정되어 varchar type의 칼럼에 문자열을 저장하면
-- 영문, 숫자등은 1개가 1byte, 기타 다국어는 1~4byte까지 자동 가변형으로 저장된다

use emsdb;
drop table tbl_bbs;

create table tbl_bbs (
	BBS_ID	BIGINT	AUTO_INCREMENT	Primary Key,
	BBS_P_ID	BIGINT	DEFAULT 0,
	BBS_WRITER	VARCHAR(3)	NOT NULL,
	BBS_DATE	VARCHAR(10),
	BBS_TIME	VARCHAR(10),
	BBS_SUBJECT	VARCHAR(125),	
	BBS_CONTENT	VARCHAR(1000),	
	BBS_COUNT	INT	DEFAULT 0
) charset=utf8;
insert into tbl_bbs(bbs_writer) values('대한민');
insert into tbl_bbs(bbs_writer) values('123');
insert into tbl_bbs(bbs_writer) values('대한민국');
insert into tbl_bbs(bbs_writer) values('1234');

-- MySQL에서 현재 DB Schema가 어떤 encoding인지 확인
SHOW SESSION VARIABLES LIKE 'collation_connection';

drop table tbl_bbs;
create table tbl_bbs (
	BBS_ID	BIGINT	AUTO_INCREMENT	Primary Key,
	BBS_P_ID	BIGINT	DEFAULT 0,
	BBS_WRITER	VARCHAR(50)	NOT NULL,
	BBS_DATE	VARCHAR(10),
	BBS_TIME	VARCHAR(10),
	BBS_SUBJECT	VARCHAR(125),	
	BBS_CONTENT	VARCHAR(1000),	
	BBS_COUNT	INT	DEFAULT 0
);

CREATE TABLE tbl_menu(
	MENU_ID	VARCHAR(3)	NOT NULL	PRIMARY KEY,
	MENU_P_ID	VARCHAR(3),
	MENU_TITLE	VARCHAR(10)	NOT NULL,
	MENU_HREF	VARCHAR(10)
);

INSERT INTO `emsdb`.`tbl_menu`
VALUES ('M01',null,'Home','/');

INSERT INTO `emsdb`.`tbl_menu`
VALUES ('M02',null,'관리자','#');
INSERT INTO `emsdb`.`tbl_menu`
VALUES ('M03','M02','로그인','#');
INSERT INTO `emsdb`.`tbl_menu`
VALUES ('M04','M02','회원가입','#');
INSERT INTO `emsdb`.`tbl_menu`
VALUES ('M05','M02','게시판정리','#');

select * from tbl_menu;

update tbl_menu set menu_p_id = null where menu_id in ('M01','M02');

select * from tbl_menu where menu_p_id = 'M02';