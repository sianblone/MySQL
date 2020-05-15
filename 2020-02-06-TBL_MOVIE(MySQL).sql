use emsdb;

CREATE TABLE tbl_movie(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    m_rank INT UNIQUE,
    m_title VARCHAR(125),
    m_detail_url VARCHAR(255),
    m_image_url VARCHAR(255)
);

select * from tbl_movie;
select * from tbl_product;

drop table tbl_cart;
desc tbl_cart;

select * from tbl_cart;
SELECT P.p_code, P.p_name, C.username, C.p_oprice, C.p_qty FROM tbl_cart C LEFT JOIN tbl_product P ON C.p_code = P.p_code;

select * from users;

drop table tbl_boards;
select * from tbl_boards;
