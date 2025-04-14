Write-Host "Script iniciado"

. "C:\Users\3420179\codigos\emails-bloqueados.ps1"

foreach ($email in $emailsBloqueados.Keys) {
    Write-Host "$email => $($emailsBloqueados[$email])"
    Write-Host "oi"
}
