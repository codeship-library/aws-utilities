FROM codeship/aws-base:latest
MAINTAINER maintainers@codeship.com

RUN \
  apk --no-cache add \
    bash \
    curl \
    jq \
    zip

COPY scripts/ /usr/bin/
