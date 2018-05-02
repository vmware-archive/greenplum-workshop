psql -f 01_create_load_basic_search.sql 
read -f "type enter to continue"
sh -x 02_setup_enron.sh
read -f "type enter to continue"
psql -f 03_basic_enron_search.sql 
read -f "type enter to continue"
psql -f 04_faceted_search.sql 
read -f "type enter to continue"
sh -x 99_teardown.sh
