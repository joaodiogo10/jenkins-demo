FROM ubuntu:20.04

ARG CERT_PATH="/certs/client"
ARG JENKINS_CONFIG_DIR="/var/jenkins_home/casc_configs/"

ENV CERT_PATH=$CERT_PATH
ENV JENKINS_CONFIG_DIR=$JENKINS_CONFIG_DIR

# Install necessary tools
RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Download and install yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.11.2/yq_linux_amd64 -O /usr/bin/yq && \
    chmod +x /usr/bin/yq
    
RUN wget https://github.com/mikefarah/yq/releases/download/v4.11.2/yq_linux_amd64 -O /usr/bin/yq
RUN chmod +x /usr/bin/yq

RUN mkdir ./configuration

COPY ./configuration ./configuration

WORKDIR ./configuration

CMD ["sh", "-c", "./update-jenkins-config.sh ${CERT_PATH} ${JENKINS_CONFIG_DIR}"]
