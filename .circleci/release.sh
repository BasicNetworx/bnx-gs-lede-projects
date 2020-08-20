#!/bin/bash

set -e

ENV="$1"
REPO="$2"
COMMITISH="$3"
RELEASE_OPTION="$4"
WORKSPACE_FOLDER="$5"
TOKEN="$6"

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

VERSION=$(cat $WORKSPACE_FOLDER/version.txt)
ARTIFACT_FOLDER=$WORKSPACE_FOLDER/artifacts

if [ "$ENV" == "prod" ]; then
    S3_BUCKET="release.bnxcloud.com"
else
    S3_BUCKET="release.bnxcloud-${ENV}.com"
fi

RELEASE_PREFIX="bnx-firmware"
RELEASE_PATH="$S3_BUCKET/$RELEASE_PREFIX/$(urlencode $VERSION)"
RELEASE_S3_URI="s3://$RELEASE_PATH/"
RELEASE_URL="https://$RELEASE_PATH"

release_notes=""

files=$(ls -1 $ARTIFACT_FOLDER)
for f in $files
do
    aws s3 cp $ARTIFACT_FOLDER/$f $RELEASE_S3_URI --acl public-read
    url="$RELEASE_URL/$(urlencode $f)"
    release_notes="${release_notes}[$f]($url)<br>"

    # Add new sysupgrade firmware to public list of releases
    if [[ $f == *_sysupgrade.bin ]]; then
        aws s3 cp s3://$S3_BUCKET/firmware.html .
        HTML_FILE=$(mktemp)
        echo "    <tr>" > $HTML_FILE
        echo "        <td><a href=\"$url\">$VERSION</a></td>" >> $HTML_FILE
        echo "        <td>$(date -u)</td>" >> $HTML_FILE
        echo "    </tr>" >> $HTML_FILE
        reg='<builds>'
        while IFS= read -r line; do
            printf '%s\n' "$line"
            [[ $line =~ $reg ]] && cat $HTML_FILE
        done < firmware.html > new_firmware.html
        rm -rf $HTML_FILE
        mv new_firmware.html firmware.html

        aws s3 cp firmware.html s3://$S3_BUCKET/ --acl public-read
    fi
done

if [ "$RELEASE_OPTION" == "--ignore" ]; then
    RELEASE_OPTION=""
fi

if [ "$RELEASE_OPTION" != "--norelease" ]; then
    githubrelease --github-token $TOKEN release $REPO create v$VERSION --target-commitish $COMMITISH  $RELEASE_OPTION --publish --name v$VERSION --body "$release_notes"
fi
