psql -f 01_create_load_tbl.sql
read -p "Hit enter to continue"
psql -f 02_lag_lead.sql
read -p "Hit enter to continue"
psql -f 03_running_accumulations.sql
read -p "Hit enter to continue"
psql -f 04_running_avgs.sql
read -p "Hit enter to continue"
psql -f 05_multiple_partitions.sql
read -p "Hit enter to continue"
psql -f 06_avg_mp.sql
