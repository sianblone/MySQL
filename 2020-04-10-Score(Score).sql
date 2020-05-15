use scoreDB;

drop table tbl_student;
create table tbl_student(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	st_num VARCHAR(10),
    st_name VARCHAR(20),
    st_grade TINYINT,
    st_class TINYINT,
    UNIQUE KEY uk_num(st_num)
);

drop table tbl_score;
create table tbl_score(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	s_num VARCHAR(10),
    s_subject VARCHAR(20),
    s_score TINYINT,
    UNIQUE KEY uk_subject (s_num, s_subject)
);
ALTER TABLE tbl_score ADD CONSTRAINT fk_score_student FOREIGN KEY (s_num) REFERENCES tbl_student(st_num) ON DELETE CASCADE;

SELECT ST.st_num, ST.st_name, ST.st_grade, ST.st_class,
	SUM(CASE WHEN SC.s_subject ='국어' 
		THEN s_score ELSE 0 END) AS s_kor,
	SUM(CASE WHEN SC.s_subject ='영어' 
		THEN s_score ELSE 0 END) AS s_eng,
	SUM(CASE WHEN SC.s_subject ='수학' 
		THEN s_score ELSE 0 END) AS s_math
FROM tbl_student as ST, tbl_score as SC
WHERE ST.st_num = SC.s_num
GROUP BY st_num;
