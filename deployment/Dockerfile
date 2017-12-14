FROM codeship/aws-base:latest
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

RUN \
  apk --no-cache add \
    bash \
    curl \
    jq \
    zip \
    sudo

# https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-via-curl
ARG KUBECTL_VERSION="v1.8.5"
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN sudo mv ./kubectl /usr/local/bin/kubectl

COPY scripts/ /usr/bin/
