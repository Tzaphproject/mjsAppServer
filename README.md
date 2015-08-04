[![MIT](https://img.shields.io/github/license/mashape/apistatus.svg?style=plastic)](http://opensource.org/licenses/MIT) 
[![Status](https://img.shields.io/badge/maturity-under_dev-red.svg?style=plastic)]() 
[![Docker Stars](https://img.shields.io/docker/stars/tzaphkiel/mjsappserver.svg?style=plastic)](https://hub.docker.com/u/tzaphkiel/mjsappserver/) 
[![Docker Pulls](https://img.shields.io/docker/pulls/tzaphkiel/mjsappserver.svg?style=plastic)](https://hub.docker.com/u/tzaphkiel/mjsappserver/)

*Please note that this project is at a very early development stage.*

*I'll be testing, refining & updating it in the forthcoming days? weeks? months?*

# MeteorJS application server (NodeJS)
I have created this docker image as part of a multiple set I plan to use on my server. The plan is to deploy MeteorJS applications using docker containers on any server infrastructure allowing docker to run.

This particular image defines a MeteorJS environment starting the application found in the deployed to the data volume exposed.
This container could be used by individual MeteorJS application that link to a MongoDB container for their data store requirements.

The following port and data volume will be exposed (if -P or -p flag is used):

    # port  : 9080 (container)
    # volume: /data/app (container - bundle content of a meteor deploy) 

This image will make use of the container linking mechanism to connect to the mongo database for its data store.
It expects the following to be made available through environment variables or container naming:

    - APPNAME       :   name of the meteor application (used for MongoDB schema)
    - DB_AUTH       :   <username>:<password> (used to connect to MongoDB)

To use container linking, please read the docker guides or refer to the quick examples and descriptions done below.
The commands listed below will show you how to build the image, install it with host mappings (port & data volume mount point), control it, etc.

*All commands listed below should be ran as root (# prompt) or if ran as a normal user ($ prompt), pre-pended by sudo.*

# Image manipulation
## Building
Run the following command in the project's folder to build a new image if you have modified the scripts or Dockerfile:
The command line options will force cleanup afterwards and a complete re-build (so if we get the 0.12.5 being updated to 0.12.7 for example, we can actually see it !).

*NB: make sure you replace the username/imageName by your own if you are not a contributor.*

    # docker build --no-cache=true --rm=true -t tzaphkiel/mjsappserver .

## Upload
*This section is not available anymore as the project is built and uploaded automatically by Github with Docker hub. One can refer to the docker guides for reference if need be.*

## Installation
**using port publishing on the host:**

*(i.e.: the container has to be accessed by the host system not another container)*

    # docker run -d -p 8080:3000 --name mjsappserver -e AUTH="admin:admin" \
    -v /opt/mjsappserver/:/data/app tzaphkiel/mjsappserver

**Using container linking:**
*(i.e.: the container has only to be accessed by other docker containers)*

    # docker run -d --name mjsappserver -e AUTH="admin:admin" \ 
    -v /opt/mjsappserver/:/data/app --link mjsMongoDB:mjsMongoDB tzaphkiel/mjsappserver

Using this command above, the application container will see a *mjsMongoDB* /etc/hosts entry pointing to the MongoDB instance from the other container.

Please make sure your un-targz the archive built by *meteor deploy* and place the content of *bundle* in the */opt/mjsappserver/* path. This content will be picked-up by the *init.sh* script. It will launch the meteor application in the application containier which will connect to the linked MongoDB in the other database container.

*NB: this can (and will be) pushed even further, by not exposing a local volume but a container volume (later)*

## Post-installation
**Start**

    # docker start mjsappserver

**Stop**

    # docker stop mjsappserver

**Information**

    # docker inspect mjsappserver

# Miscellaneous
## Docker command aliases
Some useful aliases to manipulate docker:
    
    # if needed
    alias docker="sudo docker"
    # useful docker aliases
    alias d='docker'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias dp='docker port'
    alias ds='docker search'

## Interactive shell in image
__Warning__: if ran, the usual command starting the mongoDB (mongo.sh) will not be called.

    # docker run -t -i tzaphkiel/mjsappserver /bin/bash

