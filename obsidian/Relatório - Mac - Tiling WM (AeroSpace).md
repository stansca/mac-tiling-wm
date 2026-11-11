---
tipo: relatorio
categoria: projeto
fonte: "[[Projetos/Mac - Tiling WM (AeroSpace)]]"
status: pausado
criado: 2026-11-10
atualizado: 2026-11-11
tags: [relatorio, projeto, mac, ferramentas, tiling]
---

# Relatório: tiling no Mac (AeroSpace)

> [!info] Ficha
> **Fonte:** [[Projetos/Mac - Tiling WM (AeroSpace)]] · **Status:** pausado; o Mac voltou ao padrão da Apple · **Repositório:** `~/Desktop/projetinhos/mac-tiling-wm` (github.com/stansca/mac-tiling-wm) · **Backup:** `~/Backups/2026-11-10-antes-aerospace/` · **Catálogo:** [[00 - Catálogo de Relatórios]]

## 1. Sumário
O MacBook Pro M2 ganhou tiling no estilo do Hyprland do PC principal: AeroSpace + JankyBorders, com Option (⌥) no lugar da Super. A instalação é reversível por script. O guia completo de atalhos está na [[Projetos/Mac - Tiling WM (AeroSpace)#Guia de atalhos|nota do projeto]].

## 2. Objetivo e contexto
Ter no Mac o mesmo fluxo de trabalho do Hyprland (workspaces numerados, tiling automático, tudo pelo teclado) sem desativar proteções do macOS (SIP).

## 3. Solução e arquitetura
- **AeroSpace 0.21.3:** tiling em árvore estilo i3, com workspaces próprios.
- **JankyBorders:** borda azul na janela focada, iniciada pelo AeroSpace.
- **Hammerspoon:** ⌥ + scroll troca de workspace (anterior/próximo, com volta do fim ao começo).
- **Atalhos pessoais:** ⌥Q fecha (e encerra o app na última janela), ⌥W abre o Zen, ⌥1–0 vai aos workspaces 1–10.
- **Auto-arranjo mestre + pilha:** `~/.config/aerospace/arrange.sh` deixa o mestre grande à direita e as outras empilhadas à esquerda, a cada janela nova, fechada ou movida. ⌥⇧W/⌥⇧S levam a janela para a área à esquerda/direita e rearranjam.
- **Ajustes do macOS:** Mission Control agrupando por app, Spaces sem reordenação automática, ⌃⌘ + arrastar para mover janelas.

## 4. Desenvolvimento
- **10/11/2026:** backup → instalação pelo Homebrew → configuração → guia de atalhos.
- **10/11/2026:** auto-arranjo mestre + pilha por script, com gatilhos no AeroSpace e no Hammerspoon.

## 5. Resultados e testes
- Com a permissão de Acessibilidade dada, o AeroSpace carregou o `~/.aerospace.toml`. O `reload-config` não deu erro, a CLI lista as janelas e o borders está rodando. O ⌥ + scroll funciona depois da correção do `--no-stdin`.
- Auto-arranjo testado com Terminais no workspace 9: pilha + mestre, fechar o mestre, janela nova e ⌥⇧W/⌥⇧S, todos certos.

## 6. Decisões técnicas
- **AeroSpace × yabai:** sem SIP desativado, o yabai perde recursos.
- **Option como modificador** e atalhos nos padrões do Hyprland.
- **Auto-arranjo por script:** o AeroSpace não tem layout mestre nativo; o script remonta a árvore pela CLI.
- **SketchyBar adiada:** exige esconder a barra de menus.

## 7. Estado atual e próximos passos
> [!warning] Pausado em 2026-11-11
> O usuário pediu para voltar ao padrão da Apple. O `restaurar.sh` desinstalou o AeroSpace, o JankyBorders e o Hammerspoon e reimportou as preferências. A última configuração está no repositório, pronta para reinstalar.

- [x] Permissão de Acessibilidade do AeroSpace
- [x] Permissão de Acessibilidade do Hammerspoon + ⌥ + scroll testado
- [ ] Logout/login (para o padrão da Apple valer por completo)
- [ ] Retomar a partir do repositório `mac-tiling-wm`
- [ ] Importar o resto dos atalhos do `hyprland.conf`
- [ ] (Opcional) SketchyBar, Ghostty, Raycast

## 8. Arquivos e referências
- `~/.aerospace.toml`; documentação: https://nikitabobko.github.io/AeroSpace/guide
- Backup e restauração: `~/Backups/2026-11-10-antes-aerospace/LEIA-ME.md`, `restaurar.sh`

## Histórico do relatório
- 2026-11-10: relatório criado.
- 2026-11-10: atalhos pessoais (Q, W, 0, scroll) e Hammerspoon.
- 2026-11-10: ⌥ + scroll testado e funcionando.
- 2026-11-10: auto-arranjo mestre + pilha e atalhos ⌥⇧W/⌥⇧S.
- 2026-11-10: rearranjo manual passou para ⌥ + clique (Hammerspoon).
- 2026-11-11: modo resize liga ao segurar ⌥ e desliga ao soltar (Hammerspoon).
- 2026-11-11: ⌥ + clique removido (bugava); rearranjo manual voltou a ser ⌥⇧R.
- 2026-11-11: volta ao padrão da Apple; configuração arquivada no repositório `mac-tiling-wm` (GitHub).
