if [ $USER != gpuser ]; then
   echo “You are $USER.  This script must be run as gpuser” 2>&1
   exit 1
fi

PSQL_CMD="psql -eE -d ${PGDATABASE:-gpuser} -f"

echo -e \\nCreate the staging and survey tables ...
$PSQL_CMD 01_create_survey_tbls.sql
read -p "Press enter to continue"

echo -e \\nLoad the staging table ...
$PSQL_CMD 02_load_stage_tbl.sql
read -p "Press enter to continue"

echo -e \\nLoad from the staging table to the survey table ...
$PSQL_CMD 03_load_from_staging.sql
read -p "Press enter to continue"

echo -e \\nRun a sample query ...
$PSQL_CMD 04_sample_query.sql
