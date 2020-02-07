use emsdb;

CREATE TABLE tbl_movie(
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    m_rank INT UNIQUE,
    m_title VARCHAR(125),
    m_detail_url VARCHAR(255),
    m_image_url VARCHAR(255)
);