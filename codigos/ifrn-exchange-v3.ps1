. "$PSScriptRoot\form.ps1"
. "$PSScriptRoot\panels.ps1"
. "$PSScriptRoot\actions.ps1"




# Output refresh logic
function Refresh-Box1 {
    $output1 = Get-Content "$PSScriptRoot\ips-bloqueados.txt" | Out-String
    $box1.Text = $output1
}

function Refresh-Box2 {
    $output2 = Get-Content "$PSScriptRoot\dominios-bloqueados.txt" | Out-String
    $box2.Text = $output2
}

function Refresh-Box3 {
    $output3 = Get-Content "$PSScriptRoot\emails-bloqueados.txt" | Out-String
    $box3.Text = $output3
}





# Button click events for executing scripts/files
$button1.Add_Click({
    $input1 = $textBoxInput1.Text
    if (![string]::IsNullOrWhiteSpace($input1)) {
        Add-IPBlockListEntry -IPAddress $input1 | Out-Host
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\add.ps1`"", "ips", "`"$input1`"") -Wait -NoNewWindow
        Refresh-Box1
        [System.Windows.Forms.MessageBox]::Show("O IP `"$input1`" foi bloqueado")
    } elseif ([string]::IsNullOrWhiteSpace($input1)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$button2.Add_Click({
    $input2 = $textBoxInput2.Text
    if (![string]::IsNullOrWhiteSpace($input2)) {
        Add-IPBlockListEntry -IPRange $input2| Out-Host
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\add.ps1`"", "ips", "`"$input2`"") -Wait -NoNewWindow
        Refresh-Box1
        [System.Windows.Forms.MessageBox]::Show("A faixa IP `"$input2`" foi bloqueada")
    } elseif ([string]::IsNullOrWhiteSpace($input2)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio ou em branco")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$button3.Add_Click({
    $input3 = $textBoxInput3.Text
    if (![string]::IsNullOrWhiteSpace($input3)) {
        Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Add="$input3"} | Out-Host
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\add.ps1`"", "dominios", "`"$input3`"") -Wait -NoNewWindow
        Refresh-Box2
        [System.Windows.Forms.MessageBox]::Show("O dominio `"$input3`" foi bloqueado")
    } elseif ([string]::IsNullOrWhiteSpace($input3)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio ou em branco")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})



$button4.Add_Click({
    $input4 = $textBoxInput4.Text
    if (![string]::IsNullOrWhiteSpace($input4)) {
        Set-SenderFilterConfig -BlockedSenders @{Add="$input4"}
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\add.ps1`"", "emails", "`"$input4`"") -Wait -NoNewWindow
        Refresh-Box3
        [System.Windows.Forms.MessageBox]::Show("O email `"$input4`" foi bloqueado")
    } elseif ([string]::IsNullOrWhiteSpace($input4)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio ou em branco")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})





# Button click events for removing entries
$buttonRemove1.Add_Click({
    $inputRemove1 = $textBoxRemove1.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove1)) {
        Get-IPBlockListEntry | Where {$_.IPRange -eq $inputRemove1} | Remove-IPBlockListEntry -Confirm:$false | Out-Host
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\remove.ps1`"", "ips", "`"$inputRemove1`"") -Wait -NoNewWindow
        Refresh-Box1
        [System.Windows.Forms.MessageBox]::Show("O IP $inputRemove1 foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove1)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$buttonRemove2.Add_Click({
    $inputRemove2 = $textBoxRemove2.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove2)) {
        Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Remove="$inputRemove2"} | Out-Host
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\remove.ps1`"", "dominios", "`"$inputRemove2`"") -Wait -NoNewWindow
        Refresh-Box2
        [System.Windows.Forms.MessageBox]::Show("O dominio $inputRemove2 foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove2)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$buttonRemove3.Add_Click({
    $inputRemove3 = $textBoxRemove3.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove3)) {
        Set-SenderFilterConfig -BlockedSenders @{Remove="$inputRemove3"}
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\remove.ps1`"", "emails", "`"$inputRemove3`"") -Wait -NoNewWindow
        Refresh-Box3
        [System.Windows.Forms.MessageBox]::Show("O email $inputRemove3 foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove3)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})

Refresh-Box1
Refresh-Box2
Refresh-Box3

$form.ShowDialog()
