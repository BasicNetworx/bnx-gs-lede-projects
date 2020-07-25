#!/bin/bash

set -e -x

ENV="$1"
WORKSPACE_FOLDER="$2"

VERSION=$(cat $WORKSPACE_FOLDER/version.txt)
PACKAGES_NAME="${VERSION}_packages"
ARTIFACT_FOLDER=$WORKSPACE_FOLDER/artifacts

if [ "$ENV" == "prod" ]; then
    S3_BUCKET="package.bnxcloud.com"
else
    S3_BUCKET="package.bnxcloud-${ENV}.com"
fi

unzip $ARTIFACT_FOLDER/$PACKAGES_NAME.zip
echo $VERSION > $PACKAGES_NAME/version.txt
aws s3 sync $PACKAGES_NAME/ s3://$S3_BUCKET/ --acl public-read --delete
