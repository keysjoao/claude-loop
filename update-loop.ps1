# update-loop.ps1 — Atualiza o loop.md global
$source = Join-Path $PSScriptRoot "loop.md"
$dest = "$env:USERPROFILE\.claude\loop.md"
[System.IO.File]::WriteAllText($dest, [System.IO.File]::ReadAllText($source, [System.Text.Encoding]::UTF8), [System.Text.Encoding]::UTF8)
Write-Host "[OK] loop.md global atualizado!" -ForegroundColor Green
