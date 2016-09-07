FROM python:3.5-alpine
MAINTAINER maintainers@codeship.com

ENV \
  AWS_CLI_VERSION="1.10.62" \
  PIP_DISABLE_PIP_VERSION_CHECK=true

RUN \
  apk --no-cache add \
    bash \
    curl \
    jq \
    zip && \
  pip install awscli==${AWS_CLI_VERSION}

COPY scripts/ /usr/bin/
