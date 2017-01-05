#!/bin/bash

# Target to metadata backup
TARGET="$1"
# incron action
ACTION="$2"
# Name for target's metadata
NAME="$3"

# Directory where backup will be placed
DEST_DIR="$HOME/Dropbox/metadata"

# Metadata of target file
METADATA="$DEST_DIR"
if [ ! -z "$NAME" ]; then
    METADATA="$METADATA/$NAME"
else
    METADATA="$METADATA/`basename "$1"`"
fi

LOG="/tmp/backup-metadata.log"
echo "source file/dir: $TARGET" > "$LOG"
echo "event: $ACTION" >> "$LOG"
echo "output file: $METADATA" >> "$LOG"

if [ "$ACTION" == "IN_DELETE" ] || [ "$ACTION" == "IN_DELETE,IN_ISDIR" ]; then
    rm "$METADATA"
else
    sudo stat -c "%a %U %G %n" "$TARGET" > "$METADATA"
fi
