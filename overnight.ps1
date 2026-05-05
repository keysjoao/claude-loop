# ============================================================
# overnight.ps1 — Loop Noturno Global para Claude Code
# ============================================================
#
# USO:
#   .\overnight.ps1                                (usa a pasta atual)
#   .\overnight.ps1 -ProjectPath "C:\meu-projeto"
#   .\overnight.ps1 -ProjectPath "C:\meu-projeto" -Iterations 30 -PauseMinutes 3
#
# PARAR: Ctrl+C a qualquer momento
# ============================================================

param(
    [string]$ProjectPath = (Get-Location).Path,
    [int]$Iterations = 20,
    [int]$PauseMinutes = 5
)

$startTime = Get-Date
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "        CLAUDE CODE - LOOP NOTURNO AUTONOMO" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Projeto:     $ProjectPath" -ForegroundColor White
Write-Host "  Iteracoes:   $Iterations" -ForegroundColor White
Write-Host "  Pausa:       $PauseMinutes min entre ciclos" -ForegroundColor White
Write-Host "  Inicio:      $($startTime.ToString('dd/MM/yyyy HH:mm'))" -ForegroundColor White
$estimatedHours = [math]::Round($Iterations * ($PauseMinutes + 5) / 60, 1)
Write-Host "  Estimativa:  ~$estimatedHours horas" -ForegroundColor White
Write-Host ""
Write-Host "  Ctrl+C para parar" -ForegroundColor DarkGray
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan

if (-not (Test-Path $ProjectPath)) {
    Write-Host "[ERRO] Pasta nao encontrada: $ProjectPath" -ForegroundColor Red
    exit 1
}
Set-Location $ProjectPath

# Criar OVERNIGHT-LOG.md se nao existir
$logFile = Join-Path $ProjectPath "OVERNIGHT-LOG.md"
if (-not (Test-Path $logFile)) {
    "# Overnight Log`n`n---`n" | Set-Content $logFile -Encoding UTF8
    Write-Host "[Setup] OVERNIGHT-LOG.md criado" -ForegroundColor DarkGray
}

# Determinar prompt: projeto > global > padrao
$projectLoop = Join-Path $ProjectPath ".claude\loop.md"
$globalLoop = "$env:USERPROFILE\.claude\loop.md"

if (Test-Path $projectLoop) {
    $prompt = Get-Content $projectLoop -Raw -Encoding UTF8
    Write-Host "[Setup] Usando loop.md do projeto" -ForegroundColor DarkGray
} elseif (Test-Path $globalLoop) {
    $prompt = Get-Content $globalLoop -Raw -Encoding UTF8
    Write-Host "[Setup] Usando loop.md global" -ForegroundColor DarkGray
} else {
    $prompt = "Leia CLAUDE.md e TODO.md (se existirem). Trabalhe na proxima tarefa pendente. Use Agent Teams para tarefas complexas. Ao completar cada tarefa, faca commit com mensagem em portugues, marque como [DONE] no TODO.md, e documente no OVERNIGHT-LOG.md. Se travar, documente e passe para a proxima."
    Write-Host "[Setup] Usando prompt padrao (nenhum loop.md encontrado)" -ForegroundColor Yellow
}

$outputLog = Join-Path $ProjectPath "overnight-output.log"
"" | Set-Content $outputLog -Encoding UTF8

$successCount = 0
$errorCount = 0

for ($i = 1; $i -le $Iterations; $i++) {
    $iterStart = Get-Date
    $timestamp = $iterStart.ToString("dd/MM HH:mm")
    
    Write-Host ""
    Write-Host "--- [$timestamp] Iteracao $i/$Iterations ---" -ForegroundColor Green
    
    "=== Iteracao $i - $timestamp ===" | Out-File -Append $outputLog -Encoding UTF8
    
    try {
        $output = claude -p $prompt --dangerously-skip-permissions 2>&1
        $output | Out-File -Append $outputLog -Encoding UTF8
        
        $successCount++
        $duration = [math]::Round(((Get-Date) - $iterStart).TotalMinutes, 1)
        Write-Host "[OK] Iteracao $i completa ($duration min)" -ForegroundColor Green
    }
    catch {
        $errorCount++
        Write-Host "[ERRO] Iteracao $i falhou: $_" -ForegroundColor Red
        "[ERRO] Iteracao $i - $(Get-Date): $_" | Out-File -Append $outputLog -Encoding UTF8
    }
    
    if ($i -lt $Iterations) {
        Write-Host "Proxima iteracao em $PauseMinutes min..." -ForegroundColor DarkGray
        Start-Sleep -Seconds ($PauseMinutes * 60)
    }
}

$endTime = Get-Date
$totalHours = [math]::Round(($endTime - $startTime).TotalHours, 1)

Write-Host ""
Write-Host "========================================================" -ForegroundColor Yellow
Write-Host "        LOOP NOTURNO FINALIZADO" -ForegroundColor Yellow
Write-Host "========================================================" -ForegroundColor Yellow
Write-Host "  Duracao:   $totalHours horas" -ForegroundColor White
Write-Host "  Sucessos:  $successCount" -ForegroundColor Green
Write-Host "  Erros:     $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host ""
Write-Host "  Verifique:" -ForegroundColor Cyan
Write-Host "    - OVERNIGHT-LOG.md" -ForegroundColor White
Write-Host "    - git log --oneline -20" -ForegroundColor White
Write-Host "    - overnight-output.log" -ForegroundColor White
Write-Host "========================================================" -ForegroundColor Yellow
