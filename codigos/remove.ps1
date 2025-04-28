$nomeDoArquivo    = $args[0] + "-bloqueados.txt"
$linhaParaRemover = $args[1]
$arquivo          = "$PSScriptRoot\$nomeDoArquivo"
$linhasFiltradas  = @()


foreach ($linha in Get-Content $arquivo) {
    if ($linha.Trim() -eq "") { continue }
    $partes = $linha -split '-'
    
    if ($partes.Length -lt 2) { continue }
    $email = $partes[0].Trim()

    if (![string]::IsNullOrWhiteSpace($email) -and $email.ToLower() -ne $linhaParaRemover.ToLower()) {
        $linhasFiltradas += $linha
    }
}

$linhasFiltradas | Set-Content $arquivo
