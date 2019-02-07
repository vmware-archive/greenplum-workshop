#!/usr/bin/env bash

#############################################################################################
# Execute as the gpadmin user
#
# Start Zookeeper and GPText. Add schema to databases.
#############################################################################################

source ./00_common_functions.sh

echo_eval "check_user gpadmin"

GPTEXT_ENV="/usr/local/greenplum-text/greenplum-text_path.sh"
if [[ ! -f $GPTEXT_ENV ]]; then
    echo "$0: Run 02a_gptext_install_1.sh script before proceeding. Exiting."
    exit 1
fi

source $GPTEXT_ENV

# Check if zookeeper is running
echo_eval "zkManager state > /dev/null 2>&1"
if [[ $? != 0 ]]; then
    echo "$0: ZooKeeper does not appear to be running. Let's try and start it"
    echo_eval "zkManager start"
    [[ $? != 0 ]] && { echo "$0: Problems starting zkManager" ; exit 1; }
fi

# Installing GPText schema in the gpuser database
# Make sure it has been created first.

echo_eval "psql -l | grep $WORKSHOP_USER > /dev/null 2>&1"
if [[ $? != 0 ]]; then
    echo "$0: $WORKSHOP_USER database is not listed in 'psql -l' output. Create the db before proceeding"
    echo "Execute as gpadmin >>  createdb $WORKSHOP_USER --owner $WORKSHOP_USER <<"
    exit 1
fi

echo_eval "gptext-installsql gpadmin $WORKSHOP_USER"
echo_eval "gptext-start"

echo "psql -d $WORKSHOP_USER -e "
psql -d $WORKSHOP_USER -e  << _EOF
GRANT USAGE ON SCHEMA gptext TO $WORKSHOP_USER;
GRANT SELECT ON gptext.gptext_envs TO $WORKSHOP_USER;
_EOF
