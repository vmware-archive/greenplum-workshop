source $HOME/.bash_profile
cp $MASTER_DATA_DIRECTORY/pg_hba.SAVED_EWT $MASTER_DATA_DIRECTORY/pg_hba.conf
dropdb --echo otherdb
gpstop -u
