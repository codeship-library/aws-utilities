FROM alpine:latest
MAINTAINER maintainers@codeship.com

RUN apk --update add \
    python \
    py-pip && \
  pip install awscli && \
  apk --purge del py-pip && \
  rm var/cache/apk/*

ONBUILD COPY . /app
ONBUILD WORKDIR /app
