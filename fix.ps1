# fix.ps1 — Corrige settings.json e loop.md
# Cole e rode no Warp:
#   cd "$env:USERPROFILE\Desktop\claude-overnight"
#   .\fix.ps1

Write-Host "Corrigindo settings.json..." -ForegroundColor Cyan

$settingsPath = "$env:USERPROFILE\.claude\settings.json"
$content = Get-Content $settingsPath -Raw -Encoding UTF8
$json = $content | ConvertFrom-Json

# Adicionar Agent Teams ao env
$json.env | Add-Member -NotePropertyName "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" -NotePropertyValue "1" -Force

# Salvar
$json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
Write-Host "[OK] Agent Teams habilitado no settings.json" -ForegroundColor Green

# Corrigir loop.md com encoding correto
Write-Host "Reescrevendo loop.md com encoding correto..." -ForegroundColor Cyan

$loopContent = @"
# Loop Noturno Autonomo (Global)

Voce e o gerente noturno deste projeto. Trabalhe de forma 100% autonoma.

## A cada iteracao:

### 1. Entenda o contexto
- Leia CLAUDE.md para entender o projeto, stack e convencoes
- Leia TODO.md para ver tarefas pendentes (se existir)
- Leia OVERNIGHT-LOG.md para saber o que ja foi feito nesta sessao (se existir)
- Rode git status e git log --oneline -5

### 2. Escolha o que trabalhar
- Tarefas marcadas [TONIGHT] ou [PRIORITY] no TODO.md primeiro
- Se nao houver TODO.md, continue qualquer trabalho inacabado da conversa
- Se tudo estiver completo, faca melhorias: testes, refatoracao, docs

### 3. Use Agent Teams para tarefas complexas
Para tarefas que tocam multiplos modulos/arquivos, spawne teammates especializados:
- Divida em subtarefas independentes por dominio (frontend, backend, testes)
- Cada teammate trabalha em arquivos diferentes pra evitar conflito
- Sintetize resultados quando terminarem

### 4. Valide o trabalho
- Rode testes existentes apos cada mudanca
- Rode linter se disponivel
- Confirme que o build nao quebrou

### 5. Commite e documente
- Commits frequentes com mensagens claras em portugues
- Atualize TODO.md marcando [DONE] o que completou
- Registre no OVERNIGHT-LOG.md:
  - O que foi feito
  - Decisoes tomadas
  - Problemas encontrados
  - Proximos passos

### 6. Continue com a proxima tarefa
- Repita o ciclo ate acabarem as tarefas ou o loop parar

## Regras:
- NUNCA delete arquivos de configuracao (.env, deploy configs, secrets)
- NUNCA force push
- Se travar por mais de 10 min, documente no OVERNIGHT-LOG.md e pule pra outra tarefa
- Prefira mudancas pequenas e incrementais
- Na duvida sobre arquitetura, documente as opcoes e escolha a mais conservadora
"@

$loopPath = "$env:USERPROFILE\.claude\loop.md"
[System.IO.File]::WriteAllText($loopPath, $loopContent, [System.Text.Encoding]::UTF8)
Write-Host "[OK] loop.md reescrito sem problemas de encoding" -ForegroundColor Green

Write-Host ""
Write-Host "Pronto! Verifique com:" -ForegroundColor Yellow
Write-Host '  ($json = cat "$env:USERPROFILE\.claude\settings.json" | ConvertFrom-Json).env'
Write-Host ""
