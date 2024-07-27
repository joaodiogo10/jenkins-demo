
#!/bin/bash
set -x

rm "$(dirname $0)/ok"

set -e
CERT_PATH=$1
JENKINS_CONFIG_DIR=$2
JENKINS_HOME=$3

if [ -z "$CERT_PATH" ]; then
    CERT_PATH="./"
fi

if [ -z "$JENKINS_CONFIG_DIR" ]; then
    JENKINS_CONFIG_DIR="/var/jenkins_home/"
fi

if [ -z "$JENKINS_HOME" ]; then
    JENKINS_HOME="/var/jenkins_home/"
fi


if [ ! -d "$JENKINS_CONFIG_DIR" ]; then
    mkdir -p "$JENKINS_CONFIG_DIR"
fi

clientCert=$(cat $CERT_PATH/cert.pem)
serverCaCert=$(cat $CERT_PATH/ca.pem)
clientKey=$(cat $CERT_PATH/key.pem)

cp -rf ./_data/* $JENKINS_HOME

yq eval ".credentials.system.domainCredentials[0].credentials[0].x509ClientCert.clientCertificate = \"$clientCert\"" $JENKINS_CONFIG_DIR/jenkins.yaml -i
yq eval ".credentials.system.domainCredentials[0].credentials[0].x509ClientCert.clientKeySecret = \"$clientKey\"" $JENKINS_CONFIG_DIR/jenkins.yaml -i
yq eval ".credentials.system.domainCredentials[0].credentials[0].x509ClientCert.serverCaCertificate = \"$serverCaCert\"" $JENKINS_CONFIG_DIR/jenkins.yaml -i

echo "OK" > "$(dirname $0)/ok"
echo "jenkins.yaml update sucessfully"

exit 0