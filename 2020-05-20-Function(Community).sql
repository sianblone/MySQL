use community;

DROP FUNCTION IF EXISTS fnc_depth;
DELIMITER $$

CREATE FUNCTION fnc_depth() RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE v_no INT;
    DECLARE v_p_no INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @board_no = NULL;
    
    SET v_p_no = @board_no;
    SET v_no = -1;
    
    IF @board_no IS NULL THEN
		RETURN NULL;
	END IF;
    
    LOOP
    
	SELECT MIN(board_no)
	INTO @board_no
	FROM tbl_board
	WHERE board_p_no = v_p_no
		AND board_p_no > v_no;
	
    IF (@board_no IS NOT NULL) OR (v_p_no = @start_with) THEN
		SET @level = @level + 1;
	RETURN @board_no;
    END IF;
    
    SET @level := @level - 1;

    SELECT board_no, board_p_no
	INTO v_no , v_p_no
	FROM tbl_board
	WHERE board_no = v_p_no;
END LOOP;

END
$$
DELIMITER ;

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