use community;
select * from tbl_users;
drop table tbl_users;
drop table authorities;
drop table tbl_board;

SELECT *, YEAR((SELECT age FROM tbl_users)) as year, MONTH((SELECT age FROM tbl_users)) as month, DAY((SELECT age FROM tbl_users)) as day
FROM tbl_users;

SELECT a.*, YEAR(b.age) as year, MONTH(b.age) as month, DAY(b.age) as day
FROM tbl_users as a JOIN tbl_users as b
ON a.id = b.id
WHERE b.username = 'ssss'
;

SELECT * FROM tbl_users;
SELECT * FROM authorities;
SELECT * FROM tbl_board;

SELECT b.*, u.nickname AS board_nickname
FROM tbl_board b, tbl_users u
WHERE
    b.board_writer = u.username
ORDER BY board_no DESC;

SELECT * FROM tbl_board WHERE board_p_no != '0';
SELECT * FROM tbl_users;

use community;
DROP TABLE tbl_comment;
DROP TABLE tbl_board;
DROP TABLE tbl_category;
DROP TABLE tbl_board_info;
DROP TABLE authorities;
DROP TABLE tbl_users;

SELECT * FROM tbl_users;
DELETE FROM tbl_users WHERE username = 'user';

SELECT * FROM tbl_board;

SELECT COUNT(*)
		FROM tbl_board
		WHERE
			board_info = 1
			AND
			board_delete = 0
			AND
			board_subject LIKE CONCAT('%', '1', '%');

SELECT * FROM tbl_category;
DELETE FROM tbl_category WHERE cate_id = 4;

select LAST_INSERT_ID() from tbl_board;

SELECT * FROM tbl_comment;