#!/bin/bash

# 应用使用追踪脚本
# 每1分钟运行一次，记录当前活跃的应用

APP_LOG_DIR="$HOME/Library/Mobile Documents/27N4MQEA55~pro~writer/Documents/notes"
APP_LOG_FILE="$APP_LOG_DIR/$(date +%Y%m%d)_apptrack.data"

# 确保目录存在
mkdir -p "$APP_LOG_DIR"

# 获取当前时间（HH:MM格式）
CURRENT_TIME=$(date +%H:%M)

# 获取当前活跃的应用（前台应用）
ACTIVE_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)

# 如果成功获取到应用名
if [ -n "$ACTIVE_APP" ]; then
  # 记录格式：时间|应用名
  echo "$CURRENT_TIME|$ACTIVE_APP" >> "$APP_LOG_FILE"
fi
