#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi


if (( PERCENTAGE >= 95 )); then
  COLOR="0xffa3be8c"
elif (( PERCENTAGE >= 85 )); then
  COLOR="0xff8fbcbb"
elif (( PERCENTAGE >= 75 )); then
  COLOR="0xff88c0d0"
elif (( PERCENTAGE >= 65 )); then
  COLOR="0xff81a1c1"
elif (( PERCENTAGE >= 55 )); then
  COLOR="0xff5e81ac"
elif (( PERCENTAGE >= 45 )); then
  COLOR="0xff81a1c1"
elif (( PERCENTAGE >= 35 )); then
  COLOR="0xffebcb8b"
elif (( PERCENTAGE >= 25 )); then
  COLOR="0xffd08770"
elif (( PERCENTAGE >= 15 )); then
  COLOR="0xffbf616a"
elif (( PERCENTAGE >= 5 )); then
  COLOR="0xffb48ead"
else
  COLOR="0xff88c0d0"
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