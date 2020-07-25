#!/bin/bash
set -e -x

env=$1

## FETCH
./scripts/feeds update -a
./scripts/feeds install -p bnx -a

## CONFIGURE
cp bnx.config .config
cat .circleci/toolchain.config >> .config
cat .circleci/$env.config >> .config
echo 'CONFIG_VERSION_NUMBER="'$(cat version.txt)'"' >> .config
make defconfig

## BUILD
make -j12
