use community;
select * from authorities;
select * from tbl_users;
select * from tbl_board_info;
select * from tbl_board;
select * from tbl_category;
drop table tbl_category;
commit;

-- 외래키 삭제 후 칼럼 modify
alter table tbl_board drop foreign key FK_CATEGORY_BOARD_board_category;
alter table tbl_board modify board_category INT;
alter table tbl_category modify cate_id INT KEY AUTO_INCREMENT;
desc tbl_category;
-- 외래키 다시 추가
alter table tbl_board ADD CONSTRAINT FK_CATEGORY_BOARD_board_category FOREIGN KEY (board_category) REFERENCES tbl_category(cate_id);

drop table tbl_category;
drop table tbl_board;

SELECT b.*, bi.bi_name AS board_name
FROM tbl_board b
LEFT JOIN tbl_board_info bi
ON b.board_info = bi.bi_id
WHERE
b.board_info = 1
AND
b.board_p_no = 0
AND
b.board_delete = 0;