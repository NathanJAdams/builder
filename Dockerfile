# To be used to build the final deployable images

FROM debian:buster-slim

RUN apt-get update \
 && apt-get install -y \
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
 && sudo su


# node, yarn, lerna, eslint-cli
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && apt-get install -y nodejs \
 && npm install -g yarn@1.22.10 \
 && yarn global add lerna@4.0.0 \
 && yarn global add eslint-cli@1.1.1


# aws-cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws \
 && rm awscliv2.zip


# docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
	| tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && apt-get install -y docker.io


ENTRYPOINT ["/bin/sh"]
