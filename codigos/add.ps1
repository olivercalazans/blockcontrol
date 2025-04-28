$nomeDoArquivo    = $args[0] + "-bloqueados.txt"
$bloqueado        = $args[1]
$dataHora         = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$linha            = "$bloqueado - $dataHora"
$caminhoDoArquivo = "$PSScriptRoot\$nomeDoArquivo"

Add-Content -Path $caminhoDoArquivo -Value $linha

Get-Content -Path $caminhoDoArquivo | Sort-Object | Set-Content -Path $caminhoDoArquivo