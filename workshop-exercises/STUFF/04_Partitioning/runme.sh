psql -f 01_create_week_partitioned_table.sql
read -p "Press enter to continue"
psql -f 02_load_week_partitioned_table.sql
read -p "Press enter to continue"
psql -f 03_show_week_partitions.sql
read -p "Press enter to continue"
psql -f 04_delay_from_Logan_week.sql
read -p "Press enter to continue"
psql -f 05_create_month_partitioned_table.sql
read -p "Press enter to continue"
psql -f 06_load_month_partitioned_table.sql
read -p "Press enter to continue"
psql -f 07_show_month_partitions.sql
read -p "Press enter to continue"
psql -f 08_delay_from_Logan_all.sql

