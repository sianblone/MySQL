use books;
create table tbl_user (
	userId	VARCHAR(20) PRIMARY KEY,
    password VARCHAR(125),
    userName VARCHAR(30),
    userRole VARCHAR(10)
);