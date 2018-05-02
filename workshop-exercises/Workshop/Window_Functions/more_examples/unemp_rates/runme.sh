clear
psql -f 00_load_unemp.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f 01_show_tbl.sql
echo '--------------------------------------------------------------------------------'
echo
read -p "Hit enter to continue"
psql -f 02_update_tbl.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f 03_display_results.sql
