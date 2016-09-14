FROM codeship/aws-base:latest
MAINTAINER maintainers@codeship.com

RUN \
  apk --no-cache add \
    bash \
    docker \
    jq

COPY aws_docker_creds.sh /

ENTRYPOINT ["/aws_docker_creds.sh"]
