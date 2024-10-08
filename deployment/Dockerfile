FROM codeship/aws-base:latest
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

RUN \
  apk --no-cache add \
    bash \
    curl \
    groff \
    jq \
    less \
    zip \
    python3 \
    python3-dev \
    py3-pip \
    && pip install virtualenv

# install kubectl from AWS
# https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html
ARG KUBECTL_VERSION="1.30.2"
ARG KUBECTL_BUILD_DATE="2024-07-12"

RUN curl -L https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${KUBECTL_BUILD_DATE}/bin/linux/amd64/kubectl > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

# install aws-iam-authenticator
RUN curl -L "https://amazon-eks.s3-us-west-2.amazonaws.com/${KUBECTL_VERSION}/${KUBECTL_BUILD_DATE}/bin/linux/amd64/aws-iam-authenticator" > /usr/local/bin/aws-iam-authenticator \
    && chmod +x /usr/local/bin/aws-iam-authenticator

RUN virtualenv root/.codeship-venv

ENV CODESHIP_VIRTUALENV="/root/.codeship-venv"

COPY scripts/ /usr/bin/
