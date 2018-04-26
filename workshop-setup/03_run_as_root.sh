#!/usr/bin/env bash

#############################################################################################
# Executed by the root user.
#
# Configure an AWS Greenplum cluster for the Greenplum workshop.
# The following activites are performed in this script:
# - Create a $HOME/.psqlrc file for the gpuser account.
# - Download the FAA fact and dimension data files
#
# NOTE: Currently we are storing the data files in a subdirectory located in the
#       /data4 file system. We then create a soft link to the gpuser $HOME/data directory.
#       This was due to the root filesystem only having 6GB of disk space.
#       If this changes and the root filesystem has >= 20GB of disk space, this can be
#       simplified by storing the data files in the gpuser's data directory.
#############################################################################################

[[ $(id -ru) -ne 0 ]] && { echo 'Must be run as root. Exiting'; exit 1; }
source /usr/local/greenplum-db/greenplum_path.sh

#set -o errexit

PSQLRC='/home/gpuser/.psqlrc'
touch "$PSQLRC"
cat << _CMDS_ >> "$PSQLRC"
-- Added for GP workshop
\pset null NULL
\timing on
\set ECHO all
set search_path = faa, madlib, pg_catalog, gp_toolkit, public;
_CMDS_
chown gpuser $PSQLRC

SRC=https://s3.amazonaws.com/gp-demo-workshop
WORKSHOP_DATA=/data4/workshop-data/faa
mkdir -p $WORKSHOP_DATA

for yr in $(seq 2008 2010)
do
    for mnth in $(seq 1 12)
    do
        FILE=On_Time_On_Time_Performance_${yr}_${mnth}.csv.bz2
        wget ${SRC}/data/faa/$FILE -O $WORKSHOP_DATA/$FILE
    done
done

FACT_FILES="On_Time_On_Time_Performance_2011_1.csv.bz2 On_Time_On_Time_Performance_2011_2.csv.bz2"
DIM_FILES_1="L_AIRLINE_ID.csv L_AIRPORTS.csv L_DISTANCE_GROUP_250.csv"
DIM_FILES_2="L_PILOTS.csv L_WORLD_AREA_CODES.csv L_ONTIME_DELAY_GROUPS.csv"
for FILE in $FACT_FILES $DIM_FILES_1 $DIM_FILES_2
do
    wget ${SRC}/data/faa/$FILE -O $WORKSHOP_DATA/$FILE
done

chown -R gpuser $(dirname $WORKSHOP_DATA)
chmod -R a+rw $(dirname $WORKSHOP_DATA)

ExercisesTar="GP-Workshop-Exercises.tgz"
su - gpuser -c "wget $SRC/$ExercisesTar -O /home/gpuser/$ExercisesTar"
su - gpuser -c "cd /home/gpuser; tar xzf $ExercisesTar"

su - gpuser -c "mkdir -p /home/gpuser/data"
su - gpuser -c "ln -s $WORKSHOP_DATA /home/gpuser/data/faa"

# Move the recreate faa db script to gpuser's home directory. This script should really
# be added to the exercises tar bundle.
mv ./recreate_faa_db.sh /home/gpuser

chown -R gpuser /home/gpuser
