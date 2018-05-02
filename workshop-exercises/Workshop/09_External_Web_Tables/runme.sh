psql -f 01_create_quake_table.sql
read -p "press enter to continue"
sudo -i -u gpadmin /home/gpuser/Exercises/09_External_Web_Tables/02_create_ext_web_table.sh
read -p "press enter to continue"
psql -f 03_insert_data.sql
read -p "press enter to continue"

