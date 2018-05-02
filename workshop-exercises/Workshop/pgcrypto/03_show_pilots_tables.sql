select * from faa.pilots where employeeid < 5500 limit 3;
\x on
select * from faa.pilots_encrypted where employeeid < 5500 limit 3;
\x off
