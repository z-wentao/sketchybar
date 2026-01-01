#!/bin/bash

# 输入法监听脚本 - 使用 Swift 监听系统输入法变化通知

# 创建 Swift 监听脚本
swift - <<'EOF' 2>/dev/null &
import Foundation
import Carbon

// 获取当前输入法并触发更新
func updateInputSource() {
    let task = Process()
    task.launchPath = "/bin/bash"
    task.arguments = [NSHomeDirectory() + "/.config/sketchybar/plugins/input_source.sh"]

    do {
        try task.run()
    } catch {
        print("Failed to run update script: \(error)")
    }
}

// 监听输入法变化
DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("AppleSelectedInputSourcesChangedNotification"),
    object: nil,
    queue: .main
) { _ in
    updateInputSource()
}

// 监听键盘输入源变化（另一个可能的通知）
DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name(kTISNotifySelectedKeyboardInputSourceChanged as String),
    object: nil,
    queue: .main
) { _ in
    updateInputSource()
}

// 初始更新
updateInputSource()

// 保持运行
RunLoop.main.run()
EOF

echo $! > /tmp/sketchybar_input_source_listener.pid
