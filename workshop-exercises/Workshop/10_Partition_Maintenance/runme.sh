echo Start GPFDIST on port 8082
gpfdist -d $(pwd) -p 8082 > gpfdist.log 2>&1 &
GPFDistPID=$(echo $!)

read -p 'Create External Tables. Ready? ' answer
psql -f 01_create_ext_tbl.sql

read -p 'Exchange Partitions. Ready? ' answer
psql -f 02_exchange_parts.sql

read -p 'Now see what EXPLAIN has to say about our moved partition. Ready? ' answer
psql -f 03_run_explain.sql

read -p 'Show details on our partitions. Ready? ' answer
psql -f 04_show_partitions.sql

kill $GPFDistPID
