#!/bin/zsh
# Desfaz a instalação do AeroSpace + JankyBorders e volta as preferências de 2026-11-10.
# Uso: zsh ~/Backups/2026-11-10-antes-aerospace/restaurar.sh
set -u
B="${0:A:h}"

echo "1/4 Fechando AeroSpace e borders..."
osascript -e 'quit app "AeroSpace"' 2>/dev/null
brew services stop borders 2>/dev/null
pkill -x borders 2>/dev/null

echo "2/4 Desinstalando pelo Homebrew..."
brew uninstall --cask aerospace 2>/dev/null
brew uninstall borders 2>/dev/null
brew services stop sketchybar 2>/dev/null
brew uninstall sketchybar 2>/dev/null
osascript -e 'quit app "Hammerspoon"' 2>/dev/null
brew uninstall --cask hammerspoon 2>/dev/null
brew untap nikitabobko/tap 2>/dev/null
brew untap FelixKratz/formulae 2>/dev/null

echo "3/4 Movendo configs para a Lixeira..."
for f in ~/.aerospace.toml ~/.config/borders ~/.config/sketchybar ~/.hammerspoon; do
  [ -e "$f" ] && mv "$f" ~/.Trash/ && echo "   -> $f"
done

echo "4/4 Restaurando preferências do sistema..."
for p in "$B"/defaults/*.plist; do
  d="${p:t:r}"
  defaults import "$d" "$p" && echo "   ok $d"
done
killall Dock 2>/dev/null

echo "Pronto. Saia da sessão (logout) e entre de novo para tudo voltar ao normal."
echo "A permissão de Acessibilidade do AeroSpace pode ser removida em Ajustes > Privacidade e Segurança > Acessibilidade."
