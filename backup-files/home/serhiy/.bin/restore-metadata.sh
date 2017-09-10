#!/bin/bash

SRC_HOME=/home/serhiy

. $SRC_HOME/.bin/utils.sh      # Necessary for log function

set -e

# Define the log file name
LOG_FILE="/tmp/$(basename $0 .sh).log"
# Append current date and time to log file
log "$0: $(date '+%d/%m/%Y %H:%M:%S')"

# Input errors checking
if [[ $# -eq 0 ]]; then
    log "There is should be at least one argument passed"
    exit 1
elif [[ -z "${1// }" ]]; then
    log "There is should be nonempty metadata filename specified"
    exit 1
fi

METADATA_FILE=/home/serhiy/debian-backup-files/metadata/$1

read -r PERMISSIONS OWNER GROUP TARGET_FILE <<< $(cat "$METADATA_FILE")

OPTIND=2

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

sudo chmod "$PERMISSIONS" "$TARGET_FILE"
sudo chown "$OWNER:$GROUP" "$TARGET_FILE"
