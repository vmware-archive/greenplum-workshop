more README.md 
read -p "Press enter to continue"
psql -f 01_create_pilots_table.sql 
read -p "Press enter to continue"
sh -x  02_run_gpload.sh 
read -p "Press enter to continue"
psql -f 03_show_pilots_tables.sql 
read -p "Press enter to continue"
psql -f 04_decrypt_name.sql
read -p "Press enter to continue"
psql -f 05_datafile_info.sql 
cat 06_files_to_check.sql
psql -t  -f 06_files_to_check.sql | grep gpdata > files_to_check.txt
echo datafiles to check
cat files_to_check.txt
read -p "Press enter to continue"
sh -x ./07_files_to_check.sh
read -p "Press enter to continue"

