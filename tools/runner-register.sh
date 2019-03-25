#!/bin/bash

if [ ! $# -eq 3 ]
then
    echo -e "\t必须输入三个参数：【名称】 【tokern】 【镜像名称】"

else
    name=$1
    token=$2
    image=$3

    exec.sh gitlab-runner gitlab-runner register --non-interactive --tag-list=$name --description=$name --url="http://gitlab.my_domain.com" --registration-token=$token --executor="docker" --docker-image=$image --docker-network-mode="server_network" --docker-pull-policy="if-not-present" --run-untagged --locked="false"
#    ./exec.sh gitlab-runner gitlab-runner register \
#    --non-interactive \
#    --tag-list=$name \
#    --description=$name \
#    --url="http://gitlab.my_domain.com" \
#    --registration-token=$token \
#    --executor="docker" \
#    --docker-image=$image \
#    --docker-network-mode="server_network" \
#    --docker-pull-policy="if-not-present" \
#    --run-untagged \
#    --locked="false"
fi