#!/bin/bash

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

#mkdir -p ~gpuser/data/faa
#chmod -R a+rx ~gpuser
#chown -R gpuser ~gpuser/data


su -l gpadmin -c "psql -d gpuser -c 'drop schema if exists faa cascade;'"
su -l gpadmin -c "psql -d gpuser -c 'create schema faa;'"

sh $PWD/get_gpuser_files.sh
