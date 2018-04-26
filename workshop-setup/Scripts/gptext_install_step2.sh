#!/usr/bin/env bash

#############################################################################################
# Execute as the gpadmin user
#
# Start Zookeeper and GPText. Add schema to databases.
#############################################################################################

GPTEXT_ENV="/usr/local/greenplum-text/greenplum-text_path.sh"
if [[ ! -f $GPTEXT_ENV ]]; then
    echo Run gptext_install_step1.sh script before proceeding. Exiting.
    exit 1
fi

source $GPTEXT_ENV

WORKSHOP_USER=gpuser

# Check if zookeeper is running
zkManager state > /dev/null 2>&1
if [[ $? != 0 ]]; then
    echo "ZooKeeper does not appear to be running."
    echo "Let's try and start it"
    cmd="zkManager start"
    echo $cmd
    eval $cmd
    [[ $? != 0 ]] && { echo "Problems starting zkManager" ; exit 1; }
fi

# Installing GPText schema in the gpuser database
# Make sure it has been created first.

psql -l | grep $WORKSHOP_USER > /dev/null 2>&1
if [[ $? != 0 ]]; then
    echo "$WORKSHOP_USER database is not listed in 'psql -l' output"
    echo "Create the db before proceeding"
    exit 1
fi

gptext-installsql gpadmin
gptext-installsql $WORKSHOP_USER
gptext-start

psql -d $WORKSHOP_USER -e -c "GRANT USAGE ON SCHEMA gptext TO $WORKSHOP_USER"
psql -d $WORKSHOP_USER -e -c "GRANT SELECT ON gptext.gptext_envs TO $WORKSHOP_USER"
