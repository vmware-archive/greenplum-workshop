#!/usr/bin/env bash

#############################################################################################
# Execute as the root user
#
# Configure an AWS/GCP Greenplum cluster for the Greenplum workshop.
# The following activites are performed in this script:
# - Add the gpuser Linux account and set the user's password.
#    - Configure the .bashrc file for sourcing GP product environment scripts.
# - Sets the PS1 prompt for gpadmin and gpuser.
# - Adds gpadmin and gpuser to the sudoers file.
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
export PGPORT=${PGPORT:-5432}
_EOF
}

####################################################################
# Set the PS1 prompt for Greenplum users
function set_prompts()
{
    # Set the PS1 prompt string to display the AWS Stack name instead of the hostname
    CLUSTER_NAME=${CLUSTER_NAME:-$STACK}

    for user in $WORKSHOP_USER gpadmin
    do
        cat << _EOF >> /home/$user/.bash_profile
export PS1="[\u@${CLUSTER_NAME:-mdw} \W]\\$ "
_EOF
    done
}

####################################################################
# Allow password authentication for ssh
function allow_pw_auth()
{
    # Turn on password authentication
    echo_eval "sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config"
    echo_eval "service sshd restart"
}

####################################################################
# Install any utility scripts 
function install_scripts_aws()
{
    # Download the Amazon's ec2-metadata utility
    echo_eval "wget --quiet http://s3.amazonaws.com/ec2metadata/ec2-metadata -O /usr/local/bin/ec2-metadata"
    echo_eval "chmod +x /usr/local/bin/ec2-metadata"
}

####################################################################
# Install yum packages
function yum_installs()
{
    # Install OpenJDK 1.8 runtime
    echo_eval "yum -q -y install java-1.8.0-openjdk.x86_64"

    # Install expect. Used in the 02_run_as_gpadmin.sh script.
    # Install m4. Used by MADLIB
    echo_eval "yum -q -y install expect m4"
}

####################################################################
# MAIN
####################################################################

set_cloud_platform
setup_workshop_user
set_prompts
add_to_sudoers "gpadmin"
allow_pw_auth
[[ $PROVIDER == 'aws' ]] && install_scripts_aws
yum_installs

# Install docker
./01a_docker_install.sh

cat << _EOF
------ NOTE --------------------------------------------------------------
The gpadmin and gpuser accounts have been added to the 'docker' group.
At this point, you should log out and log back in so that the gpadmin user
can run docker commands.

After logging back in, proceed with running the numbered scripts:
    02_run_as_gpadmin.sh and 
    03_run_as_root.sh
_EOF
