#!/bin/bash
# Destaca o workspace em foco e esmaece os vazios.
# Argumentos: <id do workspace> <cor de destaque> <cor do texto> <cor esmaecida>
SID="$1"; ACCENT="$2"; TEXT="$3"; DIM="$4"

FOCADO="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused </dev/null)}"

if [ "$SID" = "$FOCADO" ]; then
  sketchybar --set "$NAME" background.drawing=on label.color="$ACCENT"
elif [ -n "$(aerospace list-windows --workspace "$SID" </dev/null)" ]; then
  sketchybar --set "$NAME" background.drawing=off label.color="$TEXT"
else
  sketchybar --set "$NAME" background.drawing=off label.color="$DIM"
fi
