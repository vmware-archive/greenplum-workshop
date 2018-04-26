#!/bin/bash -l

source ~/.bashrc
[ $(id -un) != "gpuser" ] && { echo 'Must be run by gpuser.'; exit 1; }

echo "This script will drop the existing 'faa' schema if it exists."
read -n 1 -p "Proceed [y|N]? " ans

if [ "x$ans" = "xy" ] || [ "x$ans" = "xY" ]; then
    echo Proceeding ...
else
    echo Exiting ...
    exit 0
fi

# Extract the data if needed from the included compressed TAR file
[ ! -f ~/data/faa/L_AIRLINES.csv ] && { tar xvzf ./faa_data.tgz -C ~; }

p=$(find -L ~ -name '01_Create_Tables')
cd $(dirname $p)

psql -c 'drop schema if exists faa cascade'
psql -c 'create schema faa'

if [ $? -ne 0 ]
then
    echo Problem with creating the \'faa\' schema
    exit 1
fi

#########################################################################
# Create the faa schema tables
#
for sqlfile in ./01_Create_Tables/0[1-5]*.sql
do
    psql -f $sqlfile
done

#########################################################################
# Load the dimension tables
#
for sqlfile in ./02_Load_Tables/0[1-6]*.sql
do
    psql -f $sqlfile
done

#########################################################################
# Load the staging and production fact tables
#
gpload -v -f ./02_Load_Tables/gpload.yaml -l ./02_Load_Tables/gpload.log
sleep 2

psql -f ./02_Load_Tables/08_load_into_fact_table.sql
