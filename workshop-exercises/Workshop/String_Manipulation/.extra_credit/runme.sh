if [ $USER != gpuser ]; then
   echo “You are $USER.  This script must be run as gpuser” 2>&1
   exit 1
fi

gpfdist -d /home/gpuser/Exercises/String_Manipulation/.extra_credit -p 8081 > gpfdist.log 2>&1 &

[ -z $PGDATABASE ] && PGDATABASE=gpuser

PSQL_CMD="psql -eE -d $PGDATABASE "

echo -e "\nCreate the external table ..."
$PSQL_CMD -f create_tbl.sql
read -p "Press enter to continue"

echo -e "\Try reading from the external table ..."
$PSQL_CMD -c 'select * from public.ext_fixed_format limit 10'

killall gpfdist
