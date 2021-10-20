#!/bin/bash

set -e

echo 'AWS ECR dockercfg generator'

: "${AWS_REGION:?Need to set AWS_REGION}"
: "${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID}"
: "${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY}"

cat << EOF > ~/.aws/config
[default]
region = $AWS_REGION
EOF

# For multi account aws setups, use primary credentials to assume the role in
# the target account
AWS_ACCOUNT=""
if [[ -n $AWS_STS_ROLE || -n $AWS_STS_ACCOUNT ]]; then
  : "${AWS_STS_ROLE:?Need to set AWS_STS_ROLE}"
  : "${AWS_STS_ACCOUNT:?Need to set AWS_STS_ACCOUNT}"

  role="arn:aws:iam::${AWS_STS_ACCOUNT}:role/${AWS_STS_ROLE}"
  echo "Using STS to get credentials for ${role}"

  aws_tmp=$(mktemp -t aws-json-XXXXXX)

  aws sts assume-role --role-arn "${role}" --role-session-name aws_docker_creds > "${aws_tmp}"

  export AWS_ACCESS_KEY_ID=$(cat ${aws_tmp} | jq -r ".Credentials.AccessKeyId")
  export AWS_SECRET_ACCESS_KEY=$(cat ${aws_tmp} | jq -r ".Credentials.SecretAccessKey")
  export AWS_SESSION_TOKEN=$(cat ${aws_tmp} | jq -r ".Credentials.SessionToken")
  export AWS_SESSION_EXPIRATION=$(cat ${aws_tmp} | jq -r ".Credentials.Expiration")

  AWS_ACCOUNT=$AWS_STS_ACCOUNT
else
  AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r ".Account")
fi

# For public images stored in public.ecr.aws, we need to use a different CLI call
if [[ -v ECR_PUBLIC ]]; then
  SERVER=public.ecr.aws
  CREDS=$(aws ecr-public get-login-password --region=us-east-1)
else
  SERVER=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
  CREDS=$(aws ecr get-login-password --region=${AWS_REGION})
fi

# fetching aws docker login
# aws deprecated the get-login function in favor of get-login-password
# https://docs.aws.amazon.com/cli/latest/reference/ecr/get-login.html
echo "Logging into AWS ECR with account ${AWS_ACCOUNT}"
echo ${CREDS} | docker login --username AWS --password-stdin ${SERVER}

# writing aws docker creds to desired path
echo "Writing Docker creds to $1"
chmod 544 ~/.docker/config.json
cp ~/.docker/config.json $1
