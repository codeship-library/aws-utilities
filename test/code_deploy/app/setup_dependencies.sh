#!/bin/bash

set -e
set -x

pip install awscli
mkdir -p /tmp/botocore/data/aws/codedeploy/
cd /tmp/botocore/data/aws/codedeploy/
aws s3 cp s3://razorbill-us-east-1-prod-default-distribution/latest/2014-10-06.api.json .
export AWS_DATA_PATH=/tmp/botocore/data
aws s3 cp --recursive s3://razorbill-us-east-1-prod-default-distribution/latest .
pip uninstall awscli -y
ls -lA
pip install awscli-1.5.4.tar.gz
aws deploy list-applications
cd ~/clone
