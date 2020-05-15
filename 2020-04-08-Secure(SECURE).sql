use secure;

-- users 테이블 생성
-- Spring Security 기본 테이블 이름 및 칼럼 이름
CREATE TABLE users (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	username VARCHAR(50) UNIQUE,
    password VARCHAR(125),
    enabled BOOLEAN DEFAULT true
);

-- 임의로 테이블 이름을 바꿔서 사용하기
CREATE TABLE tbl_users (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
	user_name VARCHAR(50) UNIQUE,
    user_pass VARCHAR(125),
    enabled BOOLEAN DEFAULT true
);

-- 로그인 한 유저의 권한들을 보관할 TABLE
CREATE TABLE authorities (
	id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    authority VARCHAR(50)
);
ALTER TABLE authorities ADD CONSTRAINT FK_users_auth FOREIGN KEY(username) references tbl_users(user_name) ON DELETE CASCADE;

-- INSERT INTO tbl_users(user_name, user_pass, enabled, email, phone, address)
-- values('admin', 'admin', true, 'a@a', '010-1111-1111', '서울특별시');
INSERT INTO authorities(username, authority)
values('admin', 'ADMIN');
INSERT INTO authorities(username, authority)
values('admin', 'ROLE_ADMIN');

-- INSERT INTO tbl_users(user_name, user_pass, enabled, email, phone, address)
-- values('user', 'user', true, 'u@u', '010-2222-2222', '서울특별시');
INSERT INTO authorities(username, authority)
values('user', 'USER');
INSERT INTO authorities(username, authority)
values('user', 'ROLE_USER');

use secure;
SELECT * FROM tbl_users;
SELECT * FROM authorities;

delete from authorities where not username in('admin','user');
delete from tbl_users where id > 10;
delete from tbl_users where id = 16;

commit;