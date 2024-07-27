# Use Jenkins agent image with JDK 17
FROM jenkins/jenkins:2.452.3-jdk17

# Switch to root to install necessary packages
USER root

# Update package list and install required packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release


# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY plugins.txt ./

RUN jenkins-plugin-cli --plugins -f plugins.txt
