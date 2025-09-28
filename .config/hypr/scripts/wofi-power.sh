#!/bin/bash

set -e

menu=('Exit' 'Lock' 'Reboot' 'Poweroff')
comandos=(
  'hyprctl dispatch exit'
  'loginctl lock-session'
  'systemctl reboot'
  'systemctl poweroff'
)

resposta=$(printf '%s\n' "${menu[@]}" | wofi --show dmenu)

for i in "${!menu[@]}"; do
  if [[ "${menu[i]}" == "$resposta" ]]; then
    eval "${comandos[i]}"
    break
  fi
done
