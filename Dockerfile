FROM cimg/node:12.21

RUN yarn global add lerna@4.0.0

ENTRYPOINT ["/bin/bash"]
