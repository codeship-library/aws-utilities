FROM alpine:latest
MAINTAINER maintainers@codeship.com

RUN apk --update add \
    python \
    py-pip \
    bash \
    zip && \
  pip install awscli && \
  apk --purge del py-pip && \
  rm var/cache/apk/*
