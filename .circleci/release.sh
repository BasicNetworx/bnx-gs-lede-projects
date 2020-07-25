#!/bin/bash

set -e

ENV="$1"
REPO="$2"
COMMITISH="$3"
RELEASE_OPTION="$4"
WORKSPACE_FOLDER="$5"
TOKEN="$6"

VERSION=$(cat $WORKSPACE_FOLDER/version.txt)
ARTIFACT_FOLDER=$WORKSPACE_FOLDER/artifacts

if [ "$ENV" == "prod" ]; then
    S3_BUCKET="release.bnxcloud.com"
else
    S3_BUCKET="release.bnxcloud-${ENV}.com"
fi

S3_PREFIX="bnx-firmware"
S3_PATH="$S3_BUCKET/$S3_PREFIX/$VERSION"
S3_URL="https://s3.amazonaws.com/$S3_PATH"

urlencode() {
    # urlencode <string>
    old_lc_collate=$LC_COLLATE
    LC_COLLATE=C

    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done

    LC_COLLATE=$old_lc_collate
}

release_notes=""

files=$(ls -1 $ARTIFACT_FOLDER)
for f in $files
do
    aws s3 cp $ARTIFACT_FOLDER/$f s3://$S3_PATH/ --acl public-read
    url="$S3_URL/$(urlencode $f)"
    release_notes="${release_notes}[$f]($url)<br>"
done

if [ "$RELEASE_OPTION" == "--ignore" ]; then
    RELEASE_OPTION=""
fi

if [ "$RELEASE_OPTION" != "--norelease" ]; then
    githubrelease --github-token $TOKEN release $REPO create v$VERSION --target-commitish $COMMITISH  $RELEASE_OPTION --publish --name v$VERSION --body "$release_notes"
fi
