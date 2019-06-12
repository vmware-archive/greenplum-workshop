#!/bin/bash -l

echo -e "\nLoad each of the dimension tables."
read -p "Hit enter to continue"
psql -f 01_copy_into_airlines.sql
psql -f 02_copy_into_airports.sql
psql -f 03_copy_into_delay_groups.sql
psql -f 04_copy_into_distance_groups.sql
psql -f 05_copy_into_wac.sql
psql -f 06_insert_into_cancellation_codes.sql

echo -e "\nNow we will load the fact table using gpfdist directly."
read -p "Hit enter to continue"
./start_gpfdist.sh
psql -c "truncate table faa.otp_load;"
psql -c "truncate table faa.load_errors;"
psql -f 07_load_otp_from_ext.sql
psql -f 08_load_into_fact_table.sql

echo -e "\nRun a check to verify statistics and another to check the skew on the fact table."
read -p "Hit enter to continue"
psql -f 20_check_tables.sql
read -p "Hit enter to continue"
psql -f 21_table_skew.sql

echo -e "\nRecreate the fact table with a better distribution."
read -p "Hit enter to continue"
psql -f 22_recreate_fact_table.sql
