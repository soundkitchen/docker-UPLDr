FROM ubuntu:trusty
MAINTAINER Takanobu Izukawa "takanobu@izukawa.org"

ENV DEBIAN_FRONTEND noninteractive

# we need aptitude! not apt!
RUN apt-get install -y aptitude
ADD /sources.list /etc/apt/sources.list
RUN aptitude update && aptitude safe-upgrade -y

# install common tools.
RUN aptitude install -y build-essential git

# install node js.
RUN aptitude install -y nodejs npm
WORKDIR /usr/bin
RUN ln -s nodejs node

ENV DEBIAN_FRONTEND dialog

# setup project.
ADD /www /var/www
WORKDIR /var/www
RUN npm install .
RUN npm install forever coffee-script -g
EXPOSE 3000

# wakeup server process.
CMD NODE_ENV=production forever -c coffee app.coffee

