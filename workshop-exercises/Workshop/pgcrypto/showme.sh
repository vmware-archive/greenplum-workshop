more README.md 
read -p "Press enter to continue"

for x in 01_create_pilots_table.sql 02_run_gpload.sh  gpload_encrypt.yaml gpload.yaml 03_show_pilots_tables.sql 04_decrypt_name.sql 05_datafile_info.sql 06_files_to_check.sql  07_files_to_check.sh 
do 
   echo $x
   more $x
   read -p "Press enter to continue"
done

