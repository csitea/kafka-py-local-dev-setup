#!/bin/bash

set -x

test -z ${MODULE:-} && MODULE=status-monitor-ui

HOME_NODE_MODULES_DIR=$HOME_PRODUCT_DIR/src/nodejs/${MODULE}/node_modules
NODE_MODULES_DIR=$PRODUCT_DIR/src/nodejs/${MODULE}/node_modules

test -d $NODE_MODULES_DIR && rm -rv $NODE_MODULES_DIR
cp -r $HOME_NODE_MODULES_DIR $NODE_MODULES_DIR

# installs depedencies and starts the server:
cd $HOME_PRODUCT_DIR/src/nodejs/${MODULE}


# do NOT run - break the CICD run - those are run during build time !!!
# # build the dist dir
# npm run build
npm install
npm run build

# start the web dev server
npm run serve


trap : TERM INT; sleep infinity & wait
