# To be used to build the final deployable images

FROM node:erbium-buster-slim

# don't like updating first as it's not idempotent
# however it's only to install git and jq which should be stable
RUN apt-get update \
 && apt-get install -y curl unzip git jq \
 && yarn global add lerna@4.0.0 \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.30.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install \
 && rm -rf aws \
 && rm awscliv2.zip

ENTRYPOINT ["/bin/sh"]
