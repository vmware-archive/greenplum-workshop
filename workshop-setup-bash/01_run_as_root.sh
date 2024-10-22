#!/usr/bin/env bash

#############################################################################################
# Execute as the root user
#
# Configure an AWS/GCP Greenplum cluster for the Greenplum workshop.
# The following activites are performed in this script:
# - Add the gpuser Linux account and set the user's password.
#    - Configure the .bashrc file for sourcing GP product environment scripts.
# - Sets the PS1 prompt for gpadmin and gpuser.
# - Add gpadmin to the sudoers file.
# - Turn on password authentication for ssh. This is so the gpuser account can login
#    without having to have SSH key. Restart sshd.
# - Installs several utilities in /usr/local/bin
# - Yum Installs:
#    - OpenJDK 1.8 Runtime: Required for GPText 2.2.1 or greater
#    - expect: Used by the 02_run_as_gpadmin.sh script
# - Execute the docker install script. This is currently specific to CentOS 6.9.
#############################################################################################

source ./00_common_functions.sh

echo_eval "check_user root"

####################################################################
# Add and configure the Linux user account for this workshop
function setup_workshop_user()
{
    # Create the linux account used for the workshop and set the password
    echo_eval "adduser $WORKSHOP_USER -g users"
    echo "_pivotal_conf_demo_" | passwd $WORKSHOP_USER --stdin

    # Add Greenplum db and text paths to user's bashrc
    cat << _EOF >> /home/$WORKSHOP_USER/.bashrc
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-text/greenplum-text_path.sh

# Bypass pgbouncer for this user and connect directly to GP
export PGPORT=${PGPORT:-6432}
_EOF
}

####################################################################
# Allow password authentication for ssh
function allow_pw_auth()
{
    # Turn on password authentication
    echo_eval "sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config"
    echo_eval "systemctl restart sshd.service"
}

####################################################################
# Install yum packages (if necessary)
function yum_installs()
{
    # Install OpenJDK 1.8 runtime
    yum list installed java-1.8.0* &> /dev/null
    [[ $? != 0 ]] && echo_eval "yum -q -y install java-1.8.0-openjdk.x86_64"

    # Install expect. Used in the 02_run_as_gpadmin.sh script.
    yum list installed expect* &> /dev/null
    [[ $? != 0 ]] && echo_eval "yum -q -y install expect"

    # Install m4. Used by MADLIB
    yum list installed m4* &> /dev/null
    [[ $? != 0 ]] && echo_eval "yum -q -y install m4"

    # Install sysstat utilities. Used in gpuser external web table exercises
    yum list installed sysstat &> /dev/null
    [[ $? != 0 ]] && echo_eval "yum -q -y install sysstat"
}

####################################################################
# Enable and start docker
function enable_docker()
{
    # Check if Docker is install and install if necessary
    yum list installed docker* &> /dev/null
    [[ $? != 0 ]] && echo_eval "yum -y install docker-io"

    echo_eval "systemctl enable docker.service"
    echo_eval "systemctl start docker.service"

    echo_eval "chmod o+rw /var/run/docker.sock"

    # Add the gpadmin and gpuser users to the docker group
    #echo_eval "usermod  -aG docker gpadmin"
    #echo_eval "usermod  -aG docker gpuser"
}

####################################################################
# MAIN
####################################################################

setup_workshop_user
add_to_sudoers "gpadmin"
allow_pw_auth
yum_installs
enable_docker
