#!/bin/bash

ENV=$1
BUILD_NUM=$2

version=$(cat version.txt)
if [ "$ENV" != "prod" ]; then
    version=${version}-${ENV}.${BUILD_NUM}
fi

echo $version
