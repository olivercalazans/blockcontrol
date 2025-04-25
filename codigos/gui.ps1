Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Command Outputs and Input"
$form.Size = New-Object System.Drawing.Size(1390,400)

# Panel 1
$panel1 = New-Object System.Windows.Forms.Panel
$panel1.Size = New-Object System.Drawing.Size(250,300)
$panel1.Location = New-Object System.Drawing.Point(20,20)
$panel1.BorderStyle = 'FixedSingle'

$box1 = New-Object System.Windows.Forms.TextBox
$box1.Multiline = $true
$box1.ScrollBars = 'Vertical'
$box1.Dock = 'Fill'
$panel1.Controls.Add($box1)
$form.Controls.Add($panel1)

# Panel 2
$panel2 = New-Object System.Windows.Forms.Panel
$panel2.Size = New-Object System.Drawing.Size(250,300)
$panel2.Location = New-Object System.Drawing.Point(290,20)
$panel2.BorderStyle = 'FixedSingle'

$box2 = New-Object System.Windows.Forms.TextBox
$box2.Multiline = $true
$box2.ScrollBars = 'Vertical'
$box2.Dock = 'Fill'
$panel2.Controls.Add($box2)
$form.Controls.Add($panel2)

# Panel 3
$panel3 = New-Object System.Windows.Forms.Panel
$panel3.Size = New-Object System.Drawing.Size(250,300)
$panel3.Location = New-Object System.Drawing.Point(560,20)
$panel3.BorderStyle = 'FixedSingle'

$box3 = New-Object System.Windows.Forms.TextBox
$box3.Multiline = $true
$box3.ScrollBars = 'Vertical'
$box3.Dock = 'Fill'
$panel3.Controls.Add($box3)
$form.Controls.Add($panel3)

# Panel 4 - Inputs + Buttons
$panel4 = New-Object System.Windows.Forms.Panel
$panel4.Size = New-Object System.Drawing.Size(250,300)
$panel4.Location = New-Object System.Drawing.Point(830,20)
$panel4.BorderStyle = 'FixedSingle'

# Input 1
$textBoxInput1 = New-Object System.Windows.Forms.TextBox
$textBoxInput1.Size = New-Object System.Drawing.Size(230,25)
$textBoxInput1.Location = New-Object System.Drawing.Point(10,10)
$panel4.Controls.Add($textBoxInput1)

$button1 = New-Object System.Windows.Forms.Button
$button1.Text = "Block a IP"
$button1.Size = New-Object System.Drawing.Size(100,25)
$button1.Location = New-Object System.Drawing.Point(10,40)
$panel4.Controls.Add($button1)

# Input 2
$textBoxInput2 = New-Object System.Windows.Forms.TextBox
$textBoxInput2.Size = New-Object System.Drawing.Size(230,25)
$textBoxInput2.Location = New-Object System.Drawing.Point(10,80)
$panel4.Controls.Add($textBoxInput2)

$button2 = New-Object System.Windows.Forms.Button
$button2.Text = "Block a domain"
$button2.Size = New-Object System.Drawing.Size(100,25)
$button2.Location = New-Object System.Drawing.Point(10,110)
$panel4.Controls.Add($button2)

# Input 3
$textBoxInput3 = New-Object System.Windows.Forms.TextBox
$textBoxInput3.Size = New-Object System.Drawing.Size(230,25)
$textBoxInput3.Location = New-Object System.Drawing.Point(10,150)
$panel4.Controls.Add($textBoxInput3)

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Block an email"
$button3.Size = New-Object System.Drawing.Size(100,25)
$button3.Location = New-Object System.Drawing.Point(10,180)
$panel4.Controls.Add($button3)

$form.Controls.Add($panel4)

# Panel 5 - Removal Inputs
$panel5 = New-Object System.Windows.Forms.Panel
$panel5.Size = New-Object System.Drawing.Size(250,300)
$panel5.Location = New-Object System.Drawing.Point(1100,20)
$panel5.BorderStyle = 'FixedSingle'

# Removal Input 1 (For Column 1)
$textBoxRemove1 = New-Object System.Windows.Forms.TextBox
$textBoxRemove1.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove1.Location = New-Object System.Drawing.Point(10,10)
$panel5.Controls.Add($textBoxRemove1)

$buttonRemove1 = New-Object System.Windows.Forms.Button
$buttonRemove1.Text = "Remove IP CIDR"
$buttonRemove1.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove1.Location = New-Object System.Drawing.Point(10,40)
$panel5.Controls.Add($buttonRemove1)

# Removal Input 2 (For Column 1)
$textBoxRemove2 = New-Object System.Windows.Forms.TextBox
$textBoxRemove2.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove2.Location = New-Object System.Drawing.Point(10,80)
$panel5.Controls.Add($textBoxRemove2)

$buttonRemove2 = New-Object System.Windows.Forms.Button
$buttonRemove2.Text = "Remove IP"
$buttonRemove2.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove2.Location = New-Object System.Drawing.Point(10,110)
$panel5.Controls.Add($buttonRemove2)

# Removal Input 3 (For Column 2)
$textBoxRemove3 = New-Object System.Windows.Forms.TextBox
$textBoxRemove3.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove3.Location = New-Object System.Drawing.Point(10,150)
$panel5.Controls.Add($textBoxRemove3)

$buttonRemove3 = New-Object System.Windows.Forms.Button
$buttonRemove3.Text = "Remove Domain"
$buttonRemove3.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove3.Location = New-Object System.Drawing.Point(10,180)
$panel5.Controls.Add($buttonRemove3)

# Removal Input 4 (For column 3)
$textBoxRemove4 = New-Object System.Windows.Forms.TextBox
$textBoxRemove4.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove4.Location = New-Object System.Drawing.Point(10,220)
$panel5.Controls.Add($textBoxRemove4)

$buttonRemove4 = New-Object System.Windows.Forms.Button
$buttonRemove4.Text = "Remove Email"
$buttonRemove4.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove4.Location = New-Object System.Drawing.Point(10,250)
$panel5.Controls.Add($buttonRemove4)

$form.Controls.Add($panel5)



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
        Add-IPBlockListEntry -IPAddress $input1 | Out-Host -Wait -NoNewWindow
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File "
        Refresh-Box1
    } elseif ([string]::IsNullOrWhiteSpace($input1)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$button2.Add_Click({
    $input2 = $textBoxInput2.Text
    if (![string]::IsNullOrWhiteSpace($input2)) {
        Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Add="$input2"} | Out-Host -Wait -NoNewWindow
        Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\adicionar-bloqueado.ps1`"", "dominios", "`"$input2`"" -Wait -NoNewWindow
        $blockedDomain = Get-SenderFilterConfig |  Select-Object -ExpandProperty BlockedSenders | Select-Object -ExpandProperty Address | Select-String "$input2" -Wait -NoNewWindow
        Refresh-Box2
        [System.Windows.Forms.MessageBox]::Show("O dominio `"$blockedDomain`" foi bloqueado")
    } elseif ([string]::IsNullOrWhiteSpace($input2)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$button3.Add_Click({
    $input3 = $textBoxInput3.Text
    if (![string]::IsNullOrWhiteSpace($input3)) {
        Set-SenderFilterConfig -BlockedSenders @{Add="$input3"} -Wait -NoNewWindow
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\adicionar-bloqueado.ps1`"", "emails", "`"$input3`"") -Wait -NoNewWindow
        $blockedEmail = Get-SenderFilterConfig |  Select-Object -ExpandProperty BlockedSenders | Select-Object -ExpandProperty Address | Select-String "$input3" -Wait -NoNewWindow
        Refresh-Box3
        [System.Windows.Forms.MessageBox]::Show("O email `"$blockedEmail`" foi bloqueado")
    } elseif ([string]::IsNullOrWhiteSpace($input3)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})





# Button click events for removing entries
$buttonRemove1.Add_Click({
    $inputRemove1 = $textBoxRemove1.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove1)) {
        Add-IPBlockListEntry -IPRange $entrada	| Out-Host -Wait -NoNewWindow
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
        $domains = Get-Content "$PSScriptRoot\dominios-bloqueados.txt"
        $updatedDomains = $domains | Where-Object {$_ -ne $inputRemove2}
        $updatedDomains | Set-Content "$PSScriptRoot\dominios-bloqueados.txt"
        Refresh-Box1
        [System.Windows.Forms.MessageBox]::Show("O dominio foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove2)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$buttonRemove3.Add_Click({
    $inputRemove3 = $textBoxRemove3.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove3)) {
        $emails = Get-Content "$PSScriptRoot\emails-bloqueados.txt"
        $updatedEmails = $emails | Where-Object {$_ -ne $inputRemove3}
        $updatedEmails | Set-Content "$PSScriptRoot\emails-bloqueados.txt"
        Refresh-Box2
        [System.Windows.Forms.MessageBox]::Show("O email foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove3)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


$buttonRemove4.Add_Click({
    $inputRemove4 = $textBoxRemove4.Text
    if (![string]::IsNullOrWhiteSpace($inputRemove4)) {
        $emails = Get-Content "$PSScriptRoot\emails-bloqueados.txt"
        $updatedEmails = $emails | Where-Object {$_ -ne $inputRemove4}
        $updatedEmails | Set-Content "$PSScriptRoot\emails-bloqueados.txt"
        Refresh-Box3
        [System.Windows.Forms.MessageBox]::Show("O email foi removido.")
    } elseif ([string]::IsNullOrWhiteSpace($inputRemove4)) {
        [System.Windows.Forms.MessageBox]::Show("Input vazio")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Erro desconhecido")
    }
})


Refresh-Box1
Refresh-Box2
Refresh-Box3

$form.ShowDialog()
