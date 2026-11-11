#!/bin/zsh
# Move a janela focada para outro workspace e rearranja os dois (criado em 2026-11-10).
#   move-and-arrange.sh prev|next        → área à esquerda/direita, o foco vai junto
#   move-and-arrange.sh <nome> [follow]  → workspace pelo nome (foco só vai junto com "follow")
# A janela entra no fim da pilha do workspace de destino; o mestre de lá continua o mesmo.

AS=/opt/homebrew/bin/aerospace
ARR=~/.config/aerospace/arrange.sh

src=$($AS list-workspaces --focused)
$AS list-windows --focused --count 2>/dev/null | grep -qx 0 && exit 0

case $1 in
  prev|next)
    $AS move-node-to-workspace --wrap-around --no-stdin --focus-follows-window $1 || exit 0
    dst=$($AS list-workspaces --focused) ;;
  *)
    [[ $1 == $src ]] && exit 0
    if [[ $2 == follow ]]; then
      $AS move-node-to-workspace --focus-follows-window -- "$1" || exit 0
    else
      $AS move-node-to-workspace -- "$1" || exit 0
    fi
    dst=$1 ;;
esac

$ARR "$dst"
$ARR "$src"
