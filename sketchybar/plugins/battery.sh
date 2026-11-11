#!/bin/bash
# Bateria: porcentagem, com ⚡ quando está na tomada
INFO_BAT="$(pmset -g batt)"
PCT="$(echo "$INFO_BAT" | grep -Eo '[0-9]+%' | head -1)"
[ -z "$PCT" ] && exit 0

if echo "$INFO_BAT" | grep -q "AC Power"; then
  sketchybar --set "$NAME" label="⚡ $PCT"
else
  sketchybar --set "$NAME" label="🔋 $PCT"
fi
