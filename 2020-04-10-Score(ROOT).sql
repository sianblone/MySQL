create schema scoreDB;
create user 'score'@'localhost' identified by 'score';
grant all privileges on scoreDB.* to 'score'@'localhost';