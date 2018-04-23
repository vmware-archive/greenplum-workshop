#!/usr/bin/env bash

[[ $(id -ru) -ne 0 ]] && { echo 'Must be run as root. Exiting'; exit 1; }

stack_name=$(curl http://169.254.169.254/latest/meta-data/iam/info 2>/dev/null | grep InstanceProfileArn | cut -d'/' -f2 | cut -d'-' -f1-3)

echo adduser gpuser -g users with password "_pivotal_conf_demo_"
adduser gpuser -g users 
echo "_pivotal_conf_demo_" | passwd gpuser --stdin

cat << _EOF >> /home/gpuser/.bashrc
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-text/greenplum-text_path.sh
export PGPORT=6432;   # connect directly to GP not pgbouncer
_EOF

cat << _EOF >> /home/gpuser/.bash_profile
export PS1="[\u@$stack_name \W]\\$ "
_EOF
cat << _EOF >> /home/gpadmin/.bash_profile
export PS1="[\u@$stack_name \W]\\$ "
_EOF

cat << _EOF > /etc/sudoers.d/91-gp-workshop-users
gpadmin ALL=(ALL)       NOPASSWD: ALL
gpuser  ALL=(ALL)       NOPASSWD: ALL
_EOF

sed -i -e 's/"#PasswordAuthentication no"/"PasswordAuthentication yes"/' /etc/ssh/sshd_config

service sshd restart

# Simple script to show the public IP for this host
cat << _EOF > /usr/local/bin/show-public-ip.sh
curl http://169.254.169.254/latest/meta-data/public-ipv4
echo
_EOF
chmod +x /usr/local/bin/show-public-ip.sh


sudo $PWD/Scripts/Software-install/docker_install.sh
