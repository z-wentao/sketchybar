#!/bin/bash

case "$1" in
  quick_5)
    # 快速设置 5 分钟
    osascript << 'END'
      tell application "Clock" to activate
      delay 0.5
      tell application "System Events"
        tell process "Clock"
          -- 点击 Timer 标签
          click radio button "Timer" of tab group 1 of window 1
          delay 0.3

          -- 设置时间为 5 分钟
          set value of text field 1 of group 1 of window 1 to "5"
          set value of text field 2 of group 1 of window 1 to "00"

          -- 开始计时器
          click button "Start" of group 1 of window 1
        end tell
      end tell
END
    ;;

  quick_25)
    # 番茄钟 25 分钟
    osascript << 'END'
      tell application "Clock" to activate
      delay 0.5
      tell application "System Events"
        tell process "Clock"
          click radio button "Timer" of tab group 1 of window 1
          delay 0.3
          set value of text field 1 of group 1 of window 1 to "25"
          set value of text field 2 of group 1 of window 1 to "00"
          click button "Start" of group 1 of window 1
        end tell
      end tell
END
    ;;

  open)
    # 打开时钟 App 的计时器
    open -a Clock
    osascript -e 'tell application "System Events" to tell process "Clock" to click radio button "Timer" of tab group 1 of window 1'
    ;;

  stop)
    # 停止计时器
    osascript << 'END'
      tell application "System Events"
        tell process "Clock"
          if exists button "Stop" of group 1 of window 1 then
            click button "Stop" of group 1 of window 1
          end if
        end tell
      end tell
END
    ;;
esac
