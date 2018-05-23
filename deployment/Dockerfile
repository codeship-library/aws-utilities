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


# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl
ARG KUBECTL_VERSION="v1.9.0"
RUN curl -L "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" > /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN virtualenv root/.codeship-venv

ENV CODESHIP_VIRTUALENV="root/.codeship-venv"

COPY scripts/ /usr/bin/

