# mac-tiling-wm

Tiling no estilo **Hyprland** para macOS (MacBook Pro M2, macOS 26): AeroSpace + JankyBorders + Hammerspoon, com **Option (⌥)** no papel da tecla Super.

> **Status: pausado (2026-11-11).** O Mac voltou ao padrão da Apple. Este repositório guarda a última configuração, para retomar depois.

## Relatório

### O que foi feito (10–11/11/2026)
1. **Backup antes de instalar** ([`backup-pre-instalacao/`](backup-pre-instalacao/)): lista do Homebrew e `restaurar.sh`, que desfaz tudo. As preferências exportadas (`defaults/*.plist`) ficaram só no Mac, em `~/Backups/2026-11-10-antes-aerospace/`.
2. **AeroSpace 0.21.3:** tiling em árvore estilo i3, workspaces próprios e sem desativar o SIP. Atalhos no padrão do Hyprland, mais os atalhos pessoais:
   - ⌥Q fecha a janela (e encerra o app se for a última);
   - ⌥W abre uma janela nova do Zen;
   - ⌥Enter abre o Terminal;
   - ⌥1–0 vai aos workspaces 1–10.
3. **JankyBorders:** borda azul na janela focada.
4. **Hammerspoon:** ⌥ + scroll troca de workspace, porque o AeroSpace não reconhece atalhos de mouse.
5. **Auto-arranjo "mestre + pilha"** ([`aerospace/arrange.sh`](aerospace/arrange.sh)):
   ```
   1 janela: tela toda   2: lado a lado   3+: ┌──────┬──────────┐
                                              │ pilha│          │
                                              ├──────┤  mestre  │
                                              │ pilha│  (55 %)  │
                                              └──────┴──────────┘
   ```
   - **Janela nova:** dispara pelo último `[[on-window-detected]]` do AeroSpace.
   - **Fechar ou minimizar:** dispara pelo `hs.window.filter` do Hammerspoon.
   - **Onde entra:** a janela nova vai para o fim da pilha, e o mestre continua o mesmo.
   - **Como funciona:** o script achata a árvore, leva o mestre para a direita, junta a pilha num container vertical (`join-with` + `move left`) e dá 55 % da largura ao mestre (`MFACT`).
6. **Atalhos do auto-arranjo:**

   | Atalho | Ação |
   |---|---|
   | ⌥⇧W / ⌥⇧S | levar a janela para o workspace à esquerda/direita (o foco vai junto) e rearranjar os dois ([`move-and-arrange.sh`](aerospace/move-and-arrange.sh)) |
   | ⌥⇧Enter | a janela focada vira o mestre |
   | ⌥⇧R | rearranjar na mão |
   | ⌥⇧1–0 | mandar para o workspace N, já rearranjando |

7. **Modo resize segurando ⌥:** o Hammerspoon liga `aerospace mode resize` ao apertar o ⌥ e volta ao `main` ao soltar. Com o ⌥ apertado, ⌥ + H/J/K/L/setas redimensionam e ⌥B iguala os tamanhos. O modo resize tem uma cópia dos outros atalhos do main.

### O que foi testado e descartado
- **⌥ + clique para rearranjar** (eventtap de `leftMouseDown`): bugava e foi removido.
- **Resize direto no ⌥, com o foco em ⌃⌥:** o usuário não quis.

### Problemas conhecidos / para retomar
- Com o modo resize preso ao ⌥, o foco por ⌥ + H/J/K/L/setas fica indisponível (foca-se clicando). Vale repensar.
- Uma tecla apertada logo depois do ⌥ pode chegar antes de o modo trocar.
- O `arrange.sh` achata a árvore, então divisões montadas na mão se perdem.
- Navegador para tiling: testar o modo compacto do Zen (⌥⌘C) ou o qutebrowser.
- SketchyBar ([`sketchybar/`](sketchybar/)): a config está pronta, mas nunca foi instalada.

## Estrutura
| Caminho | Destino no Mac |
|---|---|
| `aerospace/aerospace.toml` | `~/.aerospace.toml` (última versão) |
| `aerospace/arrange.sh`, `move-and-arrange.sh` | `~/.config/aerospace/` |
| `hammerspoon/init.lua` | `~/.hammerspoon/init.lua` (última versão) |
| `sketchybar/` | `~/.config/sketchybar/` |
| `historico/` | versões anteriores do `aerospace.toml` |
| `backup-pre-instalacao/` | backup e `restaurar.sh` (desfaz tudo) |
| `obsidian/` | nota do projeto e relatório do vault (guia completo de atalhos) |

## Como reinstalar
```bash
brew install --cask nikitabobko/tap/aerospace hammerspoon
brew trust --formula felixkratz/formulae/borders && brew install borders
cp aerospace/aerospace.toml ~/.aerospace.toml
mkdir -p ~/.config/aerospace ~/.hammerspoon
cp aerospace/*.sh ~/.config/aerospace/ && chmod +x ~/.config/aerospace/*.sh
cp hammerspoon/init.lua ~/.hammerspoon/init.lua
open -a AeroSpace && open -a Hammerspoon
```
Depois, dê a permissão de Acessibilidade ao AeroSpace e ao Hammerspoon. Os caminhos no `aerospace.toml` assumem o usuário `joaoscacchetti`; ajuste se mudar.

Para desfazer: `zsh backup-pre-instalacao/restaurar.sh` e depois logout/login.
