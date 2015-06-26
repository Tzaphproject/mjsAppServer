#!/bin/bash

cd /data/app
(cd programs/server && npm install)
node main.js
