#!/bin/bash

###########################################################################
# This script is run after installing the Greenplum binaries on all hosts
# and gpssh-exkeys has been run.
###########################################################################

if [[ ! -f /home/gpadmin/.ssh/id_rsa.pub ]]; then
    echo You have to run gpssh-exkeys first
    exit 1
fi

DIR_GPCFG=/home/gpadmin/gpconfigs
FILE_GPCFG=gpinitsystem_config
INITCFG=${DIR_GPCFG}/${FILE_GPCFG}
MASTER_HOST=$(hostname)
STANDBY_HOST=$(grep smdw /etc/hosts | cut -f2 -d ' ')
DATA_DIR=/data1
MASTER_DIRECTORY=${DATA_DIR}/master
PDIR=${DATA_DIR}/primary
DATA_DIRECTORY="$PDIR $PDIR $PDIR $PDIR"


grep "7.3" /etc/system-release > /dev/null 2>&1
if [[ $? == 0 ]]; then
    sudo yum install net-tools -y
    [[ -n $STANDBY_HOST ]] && ssh $STANDBY_HOST "sudo yum install net-tools -y"
fi

BASHRC=~/.bashrc
echo "source /usr/local/greenplum-db/greenplum_path.sh" >> $BASHRC
echo "export MASTER_DATA_DIRECTORY=$MASTER_DIRECTORY/gpseg-1" >> $BASHRC
[[ -n $STANDBY_HOST ]] && scp $BASHRC $STANDBY_HOST:
source $BASHRC

echo "Preparing $DIR_GPCFG"

mkdir -p $DIR_GPCFG
cp /usr/local/greenplum-db/docs/cli_help/gpconfigs/${FILE_GPCFG} ${DIR_GPCFG}/
grep sdw /etc/hosts | cut -f2 -d ' ' > ${DIR_GPCFG}/hostfile_gpinitsystem

chown gpadmin:gpadmin -R ${DIR_GPCFG}

for node in $MASTER_HOST $STANDBY_HOST
do
    gpssh -h $node -e "sudo mkdir -p $MASTER_DIRECTORY"
    gpssh -h $node -e "sudo chown -R gpadmin:gpadmin ${DATA_DIR}"
done

gpssh -f ${DIR_GPCFG}/hostfile_gpinitsystem -e "sudo mkdir -p $PDIR"
gpssh -f ${DIR_GPCFG}/hostfile_gpinitsystem -e "sudo chown -R gpadmin:gpadmin ${DATA_DIR}"

sed -i -r "s/MASTER_HOSTNAME=.*/MASTER_HOSTNAME=${MASTER_HOST}/"                                  ${INITCFG}

sed -i -r "s/#MACHINE_LIST_FILE/MACHINE_LIST_FILE/"                                               ${INITCFG}

sed -i -r "s| DATA_DIRECTORY=\(.*\)| DATA_DIRECTORY\=\(${DATA_DIRECTORY}\)|"                      ${INITCFG}

sed -i -r "s|MASTER_DIRECTORY=/data/master|MASTER_DIRECTORY=${MASTER_DIRECTORY}|"                 ${INITCFG}
echo "Running gpinitsystem"

if [[ -n $STANDBY_HOST ]]; then
    INIT_STANDBY=" -s $STANDBY_HOST"
else
    INIT_STANDBY=''
fi

gpinitsystem -a -c /home/gpadmin/gpconfigs/gpinitsystem_config $INIT_STANDBY

echo "End $0"
