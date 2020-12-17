#!/bin/bash
set -e

## FETCH
# ./scripts/feeds clean
./scripts/feeds update -a
./scripts/feeds install -p bnx -a

## CONFIGURE
cp bnx.config .config
make defconfig

## BUILD
# make clean
make -j$(nproc)
