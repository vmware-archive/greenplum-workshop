#!/usr/bin/env bash

#############################################################################################
# Executed by the gpadmin user.
#
# Configure an AWS Greenplum cluster for the Greenplum workshop.
# The following activites are performed in this script:
# - Create a directory for storing downloaded software packages.
# - Run gpupgrade. We modifiy it slightly to pull from a development
#    repository. Upgrades the cluster from GP 5.2 -> 5.7
# - Modify the pg_hba.conf file and reload changes or start up GP.
# - Adds the gpuser role and creates the gpuser database.
# - Download the Greenplum software packages used for this workshop.
# - Install MadLib, GPText, and PLContainer.
# - Restart Greenplum
#############################################################################################

[[ $(id -nu) != 'gpadmin' ]] && { echo 'Must be run as gpadmin. Exiting'; exit 1; }
source /usr/local/greenplum-db/greenplum_path.sh

WORKSHOP_USER=gpuser
WORKSHOP_DB=$WORKSHOP_USER
SOFTWARE=/data4/software

####################################################################
# Modify the Greenplum pg_hba.conf file
function modify_pghba() 
{
    PGHBA=$MASTER_DATA_DIRECTORY/pg_hba.conf
    cp ${PGHBA} ${PGHBA}.SAVED

    # Delete any 'catch-all entries. We have our own we will use.
    sed -i '/host[[:space:]]\+all[[:space:]]\+all[[:space:]]\+0.0.0.0\/0[[:space:]]\+.*/ d' ${PGHBA}
    sed -i '/host[[:space:]]\+all[[:space:]]\+all[[:space:]]\+::1/128[[:space:]]\+.*/ d' ${PGHBA}
    cat << _EOF >> ${PGHBA}
##### Entries below added by GPDB workshop ######
local   all    gpuser                ident
host    all    all      0.0.0.0/0    trust
host    all    all      ::1/128      trust
_EOF

    unset PGDATABASE PGUSER
    gpstate -q
    if [[ $? == 0 ]] ; then
       echo "GPDB: Reload pg_hba.conf changes"
       gpstop -u
    else
       echo "GPDB: Starting"
       gpstart -aq
       [[ $? -ne 0 ]] && { echo "Problems starting GPDB. Exiting." ; exit 1 ; }
    fi
}

####################################################################
# Add the workshop user (gpuser) role to Greenplum
function add_role_and_db()
{
    # Add the gpuser role to the db if it doesn't already exist
    psql -d postgres -ec "\du $WORKSHOP_USER" | grep $WORKSHOP_USER
    if [ $? -ne 0 ] ; then
        echo "Creating database role $WORKSHOP_USER"
            expect << _EOF
set timeout -1
spawn bash -l
match_max 10000
expect -exact "$ "
send -- "createuser --echo --pwprompt --login --no-createdb --no-superuser --no-createrole\r"
expect -exact "Enter name of role to add: "
send -- "$WORKSHOP_USER\r"
expect -exact "Enter password for new role: "
send -- "pivotal\r"
expect -exact "Enter it again: "
send -- "pivotal\r"
expect -exact "$ "
send -- "exit\r"
expect -exact "$ "
_EOF
    fi

    # Create the gpuser DB if it doesn't already exist
    dbname=$(psql -d postgres -Atc "select datname from pg_database where datname = '$WORKSHOP_DB'")
    if [[ x$dbname == "x" ]] ; then
        echo "Creating $WORKSHOP_DB database"
        psql -d postgres -e -c "create database $WORKSHOP_DB owner = $WORKSHOP_USER"
    else
        psql -d $WORKSHOP_DB -e -c "alter database $WORKSHOP_DB owner to $WORKSHOP_USER;"
    fi

    psql -d $WORKSHOP_DB -e -c "alter role $WORKSHOP_USER createexttable;"
}

####################################################################
# Download the Greenplum software packages used for this workshop
function download_software()
{
    FILES="plcontainer-1.1.0-rhel6-x86_64.gppkg greenplum-text-2.2.1-rhel6_x86_64.tar.gz plcontainer-python-images-1.1.0.tar.gz greenplum-cc-web-4.0.0-LINUX-x86_64.zip"
    for f in $FILES
    do
        wget https://s3.amazonaws.com/gp-demo-workshop/$f -O ${SOFTWARE}/$f
    done
}

####################################################################
# Install Madlib
function install_madlib()
{
    gppkg -i /opt/pivotal/greenplum/optional/pkg/madlib-1.13-gp5-rhel6-x86_64.gppkg

    # Install the madlib schema to the gpadmin and gpuser databases.
    master_host=$(hostname)
    for schema in gpadmin $WORKSHOP_USER
    do
            $GPHOME/madlib/bin/madpack install -s madlib -p greenplum -c gpadmin@$master_host:6432/${schema}
    done
    psql -d $WORKSHOP_DB -ec "grant all privileges on schema madlib to $WORKSHOP_USER;"
}

####################################################################
# Install GPText
function install_gptext()
{
    tar xvzf ${SOFTWARE}/greenplum-text-2.2.1-rhel6_x86_64.tar.gz -C ${SOFTWARE}
    ./Scripts/gptext_install_step1.sh
    ./Scripts/gptext_install_step2.sh
}

####################################################################
# Install PLContainer
function install_plcontainer()
{
    gppkg -i $SOFTWARE/plcontainer-1.1.0-rhel6-x86_64.gppkg
    plcontainer image-add -f $SOFTWARE/plcontainer-python-images-1.1.0.tar.gz
    plcontainer runtime-add -r plc_py -i pivotaldata/plcontainer_python_shared:devel -l python
    for db in gpadmin $WORKSHOP_DB
    do
        psql -d $db -e -c "create extension plcontainer"
    done
}

####################################################################
# Upgrade to latest release (5.7 as of Apr 2018)
function upgrade_gpdb()
{
    UPGRADE_SCRIPT=/usr/local/greenplum-aws/bin/gpupgrade.sh
    if [[ -x $UPGRADE_SCRIPT ]]; then
        sed -i 's?s3.amazonaws.com/pivotal-greenplum-bin?s3.amazonaws.com/pivotal-greenplum-dev?' $UPGRADE_SCRIPT
        [[ $? == 0 ]] && /usr/local/greenplum-aws/gpupgrade
    fi
}

####################################################################
# MAIN
####################################################################


[[ ! -d $SOFTWARE ]] && mkdir -p $SOFTWARE


upgrade_gpdb
modify_pghba
add_role_and_db
download_software

install_madlib
install_gptext
install_plcontainer

mv ./Scripts/cluster_st*.sh /home/gpadmin
# Restart the database to make sure all the changes take effect
gpstop -q -r -a -M fast
