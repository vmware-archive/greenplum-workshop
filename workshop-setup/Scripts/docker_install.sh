#!/usr/bin/env bash

#
# Move the /var/lib/docker directory to another location to ease the disk space
# crunch on the root volume.
# NOTE: Jon is working on increasing the root volume space in the AWS AMIs. When this
#       is completed, this relocation will not be necessary. However, we still would
#       want to add a docker group and add the gpadmin and gpuser accounts to that group.
#       This may not be needed for CentOS 7.
#

[[ $(id -ru) -ne 0 ]] && { echo Must be run by root; exit 1; }

rpm -iUvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum -y install docker-io
chkconfig docker on

# Move the docker stuff out of the root directory since it has limited space
# If you have a root filespace > 10GB, you may not need to do this.

NEWDIR=/data4/var-lib-docker

mkdir -p $NEWDIR
chown root:root $NEWDIR
chmod 700 $NEWDIR

service docker stop

mv /var/lib/docker $NEWDIR
[[ $? -ne 0 ]] && { echo "Problems moving docker dir. Exiting."; exit 1; }
ln -s $NEWDIR/docker /var/lib/docker

service docker start

# Add a docker group
groupadd docker
chgrp docker /var/run/docker.sock

# Add the gpadmin and gpuser users to the docker group
usermod  -aG docker gpadmin
usermod  -aG docker gpuser
