#!/bin/bash
# Data e hora em português (ex.: ter 10/11 23:45)
sketchybar --set "$NAME" label="$(LC_TIME=pt_BR.UTF-8 date '+%a %d/%m  %H:%M')"
