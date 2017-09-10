#!/bin/bash

. utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log $0

# Target to metadata backup
TARGET="$1"
# incron action
ACTION="$2"
# Name for target's metadata
NAME="$3"

# Directory where backup will be placed
DEST_DIR="$HOME/debian-backup-files/metadata"

# Metadata of target file
METADATA="$DEST_DIR"
if [ ! -z "$NAME" ]; then
    METADATA="$METADATA/$NAME"
else
    METADATA="$METADATA/`basename "$1"`"
fi

log "source file/dir: $TARGET"
log "event: $ACTION"
log "output file: $METADATA"

if [ "$ACTION" == "IN_DELETE" ] || [ "$ACTION" == "IN_DELETE,IN_ISDIR" ]; then
    rm "$METADATA"
else
    sudo stat -c "%a %U %G %n" "$TARGET" > "$METADATA"
fi
