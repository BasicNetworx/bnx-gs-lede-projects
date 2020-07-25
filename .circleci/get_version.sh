#!/bin/bash

ENV=$1
COMMITISH=$2

version=$(cat version.txt)
if [ "$ENV" != "prod" ]; then
    version=${version}-${ENV}
    if [ "$ENV" != "beta" ]; then
        version=${version}+${COMMITISH}
    fi
fi

echo $version
