#!/bin/bash

# 获取时间和日期
TIME=$(date '+%H:%M')
DATE=$(date '+%m/%d')

# 使用正确的语法设置图标和标签
sketchybar --set calendar icon="󰃰" label="$TIME  $DATE"
