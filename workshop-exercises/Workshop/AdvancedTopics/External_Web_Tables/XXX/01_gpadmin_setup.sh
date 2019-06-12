source $HOME/.bash_profile
cp $MASTER_DATA_DIRECTORY/pg_hba.conf $MASTER_DATA_DIRECTORY/pg_hba.SAVED_EWT
   echo "local    otherdb  gpuser   ident" >> $MASTER_DATA_DIRECTORY/pg_hba.conf 
tail -5 $MASTER_DATA_DIRECTORY/pg_hba.conf
createdb --echo --owner=gpuser otherdb
gpstop -u
