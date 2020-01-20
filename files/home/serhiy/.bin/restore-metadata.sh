#!/bin/bash

SRC_HOME=/home/serhiy

. $SRC_HOME/.bin/utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log "$0"

# Input errors checking
if [[ $# -lt 2 ]]; then
    log "There are should be at least two arguments passed"
    exit 1
elif [[ -z "${1// }" ]]; then
    log "There is should be nonempty parent directory for backup repo specified"
    exit 1
elif [[ -z "${2// }" ]]; then
    log "There is should be nonempty metadata filename specified"
    exit 1
fi

METADATA_FILE="$1/gnulinux-backup/metadata/$2"

read -r PERMISSIONS OWNER GROUP TARGET_FILE <<< $(cat "$METADATA_FILE")

OPTIND=3

while getopts "u:t:" opt; do
    case $opt in
        u) OWNER=$OPTARG; GROUP=$OPTARG
            ;;
        t) TARGET_FILE=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))

log "target file: $TARGET_FILE"
log "metadata file: $METADATA_FILE"
log "permissions: $PERMISSIONS"
log "owner: $OWNER"
log "group: $GROUP"

sudo chmod $PERMISSIONS "$TARGET_FILE"
sudo chown $OWNER:$GROUP "$TARGET_FILE"
