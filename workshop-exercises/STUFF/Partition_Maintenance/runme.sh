echo Start GPFDIST on port 8082
gpfdist -d $(pwd) -p 8082 > gpfdist.log 2>&1 &

read -p 'Create External Tables. Ready? ' answer
psql -f 01_create_ext_tbl.sql

read -p 'Exchange Partitions. Ready? ' answer
psql -f 02_exchange_parts.sql


echo Now see what EXPLAIN has to say about our moved partition
read -p 'Ready? ' answer
psql -f 03_run_explain.sql

read -p 'Ready? ' answer
psql -f 04_show_partitions.sql
