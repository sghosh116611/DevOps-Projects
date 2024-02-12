#!/bin/bash

##########
# Author: Soumojit Ghosh
# Date - 11th Feb 2024
#
# Version: v1
#
# This script will report the AWS resource usage
###########

#AWS S3
#AWS EC2
#AWS Lambda
#AWS IAM Users

#set -x
set -eo pipefail

# Lists the S3 buckets
echo "Printing List of S3 buckets"
aws s3 ls > resourceTracker

# Lists EC2 instances
echo "Printing list of ec2"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> resourceTracker

# Lists Lambda functions
echo "Printing list of Lambda"
aws lambda list-functions >> resourceTracker

# Lists IAM users
echo "Printing IAM users"
aws iam list-users | jq '.Users[].UserName' >> resourceTracker