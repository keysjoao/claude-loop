# ============================================================
# SETUP UNICO — Claude Code Overnight (Global)
# Rode este script UMA VEZ para configurar tudo.
# ============================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  SETUP: Claude Code Overnight (Global)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# 1. Criar pasta global .claude se nao existir
$claudeDir = "$env:USERPROFILE\.claude"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
    Write-Host "[OK] Pasta $claudeDir criada" -ForegroundColor Green
} else {
    Write-Host "[OK] Pasta $claudeDir ja existe" -ForegroundColor Green
}

# 2. Configurar settings.json (merge se ja existir)
$settingsPath = "$claudeDir\settings.json"
if (Test-Path $settingsPath) {
    try {
        $existing = Get-Content $settingsPath -Raw | ConvertFrom-Json
        # Adiciona env se nao existir
        if (-not $existing.env) {
            $existing | Add-Member -NotePropertyName "env" -NotePropertyValue @{}
        }
        $existing.env | Add-Member -NotePropertyName "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS" -NotePropertyValue "1" -Force
        $existing | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
        Write-Host "[OK] settings.json atualizado (Agent Teams habilitado)" -ForegroundColor Green
    }
    catch {
        Write-Host "[AVISO] Nao consegui fazer merge do settings.json existente." -ForegroundColor Yellow
        Write-Host "        Adicione manualmente: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = 1" -ForegroundColor Yellow
    }
} else {
    $settings = @{
        env = @{
            CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS = "1"
        }
        permissions = @{
            allow = @("Read", "Write", "Edit", "Bash", "Glob", "Grep", "MultiEdit")
        }
    }
    $settings | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding UTF8
    Write-Host "[OK] settings.json criado com Agent Teams habilitado" -ForegroundColor Green
}

# 3. Copiar loop.md global
$loopSource = Join-Path $PSScriptRoot "loop.md"
$loopDest = "$claudeDir\loop.md"
if (Test-Path $loopSource) {
    Copy-Item $loopSource $loopDest -Force
    Write-Host "[OK] loop.md global instalado em $loopDest" -ForegroundColor Green
} else {
    Write-Host "[AVISO] loop.md nao encontrado na pasta do setup" -ForegroundColor Yellow
}

# 4. Desabilitar suspensao (quando na tomada)
Write-Host ""
Write-Host "Configurando energia (impedir suspensao na tomada)..." -ForegroundColor Yellow
powercfg -change -standby-timeout-ac 0
powercfg -change -hibernate-timeout-ac 0
Write-Host "[OK] Suspensao desabilitada (quando plugado na tomada)" -ForegroundColor Green
Write-Host "[INFO] Monitor vai desligar em 2h pra economizar energia" -ForegroundColor DarkGray
powercfg -change -monitor-timeout-ac 120

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  SETUP COMPLETO!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Agora voce pode usar de 2 formas:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  FORMA 1 — Dentro do Claude Code:" -ForegroundColor White
Write-Host "    cd C:\seu-projeto" -ForegroundColor DarkGray
Write-Host "    claude" -ForegroundColor DarkGray
Write-Host "    /loop 30m" -ForegroundColor DarkGray
Write-Host ""
Write-Host "  FORMA 2 — Script headless (PowerShell):" -ForegroundColor White
Write-Host "    .\overnight.ps1 -ProjectPath 'C:\seu-projeto'" -ForegroundColor DarkGray
Write-Host ""
Write-Host "Dica: edite o TODO.md do projeto com tarefas [TONIGHT]" -ForegroundColor Yellow
Write-Host ""

Read-Host "Pressione Enter para fechar"
