#!/bin/bash

[[ $(id -ru) -ne 0 ]] && { echo 'Must be run as root. Exiting'; exit 1; }
source /usr/local/greenplum-db/greenplum_path.sh

DEST=/data4/workshop-data/faa
mkdir -p $DEST

SRC=s3.amazonaws.com/greenplum-workshop-artifacts-mpresser
for yr in 2008 2009 2010
do
  for mnth in 1 2 3 4 5 6 7 8 9 10 11 12
  do
     FILE=On_Time_On_Time_Performance_${yr}_${mnth}.csv.bz2
     wget https://${SRC}/$FILE -O $DEST/$FILE
  done
done

for FILE in On_Time_On_Time_Performance_2011_1.csv.bz2 On_Time_On_Time_Performance_2011_2.csv.bz2 L_AIRLINE_ID.csv L_AIRPORTS.csv L_DISTANCE_GROUP_250.csv L_PILOTS.csv L_WORLD_AREA_CODES.csv L_ONTIME_DELAY_GROUPS.csv
do
   wget https://${SRC}/$FILE -O $DEST/$FILE
done

chown -R gpuser $(dirname $DEST)
chmod -R a+rw $(dirname $DEST)

su - gpuser -c "wget https://$SRC/Workshop_Exercises.tar -O /home/gpuser/Workshop_Exercises.tar"

su - gpuser -c "mkdir -p /home/gpuser/data"
su - gpuser -c "ln -s $DEST /home/gpuser/data/faa"

chown -R gpuser /home/gpuser
