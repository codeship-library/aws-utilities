FROM codeship/aws-base:latest
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

RUN \
  apk --no-cache add \
    bash \
    curl \
    jq \
    zip \
    python \
    python-dev \
    py-pip \
    && pip install virtualenv

# https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html#get-started-kubectl
ARG KUBECTL_VERSION="1.10.3"
ARG KUBECTL_BUILD_DATE="2018-06-05"
RUN curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${KUBECTL_BUILD_DATE}/bin/linux/amd64/kubectl > /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl
RUN curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${KUBECTL_BUILD_DATE}/bin/linux/amd64/heptio-authenticator-aws > /usr/local/bin/heptio-authenticator-aws \
  && chmod +x /usr/local/bin/heptio-authenticator-aws

RUN virtualenv root/.codeship-venv

ENV CODESHIP_VIRTUALENV="/root/.codeship-venv"

COPY scripts/ /usr/bin/
