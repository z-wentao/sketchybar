#!/bin/bash

# 获取当前聚焦的应用程序信息
APP_NAME=$(yabai -m query --windows --window | jq -r '.app')

# 如果获取失败，尝试使用备用方法
if [[ -z "$APP_NAME" || "$APP_NAME" == "null" ]]; then
  APP_NAME=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')
fi

# 处理特殊应用名称（可选，让显示更简洁）
case "$APP_NAME" in
  "Google Chrome") APP_NAME="Chrome" ;;
  "Microsoft Edge") APP_NAME="Edge" ;;
  "Visual Studio Code") APP_NAME="VS Code" ;;
  "IntelliJ IDEA") APP_NAME="IntelliJ" ;;
  "System Preferences") APP_NAME="Settings" ;;
  "Sublime Text") APP_NAME="Sublime" ;;
  "iTerm2") APP_NAME="iTerm" ;;
  "WezTerm") APP_NAME="Wez" ;;
esac

# 限制名称长度（防止过长）
if [[ ${#APP_NAME} -gt 20 ]]; then
  APP_NAME="${APP_NAME:0:17}..."
fi

# 更新 SketchyBar 显示
sketchybar --set front_app label="$APP_NAME"
