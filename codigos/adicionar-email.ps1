$novoEmail        = $args[0]
$dataHora         = Get-Date -Format "dd/MM/yyyy HH:mm:ss"
$linha            = "$novoEmail,$dataHora"
$caminhoDoArquivo = Join-Path -Path $PSScriptRoot -ChildPath "emails-bloqueados.txt"

# Adiciona a nova linha ao arquivo
Add-Content -Path $caminhoDoArquivo -Value $linha

# Ordena e salva
Get-Content -Path $caminhoDoArquivo | Sort-Object | Set-Content -Path $caminhoDoArquivo
