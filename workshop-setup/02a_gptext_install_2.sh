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
    echo Run gptext_install_step1.sh script before proceeding. Exiting.
    exit 1
fi

source $GPTEXT_ENV

# Check if zookeeper is running
echo_eval "zkManager state > /dev/null 2>&1"
if [[ $? != 0 ]]; then
    echo "ZooKeeper does not appear to be running. Let's try and start it"
    echo_eval "zkManager start"
    [[ $? != 0 ]] && { echo "Problems starting zkManager" ; exit 1; }
fi

# Installing GPText schema in the gpuser database
# Make sure it has been created first.

echo_eval "psql -l | grep $WORKSHOP_USER > /dev/null 2>&1"
if [[ $? != 0 ]]; then
    echo "$WORKSHOP_USER database is not listed in 'psql -l' output"
    echo "Create the db before proceeding"
    exit 1
fi

echo_eval "gptext-installsql gpadmin"
echo_eval "gptext-installsql $WORKSHOP_USER"
echo_eval "gptext-start"

echo "psql -d $WORKSHOP_USER -e "
psql -d $WORKSHOP_USER -e  << _EOF
GRANT USAGE ON SCHEMA gptext TO $WORKSHOP_USER;
GRANT SELECT ON gptext.gptext_envs TO $WORKSHOP_USER;
GRANT SELECT ON public.plcontainer_show_config TO $WORKSHOP_USER;
GRANT SELECT ON public.plcontainer_refresh_config TO $WORKSHOP_USER;
_EOF
