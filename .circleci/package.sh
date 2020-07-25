#!/bin/bash
set -e -x

ENV=$1
COMMITISH=$2
WORKSPACE_FOLDER=$3
ARTIFACT_FOLDER=$WORKSPACE_FOLDER/artifacts
VERSION=$(bash .circleci/get_version.sh $ENV $COMMITISH)
PACKAGES_NAME="${VERSION}_packages"

# data needed in downstream jobs
mkdir -p $WORKSPACE_FOLDER
echo $VERSION > $WORKSPACE_FOLDER/version.txt
cp .circleci/release.sh $WORKSPACE_FOLDER
cp .circleci/deploy.sh $WORKSPACE_FOLDER

# artifacts that will be stored
mkdir -p $ARTIFACT_FOLDER/$PACKAGES_NAME
cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-oolitebox-squashfs-factory.bin $ARTIFACT_FOLDER/${VERSION}_factory.bin
cp bin/targets/ar71xx/generic/openwrt-ar71xx-generic-oolitebox-squashfs-sysupgrade.bin $ARTIFACT_FOLDER/${VERSION}_sysupgrade.bin
cp -R bin/packages/mips_24kc/* $ARTIFACT_FOLDER/$PACKAGES_NAME/
cp -R bin/targets/ar71xx/generic/packages $ARTIFACT_FOLDER/$PACKAGES_NAME/core
(cd $ARTIFACT_FOLDER && zip -r $PACKAGES_NAME.zip $PACKAGES_NAME && rm -rf $PACKAGES_NAME)
