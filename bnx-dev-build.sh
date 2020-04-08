#!/bin/bash
./scripts/feeds update bnx packages luci
./scripts/feeds install -p bnx -a
./scripts/feeds install -p luci luci
python patches/apply-patches.py
cp bnx-dev-build.config .config
make defconfig
make -j4
