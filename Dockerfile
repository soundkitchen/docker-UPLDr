FROM alpine:3.4

MAINTAINER Takanobu Izukawa "takanobu@izukawa.org"

RUN apk add nodejs --no-progress --no-cache

COPY www /var/www
WORKDIR /var/www
RUN npm install . && npm install coffee-script -g && npm cache clean
ENV NODE_ENV=production

EXPOSE 3000

ENTRYPOINT ["coffee", "app.coffee"]

