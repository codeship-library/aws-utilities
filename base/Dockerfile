FROM python:3.5-alpine
MAINTAINER maintainers@codeship.com

ENV \
  AWS_CLI_VERSION="1.10.64" \
  PIP_DISABLE_PIP_VERSION_CHECK=true

RUN \
  pip install awscli==${AWS_CLI_VERSION} && \
  mkdir -p "${HOME}/.aws"
