$nomeDoArquivo = $args[0] + "-bloqueados.txt"
$caminho       = "$PSScriptRoot\$nomeDoArquivo"
$dados         = Get-Content -Path $caminho

foreach ($linha in $dados) {
    $partes     = $linha -split ","
    $emailOuDom = $partes[0].Trim()
    $data       = $partes[1].Trim()
    Write-Host "$emailOuDom - $data"
}
