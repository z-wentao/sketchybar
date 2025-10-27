#!/bin/bash

# 获取内存信息
MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print 100-$5}' | sed 's/%//')
MEMORY_INFO=$(vm_stat | grep -E "(Pages active|Pages wired down|Pages speculative|Pages occupied by compressor)")

# 计算内存使用量（单位：页，每页4096字节）
PAGES_ACTIVE=$(echo "$MEMORY_INFO" | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED=$(echo "$MEMORY_INFO" | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')
PAGES_SPEC=$(echo "$MEMORY_INFO" | grep "Pages speculative" | awk '{print $3}' | sed 's/\.//')
PAGES_COMPRESSED=$(echo "$MEMORY_INFO" | grep "Pages occupied by compressor" | awk '{print $5}' | sed 's/\.//')

# 转换为GB
MEMORY_USED=$(echo "scale=2; ($PAGES_ACTIVE + $PAGES_WIRED + $PAGES_SPEC + $PAGES_COMPRESSED) * 4096 / 1073741824" | bc)

# 获取总内存（GB）
TOTAL_MEMORY=$(sysctl -n hw.memsize | awk '{printf "%.1f", $1/1073741824}')

# 计算使用百分比
MEMORY_PERCENT=$(echo "scale=1; $MEMORY_USED / $TOTAL_MEMORY * 100" | bc)

# 设置颜色
if (( $(echo "$MEMORY_PERCENT > 80" | bc -l) )); then
    COLOR="0xffff6b6b"  # 红色
elif (( $(echo "$MEMORY_PERCENT > 60" | bc -l) )); then
    COLOR="0xfffeca57"  # 黄色
else
    COLOR="0xff51cf66"  # 绿色
fi

# 更新 Sketchybar
sketchybar --set memory label="Mem: ${MEMORY_USED}GB" \
                        label.color="$COLOR" \
                        icon.color="$COLOR"

