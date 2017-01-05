#!/bin/bash

BACKUP_LIST="/var/spool/incron/serhiy"

while read -r BACKUP_TARGET REST; do
    backup-one.sh "$BACKUP_TARGET"
done < "$BACKUP_LIST"
