#!/usr/bin/env bash

#-------------------------------------------------------------------------------------------
# Manage a test stack on AWS for developing Greenplum workshop scripts.
# AWS CLI commands expect the user to have properly populated 'config' and 'credentials'
# file in $HOME/.aws
# ----------------------------------------
# Usage: test_cluster.sh <create | delete>
#-------------------------------------------------------------------------------------------

set -e

profile="personal"
stack_name="gptest-workshop"
key_name="GPSummitWorkshop"
region="us-east-1"
az="us-east-1b"
count="1"
ClusterNodeInstanceType="r4.4xlarge-EBS-24TB"

function create_stack()
{
    aws cloudformation create-stack --stack-name $stack_name \
--profile $profile \
--template-body file:////$PWD/GPDB_CloudFormation_v2.2.json \
--parameters ParameterKey=KeyName,ParameterValue=$key_name \
ParameterKey=ClusterInstanceCount,ParameterValue=$count \
ParameterKey=ClusterNodeInstanceType,ParameterValue=$ClusterNodeInstanceType \
ParameterKey=AvailabilityZone,ParameterValue=$az \
ParameterKey=SSHLocation,ParameterValue="0.0.0.0/0" \
ParameterKey=CommandCenter,ParameterValue="Skip" \
ParameterKey=MADlib,ParameterValue="Skip" \
ParameterKey=PLR,ParameterValue="Skip" \
ParameterKey=PostGIS,ParameterValue="Skip" \
--region $region \
--capabilities CAPABILITY_IAM 

    cat << EE
-------------------------------------------------------------------------------------------
Execute the following after about 10-15 minutes to get the public IP address of the master:

aws cloudformation describe-stacks --profile $profile --stack-name '$stack_name' --query 'Stacks[0].Outputs[?OutputKey==\`MasterHost\`].OutputValue' --output text
-------------------------------------------------------------------------------------------
EE
}

function delete_stack()
{
    # First check if the stack exists
    FILTER="CREATE_COMPLETE ROLLBACK_COMPLETE"
    aws_stack_names=$(aws cloudformation list-stacks --profile $profile --stack-status-filter $FILTER --output text | awk '{print $4}')

    if $(echo $aws_stack_names | grep -q -w $stack_name); then
        cmd="aws cloudformation delete-stack --profile $profile --stack-name $stack_name --region $region"
        echo $cmd
        eval $cmd
    else
        echo "Unable to find stack '$stack_name' in AWS stacks '$aws_stack_names'"
    fi
}


##############################################################################
# Main
usage=$0' < create | delete >\nCreate/Delete a test cluster on AWS'
[[ $# != 1 ]] && { echo -e $usage; exit 0; }

case $1 in
    "create" ) create_stack
     ;;
    "delete" ) delete_stack
     ;;
    * ) echo -e 'Unknown option.\n'$usage
        exit
     ;;
esac
