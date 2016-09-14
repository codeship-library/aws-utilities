FROM codeship/aws-base:latest
MAINTAINER maintainers@codeship.com

# purposely split this up so layers can download in parallel
RUN \
  apk --no-cache add \
    bash \
    docker \
    jq

COPY aws_docker_creds.sh /

ENTRYPOINT ["/aws_docker_creds.sh"]
