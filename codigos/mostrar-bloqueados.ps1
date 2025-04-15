$nomeDoArquivo = $args[0] + "-bloqueados.txt"
$caminho       = "$PSScriptRoot\$nomeDoArquivo"
$dados         = Get-Content -Path $caminho

Write-Host "MOSTRANDO DADOS DE UM ARQUIVO EXTERNO"

foreach ($linha in $dados) {
    $partes     = $linha -split ","
    $emailOuDom = $partes[0]
    $data       = $partes[1]
    Write-Host "$emailOuDom - $data"
 }
