#!/bin/zsh
# Auto-arranjo do AeroSpace em layout "mestre + pilha" (criado em 2026-11-10).
#
#   1 janela  → ocupa a tela toda
#   2 janelas → lado a lado (mestre à direita)
#   3+        → mestre grande à DIREITA, as outras empilhadas na vertical à ESQUERDA
#
#   ┌────────┬─────────────┐
#   │ pilha1 │             │
#   ├────────┤   mestre    │
#   │ pilha2 │             │
#   └────────┴─────────────┘
#
# O mestre de cada workspace fica guardado em ~/.cache/aerospace-master/<ws>.
# Uma janela nova (ou trazida de outro workspace) entra no fim da pilha.
#
# Uso: arrange.sh [workspace]          (sem argumento: o workspace focado)
#      arrange.sh --promote            (a janela focada vira o mestre)

AS=/opt/homebrew/bin/aerospace
MFACT=0.55            # fração da largura ocupada pelo mestre
STATE=~/.cache/aerospace-master
mkdir -p $STATE

PROMOTE=0
if [[ $1 == --promote ]]; then PROMOTE=1; shift; fi
WS=${1:-$($AS list-workspaces --focused)}
[[ -z $WS ]] && exit 0

# Uma execução por vez (o AeroSpace pode disparar várias seguidas)
LOCK=$STATE/.lock
for i in {1..40}; do mkdir $LOCK 2>/dev/null && break; sleep 0.05; done
trap 'rmdir $LOCK 2>/dev/null' EXIT

# Janelas em tiling do workspace (ignora as flutuantes)
ids=(${(f)"$($AS list-windows --workspace "$WS" --format '%{window-id}|%{window-layout}' 2>/dev/null | grep -v '|floating' | cut -d'|' -f1)"})
n=${#ids}
(( n == 0 )) && { rm -f $STATE/$WS; exit 0; }

# Escolhe o mestre
if (( PROMOTE )); then
  master=$($AS list-windows --focused --format '%{window-id}')
else
  master=$(cat $STATE/$WS 2>/dev/null)
fi
if [[ -z $master || ${ids[(Ie)$master]} -eq 0 ]]; then
  master=${${(on)ids}[1]}   # sem mestre válido: a janela mais antiga
fi
echo $master > $STATE/$WS

# Achata a árvore: todas as janelas numa linha horizontal, na ordem atual
$AS flatten-workspace-tree --workspace "$WS"
$AS layout --window-id $master h_tiles 2>/dev/null
(( n == 1 )) && exit 0

# Leva o mestre para a ponta direita
for i in {1..$n}; do
  $AS move --window-id $master --boundaries workspace --boundaries-action stop right 2>/dev/null || break
done

if (( n >= 3 )); then
  # Ordem atual da pilha (tudo menos o mestre, da esquerda para a direita)
  stack=(${(f)"$($AS list-windows --workspace "$WS" --format '%{window-id}|%{window-layout}' | grep -v '|floating' | cut -d'|' -f1)"})
  stack=(${stack:#$master})
  # A 2ª janela junta-se à 1ª num container vertical; as seguintes entram nele
  $AS join-with --window-id ${stack[2]} left
  for w in ${stack[3,-1]}; do
    $AS move --window-id $w left
  done
fi

$AS balance-sizes --workspace "$WS"

# Mestre um pouco maior que a pilha
W=$(osascript -l JavaScript -e 'ObjC.import("AppKit"); $.NSScreen.mainScreen.visibleFrame.size.width' 2>/dev/null)
if [[ -n $W ]]; then
  $AS resize --window-id $master width $(printf "%.0f" $(( W * MFACT ))) 2>/dev/null
fi
exit 0
