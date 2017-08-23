#!/bin/bash

ID=`xinput list | grep -i touchpad | awk '{print $7}' | cut -d= -f2`
STATE=`xinput list-props $ID | grep 'Device Enabled' | cut -d' ' -f3 | awk '{print $2}'`

if [ $STATE -eq 0 ]; then
    `xinput enable $ID`
else
    `xinput disable $ID`
fi
