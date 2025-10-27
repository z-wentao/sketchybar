#!/bin/bash

# 获取 WiFi 信息
SSID=$(networksetup -getairportnetwork en0 2>/dev/null | awk -F': ' '{print $2}')

if [[ -z "$SSID" || "$SSID" == "You are not associated with an AirPort network." ]]; then
  sketchybar --set wifi icon="󰤭" label="Not Connected"
else
  sketchybar --set wifi icon="󰤨" label="$SSID"
fi
