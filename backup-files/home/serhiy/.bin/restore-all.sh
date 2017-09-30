#!/bin/bash

. utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log "$0"

SRC=$HOME
DST=/

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

log "source: $SRC"
log "destination: $DST"

# Restore backup files
sudo cp -r "$BACKUP_DIR/." "$DST"

# Set ownership to current user for all $HOME content
sudo chown -R $USER:$USER $HOME/{.[!.],}*

# Restore metadata for all backup files
for METADATA_FILE in $METADATA_DIR/{.[!.],}*; do
    sudo $HOME/.bin/restore-metadata.sh $(basename "$METADATA_FILE")
done
