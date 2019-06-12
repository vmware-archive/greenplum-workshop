sh -x 01_setup_enron.sh
read -p "type enter to continue"
psql -f 02_basic_enron_search_queries.sql 
read -p "type enter to continue"
psql -f 03_faceted_enron_search_queries.sql 
read -p "type enter to continue"
sh -x 99_teardown.sh
