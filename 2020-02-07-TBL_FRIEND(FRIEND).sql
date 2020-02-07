use frienddb;

create table tbl_hobby(
	hby_code	VARCHAR(8)	NOT NULL	PRIMARY KEY,
	hby_name	VARCHAR(20)		
);

create table tbl_friend(
	frd_id	BIGINT	AUTO_INCREMENT	Primary Key			,
	frd_name	VARCHAR(30)	NOT NULL				,
	frd_tel	VARCHAR(20)					,
	frd_addr	VARCHAR(125)			,		
	frd_hobby	VARCHAR(8)			,
	frd_rel	VARCHAR(30)				,
    Foreign Key	(frd_hobby)	REFERENCES tbl_hobby(hby_code) ON DELETE CASCADE
);

drop table tbl_hobby;
drop table tbl_friend;
-- ---------------------------------------------------------------------------------
create table tbl_friend(
	frd_id	BIGINT	AUTO_INCREMENT	Primary Key			,
	frd_name	VARCHAR(30)	NOT NULL				,
	frd_tel	VARCHAR(20)					,
	frd_addr	VARCHAR(125)			,		
	frd_hobby	VARCHAR(30)			,
	frd_rel	VARCHAR(30)				
);

desc tbl_friend;

create table tbl_member(
	m_id	VARCHAR(20)	NOT NULL	PRIMARY KEY,
	m_pw	VARCHAR(125)	NOT NULL	,
	m_name	VARCHAR(20)		,
	m_nick	VARCHAR(20)		
);