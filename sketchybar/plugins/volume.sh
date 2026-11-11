#!/bin/bash
# Volume do sistema (o evento volume_change entrega a porcentagem em $INFO)
if [ "$SENDER" = "volume_change" ]; then
  VOL="$INFO"
else
  VOL="$(osascript -e 'output volume of (get volume settings)')"
fi
if [ "$VOL" = "0" ] || [ "$VOL" = "missing value" ]; then
  sketchybar --set "$NAME" label="🔇"
else
  sketchybar --set "$NAME" label="🔊 $VOL%"
fi
