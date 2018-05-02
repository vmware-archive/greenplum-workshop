psql -f  01_create_fact_table_col.sql
read -p "Press enter to continue"
psql -f 02_create_fact_table_col_compress5.sql
read -p "Press enter to continue"
psql -f 03_create_fact_table_col_quicklz.sql
read -p "Press enter to continue"
psql -f 04_load_column_tables.sql
read -p "Press enter to continue"
psql -f 05_table_size_otp.sql
read -p "Press enter to continue"
psql -f 06_delay_from_Logan_col_all.sql
read -p "Press enter to continue"
psql -f 07_lots_of_cols.sql
read -p "Press enter to continue"
psql -f 08_few_cols.sql
