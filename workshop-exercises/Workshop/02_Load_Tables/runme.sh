#!/bin/bash -l

psql -f 01_copy_into_airlines.sql
read -p "Hit enter to continue"
psql -f 02_copy_into_airports.sql
read -p "Hit enter to continue"
psql -f 03_copy_into_delay_groups.sql
read -p "Hit enter to continue"
psql -f 04_copy_into_distance_groups.sql
read -p "Hit enter to continue"
psql -f 05_copy_into_wac.sql
read -p "Hit enter to continue"
psql -f 06_insert_into_cancellation_codes.sql

echo -e "\nNow we will load the fact table using gpfdist directly."
read -p "Hit enter to continue"
./start_gpfdist.sh
psql -c "truncate table faa.otp_load;"
psql -c "truncate table faa.load_errors;"
psql -f 07_load_otp_from_ext.sql
psql -f 08_load_into_fact_table.sql

read -p "Hit enter to continue"
psql -f 09_check_tables.sql
read -p "Hit enter to continue"
psql -f 10_table_skew.sql
read -p "Hit enter to continue"
psql -f 11_recreate_fact_table.sql
