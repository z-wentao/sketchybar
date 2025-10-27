#!/bin/bash

sketchybar --add item timer center \
           --set timer \
                 icon="⏱" \
                 icon.font="SF Pro:Bold:16.0" \
                 label="" \
                 label.font="SF Mono:Bold:14.0" \
                 label.color=0xffcdd6f4 \
                 background.color=0xff313244 \
                 background.corner_radius=5 \
                 background.height=26 \
                 padding_left=8 \
                 padding_right=8 \
                 update_freq=1 \
                 script="$HOME/.config/sketchybar/plugins/timer_display.sh" \
                 click_script="open -a Clock; osascript -e 'tell application \"System Events\" to tell process \"Clock\" to click radio button \"Timer\" of tab group 1 of window 1'"
