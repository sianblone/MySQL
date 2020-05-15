CREATE SCHEMA myshop;
create user 'myshop'@'localhost' identified by 'myshop';
grant all privileges on myshop.* to 'myshop'@'localhost';