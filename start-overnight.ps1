# start-overnight.ps1 — Prepara o projeto e inicia o Claude Code
# USO: .\start-overnight.ps1 -ProjectPath "C:\meu-projeto"
#      .\start-overnight.ps1   (usa pasta atual)

param(
    [string]$ProjectPath = (Get-Location).Path
)

if (-not (Test-Path $ProjectPath)) {
    Write-Host "[ERRO] Pasta nao encontrada: $ProjectPath" -ForegroundColor Red
    exit 1
}

# Garantir que .claude/ existe no projeto
$claudeDir = Join-Path $ProjectPath ".claude"
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}

# Copiar loop.md global pro projeto (se o projeto nao tiver um proprio)
$projectLoop = Join-Path $claudeDir "loop.md"
$globalLoop = "$env:USERPROFILE\.claude\loop.md"

if (-not (Test-Path $projectLoop)) {
    if (Test-Path $globalLoop) {
        Copy-Item $globalLoop $projectLoop -Force
        Write-Host "[OK] loop.md copiado pro projeto" -ForegroundColor Green
    }
} else {
    Write-Host "[OK] Projeto ja tem loop.md proprio" -ForegroundColor Green
}

Write-Host ""
Write-Host "Pronto! Agora rode:" -ForegroundColor Cyan
Write-Host "  cd `"$ProjectPath`"" -ForegroundColor White
Write-Host "  claude" -ForegroundColor White
Write-Host "  /loop 30m" -ForegroundColor White
Write-Host ""
Write-Host "Ou se pedir prompt, cole:" -ForegroundColor Yellow
Write-Host "  /loop 30m leia e execute as instrucoes do arquivo .claude/loop.md" -ForegroundColor White
Write-Host ""
