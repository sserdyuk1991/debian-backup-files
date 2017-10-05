#!/bin/bash

. utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log "$0"

# Input errors checking
if [[ $# -eq 0 ]]; then
    log "There is should be at least one argument passed"
    exit 1
elif [[ -z "${1// }" ]]; then
    log "There is should be nonempty backup target filename specified"
    exit 1
fi

# Target to metadata backup
TARGET=$1
# incron action
ACTION=$2
# Name for target's metadata
NAME=$3

# Directory where backup will be placed
DEST_DIR=$HOME/Workspace/debian-backup-files/metadata

# Metadata of target file
METADATA=$DEST_DIR
if [[ -n $NAME ]]; then
    METADATA="$METADATA/$NAME"
else
    METADATA="$METADATA/$(basename "$TARGET")"
fi

log "source file: $TARGET"
log "event: $ACTION"
log "destination file: $METADATA"

if [[ $ACTION == "IN_DELETE" || $ACTION == "IN_DELETE,IN_ISDIR" ]]; then
    rm "$METADATA"
else
    sudo stat -c "%a %U %G %n" "$TARGET" > "$METADATA"
fi
