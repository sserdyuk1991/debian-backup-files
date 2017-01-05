#!/bin/bash

read -r PERMISSIONS OWNER GROUP FILE <<< `cat "$1"`

echo $PERMISSIONS
echo $OWNER
echo $GROUP
echo $FILE

sudo chmod $PERMISSIONS "$FILE"
sudo chown $OWNER:$GROUP "$FILE"
