FROM python:3.13-alpine
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

# which version of the AWS CLI to install.
# https://pypi.python.org/pypi/awscli
ARG AWS_CLI_VERSION="1.40.12"

ENV PIP_DISABLE_PIP_VERSION_CHECK=true

RUN \
  pip install awscli==${AWS_CLI_VERSION} && \
  mkdir -p "${HOME}/.aws"
