use emsdb;
create table tbl_comment (
	CMT_ID	BIGINT	NOT NULL	PRIMARY KEY AUTO_INCREMENT,
	CMT_P_ID	BIGINT	default 0 NOT NULL,
	CMT_WRITER	VARCHAR(20)	NOT NULL,
	CMT_DATE	datetime default current_timestamp,
	CMT_TEXT	VARCHAR(400)
);
alter table tbl_comment modify cmt_id BIGINT AUTO_INCREMENT;
alter table tbl_comment modify cmt_p_id bigint default 0;
alter table tbl_comment modify cmt_date datetime default current_timestamp;
alter table tbl_comment drop column cmt_time;

select * from tbl_comment;