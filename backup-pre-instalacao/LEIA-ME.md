# Backup de antes do AeroSpace (2026-11-10)

Estado do Mac antes de instalar o gerenciador de janelas em tiling (AeroSpace + JankyBorders).

| Arquivo | Conteúdo |
|---|---|
| `defaults/*.plist` | preferências exportadas com `defaults export`: Dock e Mission Control (`com.apple.dock`), Spaces, Stage Manager/tiling nativo (`com.apple.WindowManager`), atalhos do sistema (`com.apple.symbolichotkeys`), teclado (`com.apple.HIToolbox`), globais (`NSGlobalDomain`), acessibilidade |
| `dock-legivel.txt` | as preferências do Dock em texto, para consulta |
| `brew-formulae.txt`, `brew-casks.txt`, `brew-taps.txt` | o que estava instalado pelo Homebrew |
| `dot-config-listagem.txt` | conteúdo de `~/.config` antes da instalação |
| `restaurar.sh` | **desfaz tudo**: desinstala, manda as configs para a Lixeira e reimporta as preferências |

Antes da instalação não havia `~/.aerospace.toml`, yabai, skhd, SketchyBar nem nenhum app de janelas (Rectangle, Magnet etc.).

## Como voltar
```bash
zsh ~/Backups/2026-11-10-antes-aerospace/restaurar.sh
```
Depois faça logout e login.
