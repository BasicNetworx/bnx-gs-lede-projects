#!/bin/bash
set -e -x

ENV=$1
COMMITISH=$2
PREBUILT_VERSION="mips_24kc_gcc-7.5.0_musl"
PREBUILT_URL="https://s3.amazonaws.com/download.bnxcloud.com/tools/prebuilt-${PREBUILT_VERSION}.tar.bz2"

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
make -j12 target/compile package/compile package/install target/install package/index
