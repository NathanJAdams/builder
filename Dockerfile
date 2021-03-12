# To be used to build the final deployable images

FROM debian:buster-slim

RUN apt-get update \
 && apt-get install -y \
	amazon-ecr-credential-helper \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	git \
	lsb-release \
	jq \
	software-properties-common \
	sudo \
	unzip \
 && sudo su \
# node, yarn, lerna
 && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g yarn@1.22.10 \
 && yarn global add lerna@4.0.0 \
# aws-cli
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && sudo ./aws/install \
 && rm -rf aws \
 && rm awscliv2.zip \
# docker
 && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && apt-get install -y docker


ENTRYPOINT ["/bin/sh"]
