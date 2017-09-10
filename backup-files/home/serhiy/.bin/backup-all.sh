#!/bin/bash

. utils.sh      # Necessary for log function

# Initialize log file
init_log $0

BACKUP_LIST="/var/spool/incron/serhiy"

while read -r BACKUP_TARGET REST; do
    log "backup target: $BACKUP_TARGET"
    backup-one.sh "$BACKUP_TARGET"
done < "$BACKUP_LIST"
