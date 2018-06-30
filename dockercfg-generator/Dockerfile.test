FROM alpine:3.8
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

RUN \
  echo "Hello ECR at $(date)" > hello.txt && \
  cat hello.txt

CMD ["cat hello.txt"]
