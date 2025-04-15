$nomeDoArquivo    = $args[0] + "-bloqueados.txt"
$novoBloqueado    = $args[1]
$dataHora         = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$linha            = "$novoBloqueado,$dataHora"
$caminhoDoArquivo = "$PSScriptRoot\$nomeDoArquivo"

# Adiciona a nova linha ao arquivo
Add-Content -Path $caminhoDoArquivo -Value $linha

# Ordena e salva
Get-Content -Path $caminhoDoArquivo | Sort-Object | Set-Content -Path $caminhoDoArquivo