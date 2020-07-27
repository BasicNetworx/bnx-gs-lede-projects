#!/bin/bash
set -e -x

ENV=$1
COMMITISH=$2
PREBUILT_URL="https://s3.amazonaws.com/download.bnxcloud.com/tools/prebuilt.tar.bz2"

version=$(bash .circleci/get_version.sh $ENV $COMMITISH)

## FETCH
./scripts/feeds update -a
./scripts/feeds install -p bnx -a
if [ ! -x prebuilt.tbz ]; then
    wget $PREBUILT_URL -O prebuilt.tbz
    tar jxf prebuilt.tbz
fi

## CONFIGURE
cp bnx.config .config
cat .circleci/$ENV.config >> .config
echo 'CONFIG_VERSION_NUMBER="'$version'"' >> .config
make defconfig

## BUILD
make -j12 target/compile package/compile target/install package/install
