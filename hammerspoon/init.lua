-- Hammerspoon: Super (⌥ Option) + scroll troca de área de trabalho no AeroSpace.
-- Criado em 2026-11-10. Guia: ~/Obsidian/Projetos/Mac - Tiling WM (AeroSpace).md
--   ⌥ + scroll para cima  → área de trabalho à esquerda (anterior)
--   ⌥ + scroll para baixo → área de trabalho à direita (próxima)

require("hs.ipc")        -- permite usar o comando `hs` no terminal

local AEROSPACE = "/opt/homebrew/bin/aerospace"
local COOLDOWN  = 0.35   -- segundos entre trocas (o trackpad manda muitos eventos por gesto)
local INVERTER  = false  -- troque para true se a direção ficar ao contrário

local ultimo = 0

-- A tarefa fica numa variável global: se fosse só local, o coletor de lixo
-- do Lua podia destruí-la antes de o `aerospace` rodar.
trocasFeitas = 0
function trocarWorkspace(direcao)
  trocasFeitas = trocasFeitas + 1
  -- --no-stdin: desde a v0.20 o AeroSpace recusa next/prev quando o stdin não é um terminal
  tarefaAerospace = hs.task.new(AEROSPACE, nil, { "workspace", "--wrap-around", "--no-stdin", direcao })
  tarefaAerospace:start()
end
local trocar = trocarWorkspace

-- Global, para o coletor de lixo do Lua não desligar o tap
superScroll = hs.eventtap.new({ hs.eventtap.event.types.scrollWheel }, function(e)
  local f = e:getFlags()
  -- só Option, sem Cmd/Ctrl/Shift (⌥⇧ + scroll continua livre para os apps)
  if not f.alt or f.cmd or f.ctrl or f.shift then return false end

  local dy = e:getProperty(hs.eventtap.event.properties.scrollWheelEventDeltaAxis1)
  if dy == 0 then return true end              -- scroll horizontal: só engole

  local agora = hs.timer.secondsSinceEpoch()
  if agora - ultimo < COOLDOWN then return true end
  ultimo = agora

  local paraCima = dy > 0
  if INVERTER then paraCima = not paraCima end
  trocar(paraCima and "prev" or "next")
  return true                                   -- não deixa o scroll chegar ao app
end)
superScroll:start()

-- Auto-arranjo do AeroSpace ao FECHAR/minimizar janelas (o AeroSpace só tem
-- callback para janela nova). Chama ~/.config/aerospace/arrange.sh no workspace focado.
local ARRANGE = os.getenv("HOME") .. "/.config/aerospace/arrange.sh"
arranjoTimer = nil
function agendarArranjo()
  if arranjoTimer then arranjoTimer:stop() end
  arranjoTimer = hs.timer.doAfter(0.3, function()
    tarefaArranjo = hs.task.new("/bin/zsh", nil, { ARRANGE })
    tarefaArranjo:start()
  end)
end
filtroJanelas = hs.window.filter.new(true)
filtroJanelas:subscribe({ hs.window.filter.windowDestroyed, hs.window.filter.windowMinimized }, agendarArranjo)

-- Segurar ⌥ (Super) sozinho liga o modo resize do AeroSpace (o mesmo do ⌥R);
-- soltar o ⌥ volta ao modo main. Os comandos rodam em fila, na ordem certa.
modoDesejado, modoAplicado, modoRodando = "main", "main", false
function aplicarModo()
  if modoRodando or modoDesejado == modoAplicado then return end
  modoRodando = true
  local alvo = modoDesejado
  tarefaModo = hs.task.new(AEROSPACE, function()
    modoAplicado, modoRodando = alvo, false
    aplicarModo()
  end, { "mode", alvo })
  tarefaModo:start()
end
superSegurado = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, function(e)
  local f = e:getFlags()
  local so_alt = f.alt and not (f.cmd or f.ctrl)
  local novo = so_alt and "resize" or "main"
  if novo ~= modoDesejado then modoDesejado = novo; aplicarModo() end
  return false
end)
superSegurado:start()

-- Recarrega este arquivo sozinho ao salvar
configWatcher = hs.pathwatcher.new(hs.configdir, function(arquivos)
  for _, a in ipairs(arquivos) do
    if a:sub(-4) == ".lua" then hs.reload() return end
  end
end):start()

hs.autoLaunch(true)
hs.alert.show("Hammerspoon: ⌥ + scroll troca de área de trabalho")
