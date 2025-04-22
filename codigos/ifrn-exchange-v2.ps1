do {
	Write-Host "`n============= IFRN/DIGTI Exchange =============="
	Write-Host "0- Sair"

	Write-Host "`n>>>>>> Blocklist IP/CIDR"
	Write-Host "1- Lista IPs na Blocklist"
	Write-Host "2- Insere IP na Blocklist unico (ex: 1.2.3.4)"
	Write-Host "3- Insere IP na Blocklist (CIDR)"
	Write-Host "4- Remove IP ou CIDR na Blocklist (ex: 1.2.3.4 ou 1.2.3.0/24)"

	Write-Host "`n`n>>>>>> Blocklist dominios"
	Write-Host "11- Lista dominios em Blocklist"
	Write-Host "12- Insere dominio em Blocklist"
	Write-Host "13- Remove dominio em Blocklist"	

	Write-Host "`n`n>>>>>> Blocklist e-mails"
	Write-Host "21- Lista e-mails em Blocklist"
	Write-Host "22- Insere e-mail em Blocklist"
	Write-Host "23- Remove e-mail em Blocklist"	

	Write-Host "=================================================="

	$menu = Read-Host "`nEscolha uma opcao"
	switch ($menu) {
	    # IPs Blocklist
	    '1' {
			Write-Host "`nListando IPs..."
			Get-IPBlockListEntry
	    }
	    '2'{
			$entrada = Read-Host "`nIP a adicionar (formato: 1.2.3.4)"
			Add-IPBlockListEntry -IPAddress $entrada | Out-Host		 
	    }
	    '3'{
			$entrada = Read-Host "`nCIDR a adicionar (formato: 1.2.3.0/24)"
			Add-IPBlockListEntry -IPRange $entrada	| Out-Host	 
	    }
	    '4'{
			$entrada = Read-Host "`nIP a remover (formato: 1.2.3.4)"
			Write-Host "Removendo IP/CIDR $entrada..."
			Get-IPBlockListEntry | Where {$_.IPRange -eq $entrada} | Remove-IPBlockListEntry -Confirm:$false | Out-Host
		}

	    # Domínios Blocklist
	    '11'{
			Write-Host "`nListando dominios em blocklist..."
			. "$PSScriptRoot\mostrar-bloqueados.ps1" "dominios"
		}
		
		'12'{
			$entrada = Read-Host "`nDominio a adicionar (formato: meuspam.com)"
			Write-Host "Verificando se o dimínio foi bloqueado. Aguarde."			
			Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Add="$entrada"} | Out-Host
			. "$PSScriptRoot\adicionar-bloqueado.ps1" "dominios" "$entrada"
			$blockedDomain = Get-SenderFilterConfig | Select-Object -ExpandProperty blockeddomainsandsubdomains | Select-String "$entrada"
			Write-Host "O domínio $blockedDomain foi bloqueado"
		}

		'13'{
			$entrada = Read-Host "`nDominio a remover (formato: meuspam.com)"
			Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Remove="$entrada"} | Out-Host
			. "$PSScriptRoot\remover-bloqueado.ps1" "dominios" "$entrada"
		}
  
	    # E-mails Blocklist
	    '21'{
			$entrada = Write-Host "`nListando e-mails em blocklist..."
			. "$PSScriptRoot\mostrar-bloqueados.ps1" "emails"
		}	

		'22'{
			$entrada = Read-Host "`nE-mail a adicionar na blocklist (formato: jdoe@gmail.com)"
			Write-Host "Verificando se o email foi bloqueado"
			Set-SenderFilterConfig -BlockedSenders @{Add="$entrada"}
			. "$PSScriptRoot\adicionar-bloqueado.ps1" "emails" "$entrada"
			$blockedEmail = Get-SenderFilterConfig |  Select-Object -ExpandProperty BlockedSenders | Select-Object -ExpandProperty Address | Select-String "$entrada"
			Write-Host "O email $blockedEmail foi bloqueado"
		}	

	    '23'{
			$entrada = Read-Host "`nE-mail a remover da blocklist (formato: jdoe@gmail.com)"
			Set-SenderFilterConfig -BlockedSenders @{Remove="$entrada"}
			. "$PSScriptRoot\remover-bloqueado.ps1" "emails" "$entrada"
		}	
		
		# Sair
		'0'{
		   Return
	    }
	}

	Read-Host "`nPressione qualquer tecla para voltar ao menu principal"
} until ($menu -eq 0) 
