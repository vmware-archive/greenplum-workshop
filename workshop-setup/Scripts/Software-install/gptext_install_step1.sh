#!/bin/bash

# This script assumes all the install binaries are in the /opt/pivotal
# directory. If not, change the following path.
BIN_DIR=/data4/software
GPTEXT_INSTALL_BINARY='greenplum-text-2.2.1-rhel6_x86_64.bin'
JRE_INSTALLER=jre-8u151-linux-x64.rpm
HOST_ALL=/home/gpadmin/all_hosts.txt

single_node=false
[[ $(wc -l $HOST_ALL | cut -f1 -d ' ') == 1 ]] && single_node=true

psql -d template1 -c 'select 1' > /dev/null 2>&1
if [[ $? != 0 ]]; then
    echo GP does not appear to be running. Please check.
    exit 1
fi

# Verify version of java. If less than 1.8, use included JRE installer and install on all hosts
v=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
if [[ $v < 1.8 ]]; then
   CMD="sudo yum -y install /tmp/$JRE_INSTALLER"
   if $single_node; then
      cp $BIN_DIR/$JRE_INSTALLER /tmp
      eval "$CMD"
   else
      gpscp $BIN_DIR/$JRE_INSTALLER -f ${HOST_ALL} =:/tmp
      gpssh  -f ${HOST_ALL} -e "$CMD"
   fi
fi

# Install 'nc' and 'lsof' on all hosts for zookeeper
CMD="sudo yum -y install nc lsof"
if $single_node; then
   eval "$CMD"
else
   gpssh -f ${HOST_ALL} -e "$CMD"
fi

CMD="sudo chmod 777 /usr/local"
if $single_node; then
   echo "$CMD"
   eval "$CMD"
else
   gpssh -f ${HOST_ALL} -e "$CMD"
fi

rm -rf /usr/local/greenplum-text*
rm -rf /usr/local/greenplum-solr

BASHRC=$HOME/.bashrc
GPTEXT_ENV_PATH=/usr/local/greenplum-text/greenplum-text_path.sh

if ! $(grep $GPTEXT_ENV_PATH $BASHRC); then
   echo "source $GPTEXT_ENV_PATH" >> $BASHRC
fi

GPT_CFG=/tmp/gptext_config
cat << _EOF > $GPT_CFG
declare -a GPTEXT_HOSTS=(localhost)
#GPTEXT_HOSTS="ALLSEGHOSTS"
declare -a DATA_DIRECTORY=(/data1/gptext/primary /data1/gptext/primary)
JAVA_OPTS="-Xms1024M -Xmx2048M"
GPTEXT_PORT_BASE=18983
GP_MAX_PORT_LIMIT=28983
ZOO_CLUSTER="BINDING"
declare -a ZOO_HOSTS=(localhost localhost localhost)
ZOO_DATA_DIR="/data1/gptext/master/"
ZOO_GPTXTNODE="gptext"
ZOO_PORT_BASE=2188
ZOO_MAX_PORT_LIMIT=12188
_EOF

echo "You are now ready to install GPText."
cmd="echo -e 'yes\n\nyes\n' | MORE=-1000 ${BIN_DIR}/$GPTEXT_INSTALL_BINARY -c ${GPT_CFG}"
echo $cmd
eval $cmd

GPTEXT_VER=$(echo $GPTEXT_INSTALL_BINARY | cut -d'-' -f-3 --output-delimiter='-')
CMD="sudo ln -s /usr/local/$GPTEXT_VER /usr/local/greenplum-text"
if $single_node; then
   eval "$CMD"
else
   gpssh -f ${HOST_ALL} -e "$CMD"
fi

CMD="sudo chmod 755 /usr/local"
if $single_node; then
   eval "$CMD"
else
   gpssh -f ${HOST_ALL} -e "$CMD"
fi
