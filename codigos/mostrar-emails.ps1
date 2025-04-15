$caminho = Join-Path -Path $PSScriptRoot -ChildPath "emails-bloqueados.txt"
$emails  = Get-Content -Path $caminho

foreach ($linha in $emails) {
    $emailData = $linha -split ","
    $email     = $emailData[0]
    $data      = $emailData[1]
    Write-Host "$email - $data"
}
