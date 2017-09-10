#!/bin/bash

log () { 
    echo "$1" | tee -a "$LOG_FILE" 
}
