#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Paleta Nord extendida con transiciones más suaves
if (( PERCENTAGE >= 95 )); then
  COLOR="0xffa3be8c"   # Nord Green - Excelente
elif (( PERCENTAGE >= 85 )); then
  COLOR="0xff8fbcbb"   # Nord Cyan claro - Muy bueno
elif (( PERCENTAGE >= 75 )); then
  COLOR="0xff88c0d0"   # Nord Frost Blue - Bueno
elif (( PERCENTAGE >= 65 )); then
  COLOR="0xff81a1c1"   # Nord Blue medio - Bueno
elif (( PERCENTAGE >= 55 )); then
  COLOR="0xff5e81ac"   # Nord Blue oscuro - Moderado
elif (( PERCENTAGE >= 45 )); then
  COLOR="0xff81a1c1"   # Nord Blue medio - Moderado
elif (( PERCENTAGE >= 35 )); then
  COLOR="0xffebcb8b"   # Nord Yellow - Advertencia
elif (( PERCENTAGE >= 25 )); then
  COLOR="0xffd08770"   # Nord Orange - Precaución
elif (( PERCENTAGE >= 15 )); then
  COLOR="0xffbf616a"   # Nord Red suave - Bajo
elif (( PERCENTAGE >= 5 )); then
  COLOR="0xffb48ead"   # Nord Purple - Crítico
else
  COLOR="0xff88c0d0"   # Nord Blue - Muy crítico (diferente del rojo para alertar)
fi

if [[ "$CHARGING" != "" ]]; then
  # Iconos para cargando
  if (( PERCENTAGE >= 90 )); then
    ICON="󰂅"
  elif (( PERCENTAGE >= 80 )); then
    ICON="󰂊"
  elif (( PERCENTAGE >= 70 )); then
    ICON="󰢞"
  elif (( PERCENTAGE >= 60 )); then
    ICON="󰂉"
  elif (( PERCENTAGE >= 50 )); then
    ICON="󰢝"
  elif (( PERCENTAGE >= 40 )); then
    ICON="󰂈"
  elif (( PERCENTAGE >= 30 )); then
    ICON="󰂇"
  elif (( PERCENTAGE >= 20 )); then
    ICON="󰂆"
  elif (( PERCENTAGE >= 10 )); then
    ICON="󰢜"
  else
    ICON="󰢟"
  fi
else
  # Iconos para no cargando
  if (( PERCENTAGE >= 90 )); then
    ICON="󰁹"
  elif (( PERCENTAGE >= 80 )); then
    ICON="󰂂"
  elif (( PERCENTAGE >= 70 )); then
    ICON="󰂀"
  elif (( PERCENTAGE >= 60 )); then
    ICON="󰁿"
  elif (( PERCENTAGE >= 50 )); then
    ICON="󰁾"
  elif (( PERCENTAGE >= 40 )); then
    ICON="󰁽"
  elif (( PERCENTAGE >= 30 )); then
    ICON="󰁼"
  elif (( PERCENTAGE >= 20 )); then
    ICON="󰁺"
  elif (( PERCENTAGE >= 10 )); then
    ICON="󰁺"
  else
    ICON="󰂎"
  fi
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"