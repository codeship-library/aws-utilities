# AWS related Docker images for Codeship Jet

## AWS Deployment

A Docker image with scripts to deploy to various AWS services, including S3, CodeDeploy and ElasticBeanstalk.

## AWS dockercfg Generator

This container allows you to generate a temporary dockercfg using your AWS credentials and writes it to a specified filename. Typical usage of this image would be to run it with a volume attached, and write the dockercfg to that volume.

See the [dockercfg-generator ReadMe](dockercfg-generator/README.md) for more details and usage instructions.

