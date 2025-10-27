#!/bin/bash

# CPU 监控项
sketchybar --add item cpu right \
           --set cpu update_freq=2 \
                     icon="" \
                     icon.color=0xff51cf66 \
                     label="CPU: 0%" \
                     label.color=0xff51cf66 \
                     background.color=0x44000000 \
                     background.corner_radius=5 \
                     background.height=20 \
                     background.padding_left=5 \
                     background.padding_right=5 \
                     script="$PLUGIN_DIR/cpu.sh" \
           --subscribe cpu system_woke

# 内存监控项
# sketchybar --add item memory right \
#            --set memory update_freq=5 \
#                         icon="" \
#                         icon.color=0xff51cf66 \
#                         label="Memory: 0GB" \
#                         label.color=0xff51cf66 \
#                         background.color=0x44000000 \
#                         background.corner_radius=5 \
#                         background.height=20 \
#                         background.padding_left=5 \
#                         background.padding_right=5 \
#                         script="$PLUGIN_DIR/memory.sh" \
#            --subscribe memory system_woke

# 添加分隔符（可选）
sketchybar --add item system_separator right \
           --set system_separator icon="|" \
                                  icon.color=0x44ffffff \
                                  background.padding_left=5 \
                                  background.padding_right=5

