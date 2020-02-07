/*
	FK, 참조 무결성
	2개 이상의 테이블의 EQ JOIN을 실행했을 때
	원하는 모든 데이터가 보여진다는 보장
    
	- FK의 references로 설정되는 TABLE은 1:N의 관계로 설정된다 -
TABLE	SCORE				STUDENT
COLUMN	sc_num	sc_sub		st_num	st_name
		S001 	국어		S001	홍길동
		S001 	영어		S002	이몽룡
		S001 	수학		S003	성춘향
    
SCORE 테이블은 S001이 여러 개지만
STUDENT 테이블은 S001이 한개이다


테이블을 FK로 지정하여 참조 무결성 관계를 설정하려면
테이블을 생성할 때 MySQL의 경우 ENGINE 옵션을 추가해주는 것이 좋다
그리고 character 형도 통일시켜 주는 것이 좋다

FK로 설정하기 위해서 테이블간의 칼럼의 Type과 크기가 동일해야 한다
1:N일때 1에 해당하는 table의 칼럼은 반드시 PK로 선언해야 한다

create table tbl_test(
	column1	int	primary key,
    column2	varchar(5)	not null,
    column3 nvarchar(10) not null
) ENGINE = InnoDB character set='UTF=8';
*/

use mydb;
desc tbl_score2;
-- s_id		int(11)
-- s_std	varchar(5)
-- s_sub	varchar(5)
-- s_score	int(3)
-- s_rem	varchar(50)

desc tbl_sub;
-- sb_code	varchar(5)
-- sb_name	varchar(20)
-- sb_pro	varchar(20)

-- FK 삭제
alter table tbl_score2
drop foreign key fk_score2_sub;
-- 오라클에선 alter table 없이
-- drop constraint fk_score2_sub;

-- N의 테이블에 대해 ALTER를 수행하고
-- 1의 테이블을 references로 설정한다
alter table tbl_score2 add constraint FK_01
foreign key (s_sub)
references tbl_sub(sb_code);
-- tbl_score2와 tbl_sub을 FK로 설정했다
-- 참조 무결성 관계 설정

-- tbl_sub에 등록되지 않은 B0100 과목으로 성적을 입력하려고 시도하면
-- 참조 무결성 제약조건에 위반되어 에러가 발생한다

insert into tbl_score2(s_std, s_sub, s_score)
values ('S0002', 'B0500', 90);
-- tbl_sub에 해당 과목코드를 먼저 추가해야 한다

insert into tbl_sub(sb_code, sb_name)
values('B0100', '화학');

insert into tbl_score2(s_std, s_sub, s_score)
values ('S0002', 'B0100', 90);

select * from tbl_score2;
-- tbl_sub에 등록하고 tbl_score를 등록했는데 tbl_sub의 B0100 코드를 잘못 등록했을 경우
-- B0100이 아니라 B0005로 코드를 변경하고 싶다면
update tbl_sub set sb_code='B0005' where sb_code='B0100';
-- foriegn key -> references의 충분조건이므로(fk는 references의 부분집합)
-- 이미 FK인 tbl_score2의 s_sub 칼럼에 값이 존재한다면
-- REFERENCES인 tbl_sub의 sb_code에는 값이 반드시 있어야한다

alter table tbl_score2 drop foreign key fk_01;
-- 따라서 references 값을 변경하면 연결된 모든 Foreign Key값도 변경되도록 옵션을 줄 수 있다
alter table tbl_score2 add constraint fk_score2_sub foreign key (s_sub) references tbl_sub(sb_code)
on update cascade;

select * from tbl_sub;
-- sb_code	sb_name
-- B0100	화학
select * from tbl_score2;
-- s_std	s_sub
-- S0002	B0100

update tbl_sub set sb_code = 'B0005' where sb_code = 'B0100';

select * from tbl_sub;
-- sb_code	sb_name
-- B0005	화학
select * from tbl_score2;
-- s_std	s_sub
-- S0002	B0005

-- 자동으로 연결된 FK들이 업데이트 되었다
-- references 값을 삭제할 경우 자동으로 연결된 FK까지 삭제하고 싶을 경우 on delete cascade 옵션을 주면 된다
-- alter table tbl_score2 add constraint fk_score2_sub foreign key (s_sub) references tbl_sub(sb_code)
-- on update cascade on delete cascade;

-- on update cascade : 1의 테이블의 PK를 변경하면 N의 테이블의 연관된 칼럼 데이터를 자동으로 모두 변경한다
-- on delete cascade : 1의 테이블의 레코드를 삭제하면 N의 테이블의 연관된 모든 레코드를 삭제한다
-- on delete cascade는 references 값을 지울 경우 연관된 레코드가 전부 삭제되므로 사용할 거라면 신중해야 한다

-- FK 설정에서 ON UPDATE CASCADE와 ON DELETE CASCADE는 DB 설계 당시에 어떻게 정책을 수립하느냐에 따라 결정해서 사용하면 된다

-- MySQL DB사전으로부터 제약조건 List를 확인
select * from information_schema.table_constraints;
select * from information_schema.table_constraints where table_name = 'tbl_score2';