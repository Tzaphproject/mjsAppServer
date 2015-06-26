#!/bin/bash

export MONGO_URL=mongodb://${DB_AUTH}@${DB_CONTAINER_NAME}:27017/${APPNAME}

cd /data/app
(cd programs/server && npm install)
node main.js
