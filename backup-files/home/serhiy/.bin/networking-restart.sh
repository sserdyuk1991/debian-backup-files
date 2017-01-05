#!/bin/bash

sudo pkill wpa_supplicant
sudo wpa_supplicant -B -Dnl80211 -iwlan0 -c/etc/wpa_supplicant/wpa_supplicant.conf

sudo pkill dhclient
sudo dhclient wlan0
