#!/bin/bash

init_log () {
    # Define the log file name
    LOG_FILE="/tmp/$(basename "$1" .sh).log"
    # Append current date and time to log file
    log "$1: $(date '+%d/%m/%Y %H:%M:%S')"
}

log () { 
    echo "$1" | tee -a "$LOG_FILE" 
}
