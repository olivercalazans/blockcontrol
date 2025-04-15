# Argumentos passados para o script
$nomeDoArquivo    = $args[0] + "-bloqueados.txt"
$linhaParaRemover = $args[1]
$arquivo          = "$PSScriptRoot\$nomeDoArquivo"
$linhasFiltradas  = @()

foreach ($linha in Get-Content $arquivo) {
    if ($linha.Trim() -eq "") { continue }  # Ignora linhas em branco
    $partes = $linha -split ','
    
    if ($partes.Length -lt 2) { continue }  # Ignora linhas mal formatadas (sem vírgula)
    $email = $partes[0].Trim()

    if (![string]::IsNullOrWhiteSpace($email) -and $email.ToLower() -ne $linhaParaRemover.ToLower()) {
        $linhasFiltradas += $linha
    }
}

# Salva o conteúdo filtrado no arquivo
$linhasFiltradas | Set-Content $arquivo
