Write-Host "`n# Repositório: https://github.com/olivercalazans/blockcontrol"
Write-Host "A primeira execução é lenta pois o Exchange está iniciando o terminal" -ForegroundColor Green

function Read-NonEmptyInput {
    param ( [string]$Message )

    $inputValue = Read-Host $Message
    
    if ([string]::IsNullOrWhiteSpace($inputValue)) {
        Write-Host "Entrada vazía" -ForegroundColor Red
        return $null
    }
    
    return $inputValue
}

function Get-DomainList {
    Get-SenderFilterConfig |
        Select-Object -ExpandProperty BlockedDomainsAndSubdomains |
        ForEach-Object { $_.ToString() } |
        Sort-Object
}

function Get-EmailList {
    Get-SenderFilterConfig | Select-Object -ExpandProperty BlockedSenders | Select-Object -ExpandProperty Address | Sort-Object
}

function Get-IPList {
    Get-IPBlockListEntry | ForEach-Object { $_.IPRange.Expression } | Sort-Object { [version]($_ -replace '/\d+', '') }
}


function DisplayDomains {
    $domains = Get-DomainList
    if ($domains) {
        $domains | Out-String
    } else {
        Write-Host "Nenhum domínio bloqueado." -ForegroundColor Yellow
    }
}


function DisplayEmails {
    $emails = Get-EmailList
    if ($emails) {
        $emails | Out-String
    } else {
        Write-Host "Nenhum e-mail bloqueado." -ForegroundColor Yellow
    }
}


function DisplayIPs {
    $ips = Get-IPList
    if ($ips) {
        $ips | Out-String
    } else {
        Write-Host "Nenhum IP bloqueado." -ForegroundColor Yellow
    }
}


function SearchWord {
    $word = Read-NonEmptyInput "Palavra para pesquisar (em IPs, domínios e e-mails)"
    if ($null -eq $word) { return }

    $domains = Get-DomainList
    $emails  = Get-EmailList
    $ips     = Get-IPList

    Write-Host "`n========== RESULTADOS DA BUSCA ==========" -ForegroundColor Cyan
    $found = $false

    function Write-HighlightedLine($line, $word) {
        $index = $line.IndexOf($word, [System.StringComparison]::OrdinalIgnoreCase)
        if ($index -ge 0) {
            $before = $line.Substring(0, $index)
            $match = $line.Substring($index, $word.Length)
            $after = $line.Substring($index + $word.Length)
            Write-Host $before -NoNewline
            Write-Host $match -ForegroundColor Green -NoNewline
            Write-Host $after
        }
    }

    if ($domains) {
        $filtered = $domains | Where-Object { $_ -like "*$word*" }
        if ($filtered) {
            $found = $true
            Write-Host "`nDomínios encontrados:`n" -ForegroundColor Green
            foreach ($dom in $filtered) {
                Write-HighlightedLine $dom $word
            }
        }
    }

    if ($emails) {
        $filtered = $emails | Where-Object { $_ -like "*$word*" }
        if ($filtered) {
            $found = $true
            Write-Host "`nE-mails encontrados:`n" -ForegroundColor Green
            foreach ($email in $filtered) {
                Write-HighlightedLine $email $word
            }
        }
    }

    if ($ips) {
        $filtered = $ips | Where-Object { $_ -like "*$word*" }
        if ($filtered) {
            $found = $true
            Write-Host "`nIPs encontrados:`n" -ForegroundColor Green
            foreach ($ip in $filtered) {
                Write-HighlightedLine $ip $word
            }
        }
    }

    if (-not $found) {
        Write-Host "Nenhum item encontrado contendo '$word'." -ForegroundColor Yellow
    }
}


function BlockDomain {
    $value = Read-NonEmptyInput("Domínio para bloquear (Ex: domain.com)")
    if ($value) {
        Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Add="$value"} | Out-Host 
    }
}


function BlockEmail {
    $value = Read-NonEmptyInput("Email para bloquear (Ex: joao@gmail.com)")
    if ($value) {
        Set-SenderFilterConfig -BlockedSenders @{Add="$value"} 
    }
}


function BlockIP {
    $value = Read-NonEmptyInput("IP para bloquear (Ex: 192.168.0.100)")
    if ($value) {
        Add-IPBlockListEntry -IPAddress $value | Out-Host 
    }
}


function BlockCIDR {
    $value = Read-NonEmptyInput("IP/CIDR para bloquear (Ex: 192.168.0.0/24)")
    if ($value) {
        Add-IPBlockListEntry -IPRange $value | Out-Host 
    }
}


function UnblockDomain {
    $value = Read-NonEmptyInput("Domínio para desbloquear (Ex: domain.com)")
    if ($value) {
        Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Remove=$value} | Out-Host 
    }
}


function UnblockEmail {
    $value = Read-NonEmptyInput("Email para desbloquear (Ex: joao@gmail.com)")
    if ($value) {
        Set-SenderFilterConfig -BlockedSenders @{Remove="$value"}
    }
}


function UnblockIP {
    $value = Read-NonEmptyInput("IP para desbloquear (Ex: 192.168.0.100)")
    if ($value) {
        Get-IPBlockListEntry | Where-Object {$_.IPRange -eq $value} | Remove-IPBlockListEntry -Confirm:$false | Out-Host
    }
}


function AnalyzeSubdomains {
    $domains = Get-DomainList
    if (-not $domains) {
        Write-Host "Nenhum domínio bloqueado para analisar." -ForegroundColor Yellow
        return
    }

    $minInput = Read-NonEmptyInput "Mínimo de ocorrências para exibir"
    if ($null -eq $minInput) { return }
    try {
        $min = [int]$minInput
    } catch {
        Write-Host "Valor inválido. Digite um número inteiro." -ForegroundColor Red
        return
    }

    $ignoreInput = Read-Host "Subdomínios para ignorar (separados por vírgula, ex: com,net,org)"
    $ignore = @()
    if ($ignoreInput) {
        $ignore = $ignoreInput.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
    }

    $subCount = @{}
    $subDomains = @{}

    foreach ($domain in $domains) {
        $parts = $domain.Split('.')
        foreach ($part in $parts) {
            if ($part -in $ignore) { continue }
            if (-not $subCount.ContainsKey($part)) {
                $subCount[$part] = 0
                $subDomains[$part] = [System.Collections.Generic.List[string]]::new()
            }
            $subCount[$part]++
            $subDomains[$part].Add($domain)
        }
    }

    $sorted = $subCount.GetEnumerator() | Sort-Object Value -Descending

    Write-Host "`n--- Análise de Subdomínios ---" -ForegroundColor Cyan
    $found = $false
    foreach ($entry in $sorted) {
        $sub = $entry.Key
        $freq = $entry.Value
        if ($freq -ge $min) {
            $found = $true
            Write-Host "`n# Subdomínio: $sub -> $freq`n" -ForegroundColor Green
            $domainsList = $subDomains[$sub]
            foreach ($dom in $domainsList) {
                $parts = $dom.Split('.')
                Write-Host "  |-> " -NoNewline
                for ($i = 0; $i -lt $parts.Count; $i++) {
                    if ($parts[$i] -eq $sub) {
                        Write-Host $parts[$i] -ForegroundColor Green -NoNewline
                    } else {
                        Write-Host $parts[$i] -NoNewline
                    }
                    if ($i -lt $parts.Count - 1) {
                        Write-Host "." -NoNewline
                    }
                }
                Write-Host ""
            }
            Write-Host ""
        }
    }
    if (-not $found) {
        Write-Host "Nenhum subdomínio atinge o mínimo de $min ocorrências." -ForegroundColor Yellow
    }
    Write-Host "Total de domínios analisados: $($domains.Count)" -ForegroundColor Cyan
}


function Write-MenuOption {
    param(
        [string]$Number,
        [string]$Text
    )
    $prefix = "{0,-4}" -f "$Number."
    Write-Host $prefix -NoNewline -ForegroundColor DarkYellow
    Write-Host $Text
}


$blockDom     = "1"
$blockEmail   = "2"
$blockIP      = "3"
$blockCIDR    = "4"
$unblockDom   = "5"
$unblockEmail = "6"
$unblockIP    = "7"
$seeDoms      = "8"
$seeEmails    = "9"
$seeIPs       = "10"
$look4Word    = "11"
$analyze      = "12"

$menuOptions = @(
    "Bloquear domínio",
    "Bloquear email",
    "Bloquear IP",
    "Bloquear IP (CIDR)",
    "Desbloquear domínio",
    "Desbloquear email",
    "Desbloquear IP",
    "Ver domínios bloqueados",
    "Ver emails bloqueados",
    "Ver IPs bloqueados",
    "Procurar por palavra",
    "Contagem de subdomínios"
)



function ShowSafeArrowMenu {
    param (
        [string[]]$Options,
        [string]$Title = "============= Menu =============="
    )

    $selectedIndex = 0
    $isRunning = $true

    [Console]::CursorVisible = $false
    Write-Host "`n$Title" -ForegroundColor Cyan    
    $menuStartRow = [Console]::CursorTop

    for ($i = 0; $i -lt $Options.Length; $i++) {
        if ($i -eq $selectedIndex) {
            Write-Host (" > [ $($Options[$i]) ] ").PadRight(40) -ForegroundColor Yellow -BackgroundColor DarkCyan
        } else {
            Write-Host ("   $($Options[$i]) ").PadRight(40)
        }
    }

    while ($isRunning) {
        $keyInfo = [Console]::ReadKey($true)

        switch ($keyInfo.Key) {
            'UpArrow' {
                $selectedIndex--
                if ($selectedIndex -lt 0) { $selectedIndex = $Options.Length - 1 }
            }
            'DownArrow' {
                $selectedIndex++
                if ($selectedIndex -ge $Options.Length) { $selectedIndex = 0 }
            }
            'Enter' {
                $isRunning = $false
                continue
            }
            default { continue }
        }

        [Console]::SetCursorPosition(0, $menuStartRow)

        for ($i = 0; $i -lt $Options.Length; $i++) {
            if ($i -eq $selectedIndex) {
                Write-Host (" > [ $($Options[$i]) ] ").PadRight(40) -ForegroundColor Yellow -BackgroundColor DarkCyan
            } else {
                Write-Host ("   $($Options[$i]) ").PadRight(40)
            }
        }
    }

    [Console]::CursorVisible = $true
    
    return ($selectedIndex + 1).ToString()
}


while ($true) {       
    
    $option = ShowSafeArrowMenu -Options $menuOptions -Title "============= Menu =============="

    Write-Host "`n[Running selected option...]" -ForegroundColor Gray
    Write-Host "----------------------------------"

    switch ($option) {
        $blockDom     { BlockDomain        }
        $blockEmail   { BlockEmail         }
        $blockIP      { BlockIP            }
        $blockCIDR    { BlockCIDR          }
        $unblockDom   { UnblockDomain      }
        $unblockEmail { UnblockEmail       }
        $unblockIP    { UnblockIP          }
        $seeDoms      { DisplayDomains     }
        $seeEmails    { DisplayEmails      }
        $seeIPs       { DisplayIPs         }
        $look4Word    { SearchWord         }
        $analyze      { AnalyzeSubdomains  }

        Default {
            Write-Host "Invalid option!" -ForegroundColor Red
        }
    }

    Read-Host "`nPressione Enter para continuar"
}
