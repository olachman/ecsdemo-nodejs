# FROM node:alpine
FROM alpine:3.6

# set the default NODE_ENV to production
# for dev/test build with: docker build --build-arg NODE=development .
# and the testing npms will be included
ARG NODE=production
ENV NODE_ENV ${NODE}

# copy package info early to install npms and delete npm command
WORKDIR /usr/src/app
COPY package*.json ./
RUN apk -U add nodejs nodejs-npm && \
  npm install && apk del --purge nodejs-npm && \
  rm -rvf /var/cache/* /root/.npm /tmp/*

# copy the code
COPY . .
EXPOSE 3000
CMD [ "node", "server.js" ]
