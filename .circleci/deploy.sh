#!/bin/bash

set -e -x

ENV="$1"
WORKSPACE_FOLDER="$2"

VERSION=$(cat $WORKSPACE_FOLDER/version.txt)
PACKAGES_NAME="${VERSION}_packages"
ARTIFACT_FOLDER=$WORKSPACE_FOLDER/artifacts

S3_BUCKET_PACKAGE="package.bnxcloud.com"
S3_PATH="$S3_BUCKET_PACKAGE/$ENV"

unzip $ARTIFACT_FOLDER/$PACKAGES_NAME.zip
aws s3 sync $PACKAGES_NAME/ s3://$S3_PATH/ --acl public-read --delete
