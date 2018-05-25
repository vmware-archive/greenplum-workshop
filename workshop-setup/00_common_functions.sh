#!/usr/bin/env bash

#############################################################################################
# Library of parameters and functions that can be sourced into any script.
#############################################################################################

this_script=$BASH_SOURCE

#### Parameters #############################################################################
[[ $(id -un) != root ]] && source /usr/local/greenplum-db/greenplum_path.sh

if [ -r /opt/pivotal/greenplum/variables.sh ]; then
    source /opt/pivotal/greenplum/variables.sh
else
    # Set reasonable defaults for env variables
    CLUSTER_NAME=$(hostname -s)
fi

DATA_DISK=$(ls -d /data[0-9] | awk 'END {print $NF}')
if [[ -z $DATA_DISK ]]; then
    echo "$this_script: Set DATA_DISK in this script. This directory is used as the"
    echo " repository for the downloaded software and db data for the workshop."
    exit 1
fi

WORKSHOP_USER=gpuser
WORKSHOP_DB=$WORKSHOP_USER
PROVIDER=unknown

HOST_ALL="/home/gpadmin/all_hosts.txt"
if [[ ! -f $HOST_ALL ]]; then
    echo "$this_script: File '$HOST_ALL' not found. Create this file before continuing"
    exit 1
fi


#### Functions ##############################################################################
function echo_eval()
{
    echo "$@"
    eval "$@"
}

function check_user()
{
    [[ $(id -un) != $1 ]] && { echo "Must be run as $1."; return 1; } || return 0
}

function add_to_sudoers()
{
    ! id -un $1 2>/dev/null && { echo "Unknown user '$1'"; return 1; }

    # Add gpadmin and gpuser to the sudoers file
    SUDO_FILE='/etc/sudoers.d/91-gp-workshop-users'
    echo "$1 ALL=(ALL)       NOPASSWD: ALL" >> $SUDO_FILE
}

function set_cloud_platform()
{
    # Check and set the cloud platform we are running on.

    [[ -x /usr/local/bin/aws ]]    &&  PROVIDER=aws
    [[ -x /usr/local/bin/gcloud ]] &&  PROVIDER=gcp
    [[ -x /usr/local/bin/azure ]]  &&  PROVIDER=azure

}
