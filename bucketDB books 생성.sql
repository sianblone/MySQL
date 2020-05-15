create schema bucketDB;

use bucketDB;

create user 'bucket'@'localhost' identified by 'bucket';
show grants for 'bucket'@'localhost';

grant all privileges on bucketDB.* to 'bucket'@'localhost';

flush privileges;

revoke all on bucketDB.* from 'bucket'@'localhost';

create schema books;
create user 'books'@'localhost' identified by 'books';
grant all privileges on books.* to 'books'@'localhost';
flush privileges;