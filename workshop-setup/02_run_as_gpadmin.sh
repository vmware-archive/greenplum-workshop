#!/bin/bash -l

SFTWARE=/data4/software
[[ ! -d $SFTWARE ]] && mkdir -p $SFTWARE

./gpupgrade.sh

PGHBA=$MASTER_DATA_DIRECTORY/pg_hba.conf
cp ${PGHBA} ${PGHBA}.SAVED

grep -Eq 'host[[:space:]]+all[[:space:]]+all[[:space:]]+0.0.0.0/0[[:space:]]+trust' ${PGHBA}
if [ $? -ne 0 ]; then
cat << _EOF >> ${PGHBA}
##### Entries below added by GPDB or HDB workshop ######
local   all    gpuser                trust
host    all    all      0.0.0.0/0    trust
local    otherdb  gpuser   ident
_EOF
fi

unset PGDATABASE
unset PGUSER
echo "Is GPDB running?"
gpstate -b > /dev/null 2>&1
if [ $? -ne 0 ] ; then
   echo "Starting GPDB"
   gpstart -a > /dev/null 2>&1
   if [ $? -ne 0 ] ; then
      echo "Problems starting GPDB. Exiting."
      exit 1
   fi
else
   gpstop -u
fi

WKSHP_USER=gpuser
USER_DB=$WKSHP_USER

# Add the gpuser role to the db if it doesn't already exist
psql -d postgres -ec "\du $WKSHP_USER" | grep $WKSHP_USER
if [ $? -ne 0 ] ; then
  echo "Creating $WKSHP_USER"
  echo "NOTE: Set password to pivotal"
  createuser --echo --pwprompt --no-superuser --no-createrole --createdb --login --inherit $WKSHP_USER
fi

# Create the gpuser DB if it doesn't already exist
dbname=$(psql -d postgres -Atc "select datname from pg_database where datname = '$USER_DB'")
if [[ x$dbname == "x" ]] ; then
  echo "Creating $DB database"
  psql -d postgres -c "create database $USER_DB owner = $WKSHP_USER"
  echo "Creating otherdb database for external web table exercise"
  createdb --echo --owner=$WKSHP_USER otherdb
fi

psql -d $USER_DB -ec "alter database $USER_DB owner to $WKSHP_USER;"
psql -d $USER_DB -ec "alter role $WKSHP_USER createexttable;"

ln -s $PWD/Scripts /home/gpadmin/Scripts

# Download the GP software
./Scripts/Software-install/get_gp_files.sh

gppkg -i /opt/pivotal/greenplum/optional/pkg/madlib-1.13-gp5-rhel6-x86_64.gppkg

# install the schemas for madlib and gptext
master_hostname=$(hostname)
/usr/local/greenplum-db/madlib/bin/madpack install -s madlib -p greenplum -c gpadmin@$master_hostname:6432/gpadmin
/usr/local/greenplum-db/madlib/bin/madpack install -s madlib -p greenplum -c gpadmin@$master_hostname:6432/gpuser

psql -d $USER_DB -ec "grant all privileges on schema madlib to $WKSHP_USER;"

# install GPText

./Scripts/Software-install/gptext_install_step1.sh
./Scripts/Software-install/gptext_install_step2.sh

# Install PLContainer
gppkg -i $SFTWARE/plcontainer-1.1.0-rhel6-x86_64.gppkg
psql -d gpadmin -ec "create extension plcontainer"
psql -d $USER_DB -ec "create extension plcontainer"

./Scripts/Software-install/install_python.sh

# Restart the database to make sure all the changes take effect
gpstop -ra -M fast
