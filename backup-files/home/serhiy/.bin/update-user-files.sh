#!/bin/bash

. utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log "$0"

# Input errors checking
if [[ $# -gt 1 ]]; then
    log "There is should be only one argument passed"
    exit 1
elif [[ -z "${1// }" ]]; then
    log "There is should be nonempty username specified"
    exit 1
fi

# Save target username into internal variable
TARGET_USER=$1

# Declare array of files to be updated for specified user
declare -a files=(".bin/set-keyboards.sh"
                  ".config/awesome/rc.lua"
                  ".config/ranger/rc.conf"
                  ".bash_aliases"
                  ".bashrc"
                  ".vimrc"
                  ".Xresources"
                  )

# Update files in loop
for file in ${files[@]}
do
    TARGET_HOME=/home/$TARGET_USER
    TARGET_DIR=$TARGET_HOME/$(dirname $file)
    log "target dir: $TARGET_DIR"
    sudo mkdir -p $TARGET_DIR

    TARGET_FILE=$TARGET_HOME/$file
    log "target file: $TARGET_FILE"
    SOURCE_FILE=$HOME/debian-backup-files/backup-files/home/serhiy/$file
    log "source file: $SOURCE_FILE"
    sudo cp -r $SOURCE_FILE $TARGET_FILE

    METADATA_FILE=$(basename $file)
    sudo ./restore-metadata.sh $HOME $METADATA_FILE -u $TARGET_USER -t $TARGET_FILE
done
