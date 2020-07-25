#!/bin/bash
set -e -x

ZIP_FILE=$1
ARTIFACT_FOLDER="build-artifacts"

mkdir -p $ARTIFACT_FOLDER/firmware
mkdir -p $ARTIFACT_FOLDER/packages

mv bin/targets/ar71xx/generic/openwrt-ar71xx-generic-oolitebox-squashfs-* $ARTIFACT_FOLDER/firmware/
mv bin/packages/mips_24kc/* $ARTIFACT_FOLDER/packages/
mv bin/targets/ar71xx/generic/packages/ $ARTIFACT_FOLDER/packages/core

zip -r $ZIP_FILE $ARTIFACT_FOLDER
