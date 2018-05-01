#!/usr/bin/env bash

#############################################################################################
# Library of parameters and functions that can be sourced into any script.
#############################################################################################

#### Parameters #############################################################################
source /opt/pivotal/greenplum/variables.sh

DATA_DISK=$(ls -d /data[0-9] | awk 'END {print $NF}')
WORKSHOP_USER=gpuser
WORKSHOP_DB=$WORKSHOP_USER
PROVIDER=unknown


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
