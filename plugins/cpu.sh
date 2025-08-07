#!/bin/bash

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

if (( CPU_PERCENT < 50 )); then
  COLOR="0xff88c0d0" # Nord Frost Blue
elif (( CPU_PERCENT < 80 )); then
  COLOR="0xffd08770" # Nord Orange
else
  COLOR="0xffbf616a" # Nord Red
fi

ICON=""

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${CPU_PERCENT}%"