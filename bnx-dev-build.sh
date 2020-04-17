#!/bin/bash
./scripts/feeds update -a
./scripts/feeds install -p bnx -a
python patches/apply-patches.py
cp bnx-dev-build.config .config
make defconfig
make -j4
