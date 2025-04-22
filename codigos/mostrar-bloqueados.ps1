$nomeDoArquivo = $args[0] + "-bloqueados.txt"
$caminho       = "$PSScriptRoot\$nomeDoArquivo"
$dados         = Get-Content -Path $caminho

Write-Host "MOSTRANDO DADOS DE UM ARQUIVO EXTERNO"
Write-Host ("-" * 71)

foreach ($linha in $dados) {
    $partes     = $linha -split ","
    $emailOuDom = $partes[0].Trim()
    $data       = $partes[1].Trim()
    $len        = 69 - $emailOuDom.Length - $data.Length

    if ($len -lt 1) { $len = 1 }

    Write-Host ("| $emailOuDom" + (" " * $len) + "$data |")
    Write-Host ("-" * 71)
}
