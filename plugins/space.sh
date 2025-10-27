#!/bin/bash

# 定义颜色（与 sketchybarrc 中一致）
WHITE=0xffffffff
ACCENT_COLOR=0xffff9f0a

# 获取当前空间 ID
SPACE_ID=$(echo "$NAME" | sed 's/space.//')

# 一次性获取所有数据，避免多次查询
ALL_SPACES=$(yabai -m query --spaces)
ALL_WINDOWS=$(yabai -m query --windows)

# 获取当前空间信息
SPACE_INFO=$(echo "$ALL_SPACES" | jq ".[] | select(.index == $SPACE_ID)")

if [ -n "$SPACE_INFO" ]; then
  # 获取当前聚焦的空间
  CURRENT_SPACE=$(echo "$ALL_SPACES" | jq -r '.[] | select(.["has-focus"] == true) | .index')

  # 计算该空间中非 sticky 窗口的数量
  WINDOW_IDS=$(echo "$SPACE_INFO" | jq -r '.windows[]')
  NON_STICKY_COUNT=$(echo "$ALL_WINDOWS" | jq "[.[] | select(.space == $SPACE_ID and .[\"is-sticky\"] == false)] | length")

  # 只显示有非 sticky 窗口的空间，或者当前聚焦的空间（即使为空）
  if [ "$NON_STICKY_COUNT" -gt 0 ] || [ "$SPACE_ID" = "$CURRENT_SPACE" ]; then
    sketchybar --set "$NAME" drawing=on

    # 高亮显示当前聚焦的空间
    if [ "$SPACE_ID" = "$CURRENT_SPACE" ]; then
      sketchybar --set "$NAME" icon.color=$ACCENT_COLOR
    else
      sketchybar --set "$NAME" icon.color=$WHITE
    fi
  else
    # 空间为空且不是当前空间，隐藏它
    sketchybar --set "$NAME" drawing=off
  fi
else
  # 空间不存在，隐藏它
  sketchybar --set "$NAME" drawing=off
fi
