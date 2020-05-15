create table tbl_bucket(
	b_id	INT	PRIMARY KEY	AUTO_INCREMENT,
	b_order	INT,
	b_content	VARCHAR(1000) NOT NULL,
	b_success	BOOLEAN	DEFAULT FALSE
);

select * from tbl_bucket;

select max(b_order) from tbl_bucket;

DELETE FROM tbl_bucket WHERE b_id = 14;

USE bucketdb;
ALTER TABLE tbl_bucket DROP INDEX b_order;
desc tbl_bucket;

delete from tbl_bucket;