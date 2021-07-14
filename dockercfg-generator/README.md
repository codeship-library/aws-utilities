# Dockercfg Generation Service for AWS ECR

This container allows you to generate a temporary dockercfg using your AWS credentials
and writes it to a specified filename. Typical usage of this image would be to run it
with a volume attached, and write the dockercfg to that volume.

In order to export a dockercfg, the container needs access to a docker instance, so
you must mount a docker socket, or provide access to a docker host in some way.

```bash
$ cat aws_creds.env
AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
AWS_REGION=us-east-1
$ docker run -it -v /home/myuser/data:/opt/data --env-file=aws_creds.env -v /var/run/docker.sock:/var/run/docker.sock codeship/aws-ecr-dockercfg-generator /opt/data/aws.dockercfg
Logging into AWS ECR
WARNING: login credentials saved in /root/.docker/config.json
Login Succeeded
Writing Docker creds to /opt/data/aws.dockerccfg
$ cat /home/myuser/data/aws.dockercfg # file is available locally
```

As per AWS documentation, this dockercfg should be valid for 48 hours.

## Using with Codeship

Codeship supports using custom images to generate dockercfg files during the build process. To use this image to integrate with AWS ECR, simply define a entry in your services file for this image, and reference it from any steps or services which need to interact with ECR repositories with the `dockercfg_service` field. You'll also need to provide the following environment variables using an [encrypted env file](https://codeship.com/documentation/docker/encryption/):

* `AWS_REGION` - Your selected AWS Region, ensure this is a region supporting AWS ECR
* `AWS_ACCESS_KEY_ID` - Your AWS Access Key
* `AWS_SECRET_ACCESS_KEY` - Your AWS Access Secret

Optionally, you can also set the following variables to assume a role across accounts before generating the dockercfg:

* `AWS_STS_ROLE` - The AWS role to assume
* `AWS_STS_ACCOUNT` - The AWS account the role exists in

Here is an example of using and ECR Dockercfg generator to authenticate pushing an image.

```yaml
# codeship-services.yml
app:
  build:
    image: 874084658176.dkr.ecr.us-east-1.amazonaws.com/myorg/myapp
    dockerfile_path: ./Dockerfile
aws_dockercfg:
  image: codeship/aws-ecr-dockercfg-generator
  add_docker: true
  encrypted_env_file: aws.env.encrypted
```

```yaml
# codeship-steps.yml
- service: app
  type: push
  tag: master
  image_name: 874084658176.dkr.ecr.us-east-1.amazonaws.com/myorg/myapp
  registry: https://874084658176.dkr.ecr.us-east-1.amazonaws.com
  dockercfg_service: aws_dockercfg
```

You can also use this authentication to pull images, or use with caching, by defining the `dockercfg_service` field on groups of steps, or each individual step that pulls or pushes an image, or by adding the field to specific services.

## ECR - public vs private repositories

By default, this tool will generate docker configurations for pushing to an AWS ECR private registry, eg `123456789012.dkr.ecr.us-east-1.amazonaws.com/your-image`. These images are only visible within (I think) your AWS account via valid IAM users.

AWS recently released public [ECR public repositories](https://docs.aws.amazon.com/AmazonECR/latest/public/public-repositories.html), eg `public.ecr.aws/abcd1234/your-image` that uses a different API to get credentials. In order to generate credentials for a public ECR repository, set the `ECR_PUBLIC` environment variable. An example push would be:

```
# codeship-steps.yml
- service: app
  type: push
  tag: master
  image_name: public.ecr.aws/abcd1234/my-app
  registry: https://public.ecr.aws
  dockercfg_service: aws_dockercfg
```

## Troubleshooting

#### "No basic auth credentials" error on push
Make sure the registry entry in your steps does not contain a trailing slash.
