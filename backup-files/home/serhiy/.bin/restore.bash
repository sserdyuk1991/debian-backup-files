#!/bin/bash

LOG="/tmp/restore.log"

ACTION="UPDATE"
ROOT="$HOME/Dropbox"
DST="/"

OPTIND=1

while getopts "nr:d:" opt; do
    case $opt in
        n) ACTION="NEW"
            ;;
        r) ROOT=$OPTARG
            ;;
        d) DST=$OPTARG
            ;;
    esac
done

shift $((OPTIND-1))

BACKUP_DIR="$ROOT/backup"
METADATA_DIR="$ROOT/metadata"

echo "action: $ACTION" > "$LOG"
echo "root: $ROOT" >> "$LOG"
echo "destination: $DST" >> "$LOG"

# Wait for dropbox running
DROPBOX_STATE=`/home/serhiy/.bin/dropbox.py status`
while [ "$DROPBOX_STATE" != "Up to date" ]; do
    sleep 1
    DROPBOX_STATE=`/home/serhiy/.bin/dropbox.py status`
done

if [ "$ACTION" == "NEW" ]; then
    sudo cp -r --preserve=timestamps "$BACKUP_DIR/." "$DST"
else
    sudo cp -ur --preserve=timestamps "$BACKUP_DIR/." "$DST"
fi

# Set ownership of some directories to user 'serhiy'
sudo chown -R serhiy:serhiy ~/.config
sudo chown -R serhiy:serhiy ~/.mozilla/firefox/npm6t8vy.default

# Restore metadata for all backup files
for FILE in $METADATA_DIR/{.[!.],}*; do
    sudo /home/serhiy/.bin/restore-metadata.sh "$FILE"
done
