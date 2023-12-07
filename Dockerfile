FROM node:20

# install dependencies
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN mkdir -p /usr/src/app && cp -a /tmp/node_modules /usr/src/app
RUN npm i --unsafe-perm -g @angular/cli

# build the angular project
WORKDIR /usr/src/app
ADD . /usr/src/app
RUN cd /usr/src/app && npm run build

# start the server
EXPOSE 4000
CMD node --max-old-space-size=2048 dist/angular-sw-fetch/server/server.mjs
