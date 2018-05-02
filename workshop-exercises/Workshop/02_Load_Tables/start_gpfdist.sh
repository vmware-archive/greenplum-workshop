gpfdist -d /home/gpuser/data/faa -p 8081 > gpfdist.log 2>&1 &
ps -ef | grep gpfdist | grep -v grep
