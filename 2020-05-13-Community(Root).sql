create schema community;
create user 'community'@'localhost' identified by 'community';
grant all privileges on community.* to 'community'@'localhost';