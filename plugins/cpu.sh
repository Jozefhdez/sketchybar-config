#!/bin/bash

# Obtener el número de núcleos y el uso de CPU
CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

# Calcular el porcentaje total de uso de CPU
CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

# Determinar el color según el nivel de uso de CPU (paleta Gruvbox)
if (( CPU_PERCENT < 50 )); then
  COLOR="0xffb8bb26" # Verde (bajo)
elif (( CPU_PERCENT < 80 )); then
  COLOR="0xfffabd2f" # Amarillo (moderado)
else
  COLOR="0xfffb4934" # Rojo (alto)
fi

# Determinar el ícono
ICON=""

# Actualizar el elemento en SketchyBar
sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${CPU_PERCENT}%"