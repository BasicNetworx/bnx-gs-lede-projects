#!/bin/bash
./scripts/feeds update -a
./scripts/feeds install -p bnx -a
cp bnx-dev-build.config .config
make defconfig
make -j4
