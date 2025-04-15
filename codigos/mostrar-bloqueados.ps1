$nomeDoArquivo = $args[0] + "-bloqueados.txt"
$caminho       = Join-Path -Path $PSScriptRoot -ChildPath $nomeDoArquivo
$dados         = Get-Content -Path $caminho

foreach ($linha in $dados) {
    $partes     = $linha -split ","
    $emailOuDom = $partes[0]
    $data       = $partes[1]
    Write-Host "$emailOuDom - $data"
 }
