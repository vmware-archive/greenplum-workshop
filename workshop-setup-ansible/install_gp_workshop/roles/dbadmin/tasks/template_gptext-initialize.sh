#!/usr/bin/env bash

#############################################################################################
# Execute as the gpadmin user
#
# Start Zookeeper and GPText. Add schema to databases.
#############################################################################################

#### Functions ################################################################
function echo_eval()
{
    echo "$@"
    eval "$@"
}

[[ $(id -un) != '{{gpadmin_user}}' ]] && { echo "Must be run as {{gpadmin_user}}."; exit 1; }

GPTEXT_ENV="/usr/local/greenplum-text/greenplum-text_path.sh"
if [[ ! -f $GPTEXT_ENV ]]; then
    echo "$0: GPText has not been installed. Exiting."
    exit 1
fi

source $GPTEXT_ENV

# Check if zookeeper is running
echo_eval "zkManager state &> /dev/null"
if [[ $? != 0 ]]; then
    echo "$0: ZooKeeper does not appear to be running. Let's try and start it"
    echo_eval "zkManager start"
    [[ $? != 0 ]] && { echo "$0: Problems starting zkManager" ; exit 1; }
fi

# Installing GPText schema in the {{gpuser}} database
# Make sure it has been created first.

echo_eval "psql -At -d {{gpuser}} -c 'select 1' &> /dev/null"
if [[ $? != 0 ]]; then
    echo "$0: {{gpuser}} database not found. Create the db before proceeding"
    echo "Execute as {{gpadmin_user}} >>  createdb {{gpuser}} --owner {{gpuser}} <<"
    exit 1
fi

echo_eval "gptext-installsql {{gpadmin_user}} {{gpuser}}"
echo_eval "gptext-start"

echo "psql -d {{gpuser}} -e "
psql -d {{gpuser}} -e  << _EOF
GRANT USAGE ON SCHEMA gptext TO {{gpuser}};
GRANT SELECT ON gptext.gptext_envs TO {{gpuser}};
_EOF
