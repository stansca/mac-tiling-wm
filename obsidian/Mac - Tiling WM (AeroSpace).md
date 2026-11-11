---
tipo: projeto
status: pausado
caminho: ~/Desktop/projetinhos/mac-tiling-wm
stack: [AeroSpace 0.21.3, JankyBorders, Homebrew, macOS 26]
criado: 2026-11-10
atualizado: 2026-11-11
tags: [projeto, mac, ferramentas, tiling]
---

# Mac — Tiling WM (AeroSpace)

Relatório: [[Relatório - Mac - Tiling WM (AeroSpace)]]

> [!warning] Pausado em 2026-11-11
> O Mac voltou ao padrão da Apple (`restaurar.sh` do backup). Toda a configuração (última versão, scripts, histórico e backup) está guardada em `~/Desktop/projetinhos/mac-tiling-wm` e em github.com/stansca/mac-tiling-wm, para retomar depois. Para reinstalar, siga o README do repositório.

## Resumo
Gerenciador de janelas em tiling no MacBook Pro M2, imitando o **Hyprland** do PC principal.
- **AeroSpace:** tiling em árvore estilo i3, workspaces próprios, não precisa desativar o SIP.
- **JankyBorders:** borda azul na janela focada.
- **Modificador:** a tecla **Option (⌥)** faz o papel da Super.
- **Atalhos:** os **pessoais do usuário** (Q fechar, W Zen, scroll e 0–9 para os workspaces) por cima dos padrões do Hyprland.
- **Hammerspoon:** cuida de ⌥ + scroll, porque o AeroSpace não reconhece scroll como atalho.

## Guia de atalhos

> [!tip] Regra geral
> **⌥ + tecla** age sobre a janela ou o workspace; **⌥ ⇧ + tecla** move coisas. As teclas valem pela posição física (QWERTY), então funcionam no teclado ABNT2.

### Apps e janelas
| Atalho | Ação | Equivalente no Hyprland |
|---|---|---|
| ⌥ Q | **fechar** a janela; se for a última do app, encerra o app | Super+Q (pessoal) |
| ⌥ W | abrir uma **janela nova do Zen** no workspace atual | Super+W (pessoal) |
| ⌥ Enter | abrir Terminal | Super+Enter |
| ⌥ E | abrir Finder na pasta pessoal | Super+E (arquivos) |
| ⌥ V | alternar flutuante ↔ tiling | Super+V (togglefloating) |
| ⌥ F | tela cheia (dentro do AeroSpace) | fullscreen |
| ⌥ T | alternar divisão horizontal ↔ vertical | Super+J (togglesplit) |
| ⌥ A | layout acordeão (janelas empilhadas, como abas). **Para voltar ao tiling: ⌥ T** | group / tabbed |
| ⌘ Espaço | Spotlight (lançador) | Super+R (wofi/rofi) |

### Foco e movimento
| Atalho | Ação |
|---|---|
| ⌥ ← ↓ ↑ → ou ⌥ H J K L | redimensionar (o modo resize liga sozinho enquanto o ⌥ está apertado, veja abaixo) |
| clique na janela | focar a janela |
| ⌥ ⇧ ← ↓ ↑ → ou ⌥ ⇧ H J K L | mover a janela nessa direção |
| ⌥ - / ⌥ = | diminuir / aumentar a janela |
| arrastar a borda entre duas janelas | redimensionar com o mouse (só no layout tiles) |
| ⌃ ⌘ + arrastar com o mouse | mover qualquer janela pelo meio (como Super+arrastar). Vale depois de logout/login |

### Auto-arranjo (mestre + pilha)
Toda janela nova, fechada ou movida faz o workspace se rearranjar sozinho:

```
1 janela: tela toda   2: lado a lado   3+:  ┌──────┬──────────┐
                                           │ pilha│          │
                                           ├──────┤  mestre  │
                                           │ pilha│  (55 %)  │
                                           └──────┴──────────┘
```
A janela nova (ou trazida de outro workspace) entra no **fim da pilha**; o mestre continua o mesmo.

| Atalho | Ação |
|---|---|
| ⌥ ⇧ W | levar a janela para a área de trabalho **à esquerda** (o foco vai junto) e rearranjar as duas |
| ⌥ ⇧ S | levar a janela para a área de trabalho **à direita** (o foco vai junto) e rearranjar as duas |
| ⌥ ⇧ Enter | a janela focada vira o **mestre** (retângulo grande) |
| ⌥ ⇧ R | rearranjar o workspace atual na mão |
| ⌥ ⇧ 1 … 0 | mandar para o workspace N, já rearranjando |

### Workspaces
| Atalho | Ação | Hyprland |
|---|---|---|
| ⌥ 1 … ⌥ 9, ⌥ 0 | ir para o workspace 1–9; o 0 vai para o **10** | Super+1–0 |
| ⌥ ⇧ 1 … ⌥ ⇧ 0 | mandar a janela para o workspace 1–10 | Super+Shift+1–0 |
| ⌥ + scroll para cima | área de trabalho **à esquerda** (anterior; do 1 vai para o 10) | Super+scroll (pessoal) |
| ⌥ + scroll para baixo | área de trabalho **à direita** (próxima; do 10 volta para o 1) | Super+scroll (pessoal) |
| ⌥ , / ⌥ . | o mesmo que o scroll, pelo teclado | — |
| ⌥ S | abrir o workspace especial "S" (scratchpad) | Super+S |
| ⌥ ⇧ ; e depois S | mandar a janela para o "S" (o ⌥ ⇧ S agora é "área à direita") | Super+Shift+S |
| ⌥ Tab | voltar ao workspace anterior | workspace previous |
| ⌥ ⇧ Tab | mandar o workspace para o outro monitor | movecurrentworkspacetomonitor |

### Modo resize (⌥ R), como o submap do Hyprland
**Segurar ⌥ liga o modo; soltar desliga** (Hammerspoon, `flagsChanged`). Enquanto o ⌥ está apertado, ⌥ + tecla:

| Tecla | Ação |
|---|---|
| H / ← | estreitar |
| L / → | alargar |
| K / ↑ | encurtar |
| J / ↓ | alongar |
| B | igualar o tamanho de todas |
| Esc / Enter | sair do modo |

### Modo serviço (⌥ ⇧ ;)
| Tecla | Ação |
|---|---|
| Esc | recarregar a config e sair (a config também recarrega sozinha ao salvar) |
| R | resetar o layout do workspace (achatar a árvore) |
| S | mandar a janela para o workspace especial S |
| F | alternar flutuante ↔ tiling |
| Backspace | fechar todas as janelas menos a atual |
| ⌥ ⇧ H J K L | juntar a janela com a vizinha num container |

### Apps que abrem flutuando
Ajustes do Sistema, Calculadora, Monitor de Atividade e Utilitário de Compressão. Para acrescentar outros, crie um bloco `[[on-window-detected]]` com o `app-id`. Veja o id com `aerospace list-apps`.

> [!warning] Teclado ABNT2
> No layout Brazilian - Pro, ⌥ + letra ou número digita símbolos (¹ ² ³ £ ¢ ¬ …). Com o AeroSpace ativo, esses atalhos passam a ser dele. As letras acentuadas e o ç continuam normais, porque têm teclas próprias. Se faltar algum símbolo, desative o atalho correspondente no `~/.aerospace.toml`.

## Stack e arquitetura
- **Config:** `~/.aerospace.toml`: gaps de 8 px, normalização, `auto-reload-config`, `start-at-login`, modos main/resize/service, regras de flutuar.
- **Borda:** o `borders` (JankyBorders) é iniciado pelo `after-startup-command` do AeroSpace, cor `0xff89b4fa` e largura de 5 px.
- **Workspaces:** `persistent-workspaces` de 1 a 10, para o next/prev andar em ordem.
- **Auto-arranjo:** `~/.config/aerospace/arrange.sh` e `move-and-arrange.sh`.
  - O `arrange.sh` achata a árvore, leva o mestre para a direita, junta a pilha num container vertical (`join-with` + `move left`), equilibra e dá 55 % da largura ao mestre (`MFACT`).
  - O mestre de cada workspace fica em `~/.cache/aerospace-master/<ws>`; sem mestre válido, vira a janela mais antiga.
  - Gatilhos: janela nova → último `[[on-window-detected]]` (`if = 'true'`); fechar/minimizar → `hs.window.filter` no Hammerspoon; ⌥V e os atalhos de mover chamam o script.
  - Janelas flutuantes ficam de fora.
- **Scroll:** `~/.hammerspoon/init.lua`.
  - Um `hs.eventtap` de scroll, ativo só com ⌥, chama `aerospace workspace --wrap-around prev|next`.
  - Intervalo de 0,35 s entre trocas (o trackpad manda muitos eventos por gesto). Se a direção ficar invertida, mude `INVERTER = true`.
  - O arquivo recarrega sozinho ao salvar, e o Hammerspoon abre no login.
- **Ajustes do macOS aplicados:**
  - `com.apple.dock expose-group-apps = true`: o Mission Control agrupa por app, como o AeroSpace recomenda;
  - `com.apple.dock mru-spaces = false`: o macOS não reordena os Spaces;
  - `NSWindowShouldDragOnGesture = true`: ⌃⌘ + arrastar move janelas.
- **Instalação:**
  - `brew install --cask nikitabobko/tap/aerospace`;
  - `brew trust --formula felixkratz/formulae/borders` + `brew install borders`;
  - `brew install --cask hammerspoon`.

## Como rodar
```bash
open -a AeroSpace                    # inicia (já abre sozinho no login)
aerospace list-workspaces --all      # testa a CLI
aerospace list-apps                  # app-ids para regras de janela
aerospace reload-config              # recarrega a config
# desfazer tudo:
zsh ~/Backups/2026-11-10-antes-aerospace/restaurar.sh
```

## Decisões
- **AeroSpace em vez de yabai:** não exige desativar o SIP e tem a lógica mais próxima do Hyprland.
- **Option como modificador:** a tecla Cmd conflita com os atalhos de todos os apps.
- **Base nos padrões do Hyprland,** com os atalhos pessoais por cima:
  - Q fecha a janela e encerra o app se for a última (`close --quit-if-last-window`);
  - W abre o Zen;
  - o terminal foi para Enter;
  - 0 = workspace 10.
- **`--no-stdin` na chamada do Hammerspoon:** desde a v0.20, o `aerospace workspace next/prev` recusa rodar sem terminal no stdin (erro "Implicit stdin is detected").
- **⌥W com `open -na Zen --args --new-window`:** o `open -a Zen` só ativava o Zen já aberto e o AeroSpace pulava para o workspace da janela antiga.
- **Hammerspoon para o scroll:** o AeroSpace não tem atalho de mouse. Alternativa paga: BetterTouchTool.
- **SketchyBar não instalada:** exige esconder a barra de menus do macOS. Fica como opção.
- **Backup completo antes de instalar:** `~/Backups/2026-11-10-antes-aerospace/` (preferências exportadas, lista do Homebrew, `restaurar.sh`).

- **Auto-arranjo por script em vez de trocar de WM:** o AeroSpace não tem layout mestre/dwindle nativo; o script remonta a árvore com os comandos da CLI (`--window-id`), sem precisar de foco.
- **⌥⇧W/⌥⇧S seguem a janela** (como o `movetoworkspace` do Hyprland). O ⌥⇧S tomou o lugar do "mandar para o S", que foi para o modo serviço.

## Pendências
- [x] Dar a permissão de Acessibilidade ao AeroSpace (feito; config carregada e `reload-config` sem erros)
- [x] Dar a permissão de Acessibilidade ao Hammerspoon
- [x] Testar o ⌥ + scroll (funcionando, direção certa no trackpad)
- [ ] Fazer logout/login (para o padrão da Apple valer por completo)
- [ ] Retomar: reinstalar a partir do repositório `mac-tiling-wm`
- [ ] Importar os atalhos do `hyprland.conf` do PC principal (`~/.config/hypr/hyprland.conf`)
- [ ] (Opcional) SketchyBar como barra estilo Waybar, escondendo a barra de menus
- [ ] (Opcional) Terminal melhor (Ghostty ou kitty) e lançador (Raycast)

## Registro de sessões
### 2026-11-10
- Backup das preferências (Dock, Spaces, WindowManager, atalhos, teclado, globais) e da lista do Homebrew, com script de restauração.
- Instalados o AeroSpace 0.21.3 e o JankyBorders. A fórmula do borders foi liberada sozinha com `brew trust --formula`, com a autorização do usuário.
- `~/.aerospace.toml` criado com atalhos no padrão do Hyprland e o guia acima.
- Atalhos pessoais: ⌥Q fecha, ⌥W abre o Zen, ⌥0 vai ao workspace 10, ⌥ + scroll troca de workspace. Hammerspoon instalado para o scroll; `restaurar.sh` atualizado para desinstalá-lo também.
- Scroll testado: a 1ª versão não trocava por causa do erro de stdin do AeroSpace; corrigido com `--no-stdin` e a tarefa guardada em variável global. Funcionando.

### 2026-11-10 — janelas não se arranjavam
- Causa: o workspace 1 estava em **h_accordion** (provavelmente um ⌥A sem querer), então as janelas ficavam empilhadas e o redimensionamento com o mouse não funcionava. Voltado para tiles com `flatten-workspace-tree` + `layout tiles horizontal` + `balance-sizes`.
- ⌥W agora abre uma janela nova do Zen no workspace atual (`open -na Zen --args --new-window`). Testado no workspace 3.

### 2026-11-10 — auto-arranjo mestre + pilha
- Criados `arrange.sh` e `move-and-arrange.sh`; atalhos ⌥⇧W (área à esquerda), ⌥⇧S (área à direita), ⌥⇧Enter (promover a mestre), ⌥⇧R; ⌥⇧1–0 também rearranjam.
- Hammerspoon rearranja ao fechar/minimizar janela.
- Modo resize ligado **segurando ⌥** (Hammerspoon troca `aerospace mode resize`/`main` em fila ao apertar/soltar). O modo resize ganhou as variantes `alt-*` e uma cópia dos outros atalhos do main; o foco por ⌥ + hjkl/setas fica indisponível (foca-se clicando). Testado com ⌥ simulado.
- O rearranjo por **⌥ + clique** foi testado e removido (estava bugando); voltou a ser ⌥⇧R.
- Testado no workspace 9 com Terminais: 3 janelas na pilha + mestre à direita; fechar o mestre promove a mais antiga; janela nova entra no fim da pilha; ⌥⇧W/⌥⇧S levam a janela e rearranjam os dois lados.
- Backup da config anterior: `~/.config/aerospace/aerospace.toml.bak-2026-11-10-antes-autoarranjo`.

### 2026-11-11 — volta ao padrão da Apple e arquivamento
- ⌥ + clique removido (bugava); o rearranjo manual voltou a ser ⌥⇧R.
- Pesquisa de navegador para tiling: sugerido o modo compacto do Zen (⌥⌘C) e, como alternativa, o qutebrowser. Nada foi instalado.
- A pedido do usuário: `restaurar.sh` rodado. AeroSpace, JankyBorders e Hammerspoon desinstalados; configs na Lixeira; preferências do macOS reimportadas.
- Tudo guardado no repositório `mac-tiling-wm`: a última versão de `aerospace.toml` e `init.lua` (reconstruída), os scripts `arrange.sh` e `move-and-arrange.sh` (recriados), o histórico das versões da config, a SketchyBar e o backup de antes da instalação (sem os `.plist`, que ficam só no Mac).
