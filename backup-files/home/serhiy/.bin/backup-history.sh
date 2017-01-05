#!/bin/bash

# Target to backup
TARGET="$HOME/.bash_history"
# Name of backup file
BACKUP_NAME="`basename "$TARGET"`.`uname -n`.bak"
# Root directory for backups
BACKUP_DIR="$HOME/Dropbox/backup"
# Directory where backup will be placed
DEST_DIR="$BACKUP_DIR`dirname "$TARGET"`"

mkdir -p "$DEST_DIR"

cp -u --preserve=timestamps "$TARGET" "$DEST_DIR/$BACKUP_NAME"
