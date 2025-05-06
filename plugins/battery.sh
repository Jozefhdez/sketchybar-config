#!/bin/sh

# Obtener el porcentaje de batería y estado de carga
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

# Validar si el porcentaje es válido
if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Determinar el color según el nivel de batería
if (( PERCENTAGE >= 40 )); then
  COLOR="0xffb8bb26" # Verde
elif (( PERCENTAGE >= 20 )); then
  COLOR="0xfffabd2f" # Amarillo
elif (( PERCENTAGE >= 15 )); then
  COLOR="0xffffa500" # Naranja
else
  COLOR="0xfffb4934" # Rojo
fi

# Determinar el ícono según el nivel de batería
if [[ "$CHARGING" != "" ]]; then
  ICON="" # Ícono de carga
elif (( PERCENTAGE >= 90 )); then
  ICON="" # Batería llena
elif (( PERCENTAGE >= 60 )); then
  ICON="" # Batería 60-89%
elif (( PERCENTAGE >= 30 )); then
  ICON="" # Batería 30-59%
elif (( PERCENTAGE >= 10 )); then
  ICON="" # Batería 10-29%
else
  ICON="" # Batería crítica
fi

# Actualizar el elemento en SketchyBar
sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"