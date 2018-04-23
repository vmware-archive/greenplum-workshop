source /usr/local/greenplum-db/greenplum_path.sh

PYTHON_CONTAINER=/data4/software/plcontainer-python-images-1.1.0.tar.gz

plcontainer image-add -f $PYTHON_CONTAINER
plcontainer runtime-add -r plc_py -i pivotaldata/plcontainer_python_shared:devel -l python

exit

#####

Troubleshooting:
-----------------------------------------------------------------------------------
If you run into this error:
###########################
plcontainer image-add -f plcontainer-python-images-1.1.0.tar.gz
20180409:16:51:12:116725 plcontainer:ip-172-21-0-92:gpadmin-[INFO]:-Checking whether docker is installed on all hosts...
20180409:16:51:12:116725 plcontainer:ip-172-21-0-92:gpadmin-[INFO]:-Distributing image file plcontainer-python-images-1.1.0.tar.gz to all hosts...
20180409:16:51:16:116725 plcontainer:ip-172-21-0-92:gpadmin-[INFO]:-Loading image on all hosts...
20180409:16:51:16:116725 plcontainer:ip-172-21-0-92:gpadmin-[ERROR]:-error running command: docker load -i  /tmp/plcontainer-python-images-1.1.0.tar.gz
20180409:16:51:16:116725 plcontainer:ip-172-21-0-92:gpadmin-[CRITICAL]:-plcontainer failed. (Reason='error running command') exiting...
###########################

check the permissions of the /var/run/docker.sock file. If it is:
rw-rw--- root root
change it so that anyone in the docker group can access it:
chgrp docker /var/run/docker.sock
-----------------------------------------------------------------------------------
