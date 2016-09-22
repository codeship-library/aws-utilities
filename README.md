# AWS related Docker images for Codeship Jet

## AWS Deployment

A Docker image with scripts to deploy to various AWS services, including S3, CodeDeploy and ElasticBeanstalk.

## AWS dockercfg Generator

This container allows you to generate a temporary dockercfg using your AWS credentials and writes it to a specified filename. Typical usage of this image would be to run it with a volume attached, and write the dockercfg to that volume.

See the [dockercfg-generator ReadMe](dockercfg-generator/README.md) for more details and usage instructions.

## Contributing

We are happy to hear your feedback. Please read our [contributing guidelines](CONTRIBUTING.md) and the [code of conduct](CODE_OF_CONDUCT.md) before you submit a pull request or open a ticket.

## License

see [LICENSE](LICENSE)
