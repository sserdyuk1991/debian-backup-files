#!/bin/bash

. utils.sh      # Necessary for log function

set -e

# Initialize log file
init_log $0

rm -r "$HOME/Dropbox.bak"
cp -r "$HOME/Dropbox" "$HOME/Dropbox.bak"
