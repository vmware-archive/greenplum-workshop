sudo -i -u gpadmin /home/gpuser/Exercises/ExternalWebTables/01_gpadmin_setup.sh
read -p "press enter to continue"
psql -d otherdb -f 02_create_new_table.sql
read -p "press enter to continue"
psql -d otherdb -f 03_copy_into_airports.sql
read -p "press enter to continue"
sudo -i -u gpadmin /home/gpuser/Exercises/ExternalWebTables/04_create_ext_web_table.sh
read -p "press enter to continue"
psql -d otherdb -f 05_show_airlines_table.sql
read -p "press enter to continue"
psql -d gpuser -f 06_delay_from_Logan.sql
read -p "press enter to continue"
psql -d gpuser -f 07_explain_delay_from_Logan.sql
sudo -i -u gpadmin /home/gpuser/Exercises/ExternalWebTables/07_gpadmin_cleanup.sh

