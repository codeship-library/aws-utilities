FROM python:3.5-alpine
MAINTAINER maintainers@codeship.com

ENV \
  PIP_DISABLE_PIP_VERSION_CHECK=true

RUN \
  apk --no-cache add \
    bash \
    curl \
    jq \
    zip && \
  pip install awscli

COPY scripts/ /usr/bin/
