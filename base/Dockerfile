FROM python:3.5-alpine
MAINTAINER maintainers@codeship.com

# which version of the AWS CLI to install.
# https://pypi.python.org/pypi/awscli
ARG AWS_CLI_VERSION="1.11.16"

ENV PIP_DISABLE_PIP_VERSION_CHECK=true

RUN \
  pip install awscli==${AWS_CLI_VERSION} && \
  mkdir -p "${HOME}/.aws"
