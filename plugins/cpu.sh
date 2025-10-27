#!/bin/bash

# 获取CPU使用率
CPU_INFO=$(top -l 2 -n 0 -F | grep -E "^CPU" | tail -1)
CPU_USER=$(echo "$CPU_INFO" | awk '{print $3}' | sed 's/%//')
CPU_SYS=$(echo "$CPU_INFO" | awk '{print $5}' | sed 's/%//')
CPU_USAGE=$(echo "$CPU_USER $CPU_SYS" | awk '{printf "%.1f", $1 + $2}')

# 根据使用率设置颜色
if (( $(echo "$CPU_USAGE > 80" | bc -l) )); then
    COLOR="0xffff6b6b"  # 红色
elif (( $(echo "$CPU_USAGE > 50" | bc -l) )); then
    COLOR="0xfffeca57"  # 黄色
else
    COLOR="0xff51cf66"  # 绿色
fi

# 更新 Sketchybar
sketchybar --set cpu label="CPU: ${CPU_USAGE}%" \
                     label.color="$COLOR" \
                     icon.color="$COLOR"

