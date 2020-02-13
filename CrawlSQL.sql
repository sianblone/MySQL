create table tbl_crawl(
c_id int auto_increment primary key,
c_site varchar(125),
c_board varchar(125),
c_bbsNo varchar(30),
c_date varchar(20),
c_hit int
);

select * from tbl_crawl;

select count(*) from tbl_crawl WHERE c_site = '롤인벤' and c_board = '실시간 유저 정보';
select sum(c_hit) from tbl_crawl where c_site= '롤인벤' and c_board = '자유게시판' and str_to_date(c_date, '%m-%d') >= str_to_date('10-01', '%m-%d') and str_to_date(c_date, '%m-%d') <= str_to_date('10-31', '%m-%d');

select * from tbl_crawl	ORDER by c_bbsNo desc LIMIT 10 OFFSET 10;
