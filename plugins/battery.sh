#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Paleta neón
if (( PERCENTAGE >= 90 )); then
  COLOR="0xff00ffff"   # Electric Cyan
elif (( PERCENTAGE >= 70 )); then
  COLOR="0xff00ffff"   # Electric Cyan
elif (( PERCENTAGE >= 50 )); then
  COLOR="0xff00ffff"   # Electric Cyan
elif (( PERCENTAGE >= 30 )); then
  COLOR="0xffff2eff"   # Neon Magenta
elif (( PERCENTAGE >= 10 )); then
  COLOR="0xfff9ff00"   # Acid Yellow
else
  COLOR="0xfff9ff00"   # Acid Yellow
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