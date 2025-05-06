#!/bin/sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

if (( PERCENTAGE >= 40 )); then
  COLOR="0xffb8bb26" # Green
elif (( PERCENTAGE >= 20 )); then
  COLOR="0xfffabd2f" # Yellow
elif (( PERCENTAGE >= 15 )); then
  COLOR="0xffffa500" # Orange
else
  COLOR="0xfffb4934" # Red
fi

if [[ "$CHARGING" != "" ]]; then
  ICON=""
elif (( PERCENTAGE >= 90 )); then
  ICON=""
elif (( PERCENTAGE >= 60 )); then
  ICON=""
elif (( PERCENTAGE >= 30 )); then
  ICON=""
elif (( PERCENTAGE >= 10 )); then
  ICON=""
else
  ICON=""
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"