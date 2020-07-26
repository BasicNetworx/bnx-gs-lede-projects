#!/bin/bash
set -e -x

ENV=$1
COMMITISH=$2

version=$(bash .circleci/get_version.sh $ENV $COMMITISH)

## FETCH
./scripts/feeds update -a
./scripts/feeds install -p bnx -a

## CONFIGURE
cp bnx.config .config
cat .circleci/toolchain.config >> .config
cat .circleci/$ENV.config >> .config
echo 'CONFIG_VERSION_NUMBER="'$version'"' >> .config
make defconfig

## BUILD
make -j12
