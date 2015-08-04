# Meteor JS application server
# Version: 0.12.5-1nodesource1~trusty1 (with updates blocked to that version)
# 
# node.js vs io.js
# @see http://www.infoq.com/news/2015/05/nodejs-iojs
# 
# Meteor deployment
# @see http://docs.meteor.com/#/full/deploying
# 
FROM ubuntu:14.04
MAINTAINER Sébastien Leroy <Leroy.milamber@gmail.com>

# Install Node js 
# @see https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#debian-and-ubuntu-based-linux-distributions
# 
# NB: running all commands in one line to avoid spanwning multiple containers
# NB: do not specify full sub-version otherwise when going from 0.12.5 to 0.12.7 will not work ...
# 
RUN apt-get update && apt-get install -y curl build-essential python && \
  curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash - && \
  apt-get install -y nodejs && \
  echo "nodejs hold" | dpkg --set-selections


# where to store the data (host)
# 
VOLUME /data/app

# Some configuration parameters
# 
ENV APPNAME=app DB_CONTAINER_NAME=mjsMongoDB DB_AUTH=admin:admin PORT=3000


# some init & config scripts
# 
ADD init.sh /init.sh


# expose the port host:container
# 
EXPOSE 3000


# Start the dtabase
# 
CMD ["/init.sh"]
