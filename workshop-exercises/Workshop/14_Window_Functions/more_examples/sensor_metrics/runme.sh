clear
psql -f 01_create_tbls.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f 02_load_data.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f 03_create_date_trunc_udfs.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_first_cut.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_5min_increments.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_5_last_value.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_5_last_value2.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_avg.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -f q_avg2.sql
echo
read -p "Hit enter to continue"
echo '--------------------------------------------------------------------------------'
psql -v incr=10 -f q_xmin_incrs.sql
echo '--------------------------------------------------------------------------------'
