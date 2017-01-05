#!/bin/bash

LOG="/tmp/backup-one.log"
# Initialize log
echo `date "+%T"` > $LOG

# Target to backup
TARGET="$1"
# incron action
ACTION="$2"
# Name for target's metadata file
METADATA_NAME="$3"

if [ ! -e "$TARGET" ]; then
    echo "backup-one.sh: cannot backup '$TARGET': No such file or directory" >> "$LOG"
fi

# Root directory for backups
BACKUP_DIR="$HOME/debian-backup-files/backup-files"
# Location of target file in system rootfs
SOURCE_DIR="`dirname "$TARGET"`"
# Directory where backup will be placed
DEST_DIR="$BACKUP_DIR$SOURCE_DIR"

# Get the owner of the file 
FILE_OWNER=`stat -c %U "$TARGET"`
# Get the owner of the parent directory
DIR_OWNER=`stat -c %U "$SOURCE_DIR"`

echo "source file/dir: $TARGET" >> "$LOG"
echo "event: $ACTION" >> "$LOG"
echo "destination dir: $DEST_DIR" >> "$LOG"

if [ "$ACTION" == "IN_DELETE" ] || [ "$ACTION" == "IN_DELETE,IN_ISDIR" ]; then
    rm -r "$BACKUP_DIR$TARGET"
    /home/serhiy/.bin/backup-metadata.sh "$TARGET" "$ACTION" "$METADATA_NAME"
elif [ "$ACTION" == "IN_ATTRIB" ] || [ "$ACTION" == "IN_ATTRIB,IN_ISDIR" ]; then
    /home/serhiy/.bin/backup-metadata.sh "$TARGET" "$ACTION" "$METADATA_NAME"
else
    mkdir -p "$DEST_DIR"

    if [ "$FILE_OWNER" == "root" ] || [ "$DIR_OWNER" == "root" ]; then
        sudo cp -ur --preserve=timestamps "$TARGET" "$DEST_DIR"
    else
        cp -ur --preserve=timestamps "$TARGET" "$DEST_DIR"
    fi

    /home/serhiy/.bin/backup-metadata.sh "$TARGET" "$ACTION" "$METADATA_NAME"
    if [ "$ACTION" == "IN_IGNORED" ]; then
        sudo service incron restart
    fi
fi
