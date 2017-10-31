#!/bin/bash

. "$(dirname "$0")/utils.sh"      # Necessary for log function

set -e

# Initialize log file
init_log "$0"

SRC=$HOME/Workspace
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

REPO_DIR="$SRC/debian-backup-files"
BACKUP_FILES_DIR="$REPO_DIR/backup-files"
METADATA_DIR="$REPO_DIR/metadata"

log "source: $BACKUP_FILES_DIR"
log "destination: $DST"

# Restore backup files
sudo cp -r "$BACKUP_FILES_DIR/." "$DST"

# Set ownership to current user for all $HOME content
sudo chown -R $USER:$USER $HOME/{.[!.],}*

# Restore metadata for all backup files
for METADATA_FILE in $METADATA_DIR/{.[!.],}*; do
    "$(dirname "$0")/restore-metadata.sh" "$SRC" "$(basename "$METADATA_FILE")"
done
