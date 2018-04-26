#!/usr/bin/env bash

#############################################################################################
# Execute as the root user
#
# Configure an AWS Greenplum cluster for the Greenplum workshop.
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

[[ $(id -ru) -ne 0 ]] && { echo 'Must be run as root. Exiting'; exit 1; }

####################################################################
# Add and configure the Linux user account for this workshop
function setup_workshop_user()
{
    # Create the linux account used for the workshop and set the password
    echo adduser gpuser -g users with password "_pivotal_conf_demo_"
    adduser gpuser -g users 
    echo "_pivotal_conf_demo_" | passwd gpuser --stdin

    # Add Greenplum db and text paths to gpuser's bashrc
    cat << _EOF >> /home/gpuser/.bashrc
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-text/greenplum-text_path.sh
export PGPORT=6432;   # connect directly to GP not pgbouncer
_EOF
}

####################################################################
# Set the PS1 prompt for Greenplum users
function set_prompts()
{
    # Set the PS1 prompt string to display the AWS Stack name instead of the hostname
    stack_name=$(/usr/local/bin/get-stack-name.sh)

    for user in gpuser gpadmin
    do
        cat << _EOF >> /home/$user/.bash_profile
export PS1="[\u@$stack_name \W]\\$ "
_EOF
    done
}

####################################################################
# Add the Greenplum users to sudoers
function modify_sudoers()
{
    # Add gpadmin and gpuser to the sudoers file
    SUDO_FILE='/etc/sudoers.d/91-gp-workshop-users'
    echo 'gpadmin ALL=(ALL)       NOPASSWD: ALL' >> $SUDO_FILE
    echo 'gpuser  ALL=(ALL)       NOPASSWD: ALL' >> $SUDO_FILE
}

####################################################################
# Allow password authentication for ssh
function allow_pw_auth()
{
    # Turn on password authentication
    sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    service sshd restart
}

####################################################################
# Install any utility scripts 
function install_scripts()
{
    # Download the Amazon's ec2-metadata utility
    wget http://s3.amazonaws.com/ec2metadata/ec2-metadata -O /usr/local/bin/ec2-metadata
    chmod +x /usr/local/bin/ec2-metadata

    # Script to display the public IP address of the GP master host
    cat << _EOF > /usr/local/bin/show-public-ip.sh
curl http://169.254.169.254/latest/meta-data/public-ipv4
echo

# An alternate way to retrieve this info via the ec2-metadata utility:
#  ec2-metadata --public-ipv4
_EOF
    chmod +x /usr/local/bin/show-public-ip.sh

    # Script to display the CloudFormation stack name
    cat << _EOF > /usr/local/bin/get-stack-name.sh
#!/bin/bash
# Don't use Greenplum's included python release
unset PYTHONPATH PYTHONHOME

REGION=\$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print \$4}')
INSTANCE_ID=\$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 describe-instances --instance-id \$INSTANCE_ID --query 'Reservations[*].Instances[*].Tags[?Key==\`aws:cloudformation:stack-name\`].Value' --region \$REGION --output text


# An alternate way to retrieve this info via the ec2-metadata utilty:
#  ec2-metadata --security-groups | cut -f 2 -d ' ' | cut -f 1-2 -d'-'
_EOF

    chmod +x /usr/local/bin/get-stack-name.sh
}

####################################################################
# Install yum packages
function yum_installs()
{
    # Install OpenJDK 1.8 runtime
    yum -q -y install java-1.8.0-openjdk.x86_64

    # Install expect. Used in the 02_run_as_gpadmin.sh script.
    yum -q -y install expect
}

####################################################################
# MAIN
####################################################################

setup_workshop_user
set_prompts
modify_sudoers
allow_pw_auth
install_scripts
yum_installs

# Install docker
sudo $PWD/Scripts/docker_install.sh

cat << _EOF
------ NOTE --------------------------------------------------------------
The gpadmin and gpuser accounts have been added to the 'docker' group.
At this point, you should log out and log back in so that the gpadmin user
can run docker commands.

After logging back in, proceed with running the numbered scripts starting
with 02_run_as_gpadmin.sh.
_EOF
