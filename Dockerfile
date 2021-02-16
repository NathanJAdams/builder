FROM node:erbium-buster-slim

# don't like updating first as it's not idempotent
# however it's only to install git and jq which should be stable
RUN apt-get update \
 && apt-get install -y git jq \
 && yarn global add lerna
 && yarn global add rimraf

ENTRYPOINT ["/bin/sh"]
