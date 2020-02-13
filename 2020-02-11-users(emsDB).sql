use emsdb;

insert into users(username, password, enabled)
values('admin', '{noop}admin', true);

insert into users(username, password, enabled)
values('user', '{noop}user', true);

insert into authorities(username, authority)
values('admin', 'ROLE_ADMIN');

insert into authorities(username, authority)
values('user', 'ROLE_USER');

delete from authorities;

select * from users;
select * from authorities;

commit;