FROM node:12.20.1-alpine3.12

RUN apk add git jq \
 && npm install -g lerna

ENTRYPOINT ["/bin/sh"]
