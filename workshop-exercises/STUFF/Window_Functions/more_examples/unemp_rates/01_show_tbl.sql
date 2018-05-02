\i ../00_init.sql

\set tblname unemp

select month, unrate from :tblname order by random() limit 20;
