-- DB 스키마 생성
create schema secure;

-- 사용자 생성
create user 'secure'@'localhost' identified by 'secure';

-- 권한 부여
grant all privileges on secure.* to 'secure'@'localhost';

use secure;
select * from tbl_users;