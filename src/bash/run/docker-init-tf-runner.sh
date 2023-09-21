#!/bin/bash

set -x

test -z ${PRODUCT:-} && PRODUCT=spe-prp-infra
test -z ${APPUSER:-} && APPUSER='appusr'

# /home/runner/work/${{ env.PRODUCT }}/${{ env.PRODUCT }}/opt/${{ env.ORG }}/${{ env.PRODUCT }}
# /home/appuser/home/runner/work/${{ env.PRODUCT }}/${{ env.PRODUCT }}/opt/${{ env.ORG }}/${{ env.PRODUCT }}
PRODUCT_DIR=$(echo $PRODUCT_DIR|perl -ne "s|/home/$APPUSR||g;print")
BASE_DIR=$(echo $BASE_DIR|perl -ne "s|/home/$APPUSR||g;print")

# test -d $venv_path && sudo rm -r $venv_path
# do not use this one ^^^^!!! Big GOTCHA !!!


cd ${PRODUCT_DIR} || exit 1

# spe-2880 - oherwise the CNF_VER git hash fetch will fail ...
git config --global --add safe.directory ${PRODUCT_DIR}

# /home/appusr/home/runner/work/infra-monitor/infra-monitor/opt/csi/infra-monitor/src/bash/run/run.sh
echo "cd ${PRODUCT_DIR}" >> ~/.bashrc

trap : TERM INT; sleep infinity & wait
