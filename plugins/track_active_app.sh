#!/bin/bash

# 应用使用追踪脚本（增强版）
# 每1分钟运行一次，记录当前活跃的应用和空闲状态

APP_LOG_DIR="$HOME/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/notes"
APP_LOG_FILE="$APP_LOG_DIR/$(date +%Y%m%d)_apptrack.data"
IDLE_THRESHOLD=300  # 5分钟 = 300秒

# 确保目录存在
mkdir -p "$APP_LOG_DIR"

# 获取当前时间（HH:MM格式）
CURRENT_TIME=$(date +%H:%M)

# 1. 检测HID空闲时间（鼠标键盘输入的空闲时间）
HID_IDLE=$(ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print int($NF/1000000000)}')

# 2. 获取当前活跃的应用（前台应用）
ACTIVE_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)

# 3. 检测是否在播放视频/音频
IS_PLAYING=false
if echo "$ACTIVE_APP" | grep -qE "QuickTime|VLC|IINA|Safari|Chrome|Brave|Firefox|Music|Spotify"; then
  # 可能在播放视频/音频
  IS_PLAYING=true
fi

# 4. 判断是否真正空闲
if [ $HID_IDLE -ge $IDLE_THRESHOLD ] && [ "$IS_PLAYING" = "false" ]; then
  # 真正空闲（超过5分钟无鼠标键盘输入，且未播放视频）- 记录为 IDLE
  echo "$CURRENT_TIME|IDLE|$HID_IDLE" >> "$APP_LOG_FILE"
else
  # 活跃状态 - 记录当前应用和空闲时间
  if [ -n "$ACTIVE_APP" ]; then
    echo "$CURRENT_TIME|$ACTIVE_APP|$HID_IDLE" >> "$APP_LOG_FILE"
  fi
fi
