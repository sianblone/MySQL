use spboot;
SELECT * FROM tbl_users;
SELECT * FROM tbl_roles;

INSERT INTO tbl_roles(username, role_name)
VALUES ('admin','ROLE_ADMIN'), ('admin','ROLE_USER');

delete from tbl_roles;
delete from tbl_users;

drop table tbl_users;
drop table tbl_roles;

SELECT * FROM tbl_bbs;
SELECT count(*) FROM tbl_bbs;