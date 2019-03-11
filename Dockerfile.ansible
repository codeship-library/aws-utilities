FROM ubuntu:18.04

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends python-setuptools python-pip apt-transport-https ca-certificates wget rsync unzip jq zip curl && \
  pip install wheel && \
  pip install ansible==2.4.4.0 pyasn1==0.4.2 ndg-httpsclient==0.4.4 urllib3==1.22 pyOpenSSL==17.3.0 awscli

RUN mkdir /root/bin

COPY tasks /aws/tasks
COPY site.yml site.yml
COPY deployment /aws/deployment

RUN ansible-playbook -i localhost -c local site.yml

ENV PATH="/root/bin:${PATH}"
ENV CODESHIP_VIRTUALENV="/root/.codeship-venv"
