#!/bin/bash
set -e -x

ENV=$1
COMMITISH=$2
ARTIFACT_FOLDER=$3

version=$(bash .circleci/get_version.sh $ENV $COMMITISH)

mkdir -p $ARTIFACT_FOLDER/packages
echo $version > $ARTIFACT_FOLDER/version.txt
cp .circleci/deploy.sh $ARTIFACT_FOLDER

cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-oolitebox-squashfs-factory.bin $ARTIFACT_FOLDER/${version}_factory.bin
cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-oolitebox-squashfs-sysupgrade.bin $ARTIFACT_FOLDER/${version}_sysupgrade.bin
cp -R bin/packages/mips_24kc/* $ARTIFACT_FOLDER/packages/
cp -R bin/targets/ar71xx/generic/packages $ARTIFACT_FOLDER/packages/core
(cd $ARTIFACT_FOLDER && zip -r packages.zip packages && rm -rf packages)
