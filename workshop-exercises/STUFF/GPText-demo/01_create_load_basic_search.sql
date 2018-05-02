drop schema test cascade;
create schema test;
create table test.test_data(id bigint, data text) distributed by(id);
insert into test.test_data(id, data) values
(1, 'example gptext search functionality'),
(2, 'example gpuser is very simple to understand'),
(3, 'GPDB is a distributed mpp database'),
(4, 'Madlib is a distributed in database analytics engine'),
(5, 'Hdfs is a distributed system'),
(6, 'Cloud and big data is a trend'),
(7, 'Jason is very interested in cloud computing');

select gptext.create_index('test', 'test_data', 'id', 'data');
select * from gptext.index(table(select * from test.test_data), 'gpuser.test.test_data');
select gptext.commit_index('gpuser.test.test_data');

select t.id, t.score, t2.data from gptext.search(table(select 1 scatter by 1), 'gpuser.test.test_data', 'example', NULL, NULL) t, test.test_data t2 where t.id = t2.id::text;

select t.id, t.score, t2.data from gptext.search(table(select 1 scatter by 1), 'gpuser.test.test_data', 'distributed system', NULL, NULL) t, test.test_data t2 where t.id = t2.id::text;

select t.id, t.score, t2.data from gptext.search(table(select 1 scatter by 1), 'gpuser.test.test_data', 'cloud information distributed', NULL, NULL) t, test.test_data t2 where t.id = t2.id::text;

select gptext.drop_index('gpuser.test.test_data');
drop schema test cascade;
