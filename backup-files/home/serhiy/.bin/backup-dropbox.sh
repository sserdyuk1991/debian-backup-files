#!/bin/bash

rm -r "$HOME/Dropbox.bak"
cp -r --preserve=timestamps "$HOME/Dropbox" "$HOME/Dropbox.bak"
