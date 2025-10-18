#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi


if (( PERCENTAGE >= 95 )); then
  COLOR="0xff00ff00"  # Verde brillante para batería llena
elif (( PERCENTAGE >= 85 )); then
  COLOR="0xff66ff66"  # Verde claro
elif (( PERCENTAGE >= 75 )); then
  COLOR="0xff99ff99"  # Verde más claro
elif (( PERCENTAGE >= 65 )); then
  COLOR="0xffccffcc"  # Verde muy claro
elif (( PERCENTAGE >= 55 )); then
  COLOR="0xffffffff"  # Blanco
elif (( PERCENTAGE >= 45 )); then
  COLOR="0xffffcc99"  # Amarillo muy claro
elif (( PERCENTAGE >= 35 )); then
  COLOR="0xffff9900"  # Amarillo/naranja
elif (( PERCENTAGE >= 25 )); then
  COLOR="0xffff6600"  # Naranja
elif (( PERCENTAGE >= 15 )); then
  COLOR="0xffff3300"  # Rojo/naranja
elif (( PERCENTAGE >= 5 )); then
  COLOR="0xffff0000"  # Rojo
else
  COLOR="0xffaa0000"  # Rojo oscuro para batería crítica
fi

if [[ "$CHARGING" != "" ]]; then
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