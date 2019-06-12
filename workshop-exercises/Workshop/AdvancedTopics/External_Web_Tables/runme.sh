psql -f 01_create_quake_table.sql
read -p "press enter to continue"
sudo su gpadmin -c "source /usr/local/greenplum-db/greenplum_path.sh; PGPORT=6432 psql -d gpuser -f 02_create_ext_web_table.sql "
read -p "press enter to continue"
psql -f 03_insert_data.sql
read -p "press enter to continue"

