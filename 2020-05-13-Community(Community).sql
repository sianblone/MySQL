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

WITH RECURSIVE CTE AS (
    (SELECT board_no, board_p_no
	FROM tbl_board
	WHERE board_no = '35')
    UNION ALL
    (SELECT a.board_no, a.board_p_no
	FROM tbl_board a
	INNER JOIN CTE b ON a.board_p_no = b.board_no)
)
SELECT board_no, board_p_no FROM CTE;

use community;
DROP TABLE tbl_comment;
DROP TABLE tbl_board;
DROP TABLE tbl_category;
DROP TABLE tbl_board_info;
DROP TABLE authorities;
DROP TABLE tbl_users;
commit;











            
SELECT b.*, fnc.level
FROM (
	SELECT fnc_depth() AS board_no, @level AS level
	FROM (SELECT @start_with:=0, @board_no:=@start_with, @level:=0) AS vars
	JOIN tbl_board
    WHERE @board_no IS NOT NULL
    ) AS fnc
JOIN tbl_board AS b ON fnc.board_no = b.board_no;


SELECT
	(CASE WHEN level-1 > 0 then CONCAT(CONCAT(REPEAT('   ', level-1),'┗'), b.board_subject)
	ELSE b.board_subject
	END) AS board_subject
	, b.board_no
	, b.board_p_no
	, fnc.level
FROM
	(SELECT fnc_depth() AS board_no, @level AS level
	FROM (SELECT @start_with:=0, @board_no:=@start_with, @level:=0) vars
	JOIN tbl_board
	WHERE @board_no IS NOT NULL) fnc
JOIN tbl_board b ON fnc.board_no = b.board_no;