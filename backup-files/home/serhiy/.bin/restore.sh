#!/bin/bash

LOG="/tmp/restore.log"

SRC="$HOME"
DST="/"

OPTIND=1

while getopts "s:d:" opt; do
    case $opt in
        s) SRC=$OPTARG
            ;;
        d) DST=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))

SRC="$SRC/debian-backup-files"

BACKUP_DIR="$SRC/backup-files"
METADATA_DIR="$SRC/metadata"

echo "source: $SRC" >> "$LOG"
echo "destination: $DST" >> "$LOG"

# Restore backup files
sudo cp -r "$BACKUP_DIR/." "$DST"

# Set ownership to current user for all $HOME content
sudo chown -R $USER:$USER $HOME/{.[!.],}*

# Restore metadata for all backup files
for FILE in $METADATA_DIR/{.[!.],}*; do
    sudo /home/serhiy/.bin/restore-metadata.sh "$FILE"
done
