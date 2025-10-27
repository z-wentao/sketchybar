#!/bin/bash

# 检查时钟 App 是否运行
if ! pgrep -x "Clock" > /dev/null; then
  sketchybar --set timer drawing=off
  exit 0
fi

# 获取计时器状态（使用 AppleScript）
TIMER_INFO=$(osascript << 'END' 2>/dev/null
try
  tell application "System Events"
    tell process "Clock"
      if exists window 1 then
        -- 尝试获取计时器界面的文本
        set allTexts to value of every static text of group 1 of window 1
        return allTexts as string
      end if
    end tell
  end tell
on error
  return ""
end try
END
)

# 解析时间（查找类似 "00:00:00" 的格式）
if [[ "$TIMER_INFO" =~ ([0-9]{1,2}:[0-9]{2}:[0-9]{2})|([0-9]{1,2}:[0-9]{2}) ]]; then
  TIME_DISPLAY="${BASH_REMATCH[0]}"

  # 判断是否在倒计时
  if [[ "$TIME_DISPLAY" != "00:00:00" && "$TIME_DISPLAY" != "00:00" ]]; then
    sketchybar --set timer \
               label="$TIME_DISPLAY" \
               label.color=0xffa6e3a1 \
               icon="⏱" \
               drawing=on
  else
    # 计时器结束
    sketchybar --set timer \
               label="结束" \
               label.color=0xffff6b6b \
               icon="⏰" \
               drawing=on
  fi
else
  # 没有活动的计时器
  sketchybar --set timer drawing=off
fi
