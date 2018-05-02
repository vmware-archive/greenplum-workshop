psql -f 01_create_bad_distro.sql
read -p "Press enter to continue"
psql -f 02_delay_from_Logan_skew.sql
read -p "Press enter to continue"
psql -f 03_table_skew.sql
read -p "Press enter to continue"
