Add-Type -AssemblyName System.Windows.Forms

$form      = New-Object System.Windows.Forms.Form
$form.Text = "Command Outputs and Input"
$form.Size = New-Object System.Drawing.Size(895,430)

$panel             = New-Object System.Windows.Forms.Panel
$panel.Size        = New-Object System.Drawing.Size(300,300)
$panel.Location    = New-Object System.Drawing.Point(20,20)
$panel.BorderStyle = 'FixedSingle'

$box = New-Object System.Windows.Forms.TextBox
$box.Multiline  = $true
$box.WordWrap   = $false
$box.ScrollBars = 'Both'
$box.Dock       = 'Fill'

$panel.Controls.Add($box)
$form.Controls.Add($panel)





$buttonPanel             = New-Object System.Windows.Forms.Panel
$buttonPanel.Size        = New-Object System.Drawing.Size(300,50)
$buttonPanel.Location    = New-Object System.Drawing.Point(20,330)
$buttonPanel.BorderStyle = 'FixedSingle'


$btn1          = New-Object System.Windows.Forms.Button
$btn1.Text     = "See IPs"
$btn1.Size     = New-Object System.Drawing.Size(90,23)
$btn1.Location = New-Object System.Drawing.Point(5,15)

$btn2          = New-Object System.Windows.Forms.Button
$btn2.Text     = "See Domains"
$btn2.Size     = New-Object System.Drawing.Size(90,23)
$btn2.Location = New-Object System.Drawing.Point(105,15)

$btn3          = New-Object System.Windows.Forms.Button
$btn3.Text     = "See Emails"
$btn3.Size     = New-Object System.Drawing.Size(90,23)
$btn3.Location = New-Object System.Drawing.Point(205,15)


$buttonPanel.Controls.AddRange(@($btn1,$btn2,$btn3))
$form.Controls.Add($buttonPanel)


$displayBox = $box

$btn1.Add_Click({
    $displayBox.Text = (Get-IPBlockListEntry | ForEach-Object { $_.IPRange.Expression } | Sort-Object { [version]($_ -replace '/\d+', '') } | Out-String)
})

$btn2.Add_Click({
    $displayBox.Text = (Get-SenderFilterConfig | Select-Object -ExpandProperty BlockedDomainsAndSubdomains | Sort-Object | Out-String)
})

$btn3.Add_Click({
    $displayBox.Text = (Get-SenderFilterConfig | Select-Object -ExpandProperty BlockedSenders | Select-Object -ExpandProperty Address | Sort-Object | Out-String)
})





function Create-Input-Panel {
    param ([int]$len)
    $panel             = New-Object System.Windows.Forms.Panel
    $panel.Size        = New-Object System.Drawing.Size(250,360)
    $panel.Location    = New-Object System.Drawing.Point($len,20)
    $panel.BorderStyle = 'FixedSingle'
    return $panel
    
}


function Create-Text-Box{
    param([int]$len)
        $textBoxInput          = New-Object System.Windows.Forms.TextBox
        $textBoxInput.Size     = New-Object System.Drawing.Size(230,25)
        $textBoxInput.Location = New-Object System.Drawing.Point(10,$len)
        return $textBoxInput
}


function Create-Button {
    param([string]$text, [int]$len)
        $button          = New-Object System.Windows.Forms.Button
        $button.Text     = $text
        $button.Size     = New-Object System.Drawing.Size(130,25)
        $button.Location = New-Object System.Drawing.Point(10,$len)
        return $button
}





$panel2 = Create-Input-Panel -len 340


# Input 1
$textBoxInput1 = Create-Text-Box -len 10
$panel2.Controls.Add($textBoxInput1)
$button1 = Create-Button -text "Block a IP" -len 40
$panel2.Controls.Add($button1)


# Input 2
$textBoxInput2 = Create-Text-Box -len 103
$panel2.Controls.Add($textBoxInput2)
$button2 = Create-Button -text "Block a IP (CIDR)" -len 133
$panel2.Controls.Add($button2)


# Input 3
$textBoxInput3 = Create-Text-Box -len 199
$panel2.Controls.Add($textBoxInput3)
$button3 = Create-Button -text "Block an domain" -len 229
$panel2.Controls.Add($button3)


# Input 4
$textBoxInput4 = Create-Text-Box -len 290
$panel2.Controls.Add($textBoxInput4)
$button4 = Create-Button -text "Block an email" -len 320
$panel2.Controls.Add($button4)

$form.Controls.Add($panel2)



$panel3 = Create-Input-Panel -len 610

# Removal Input 1 (For Column 1)
$textBoxRemove1 = Create-Text-Box -len 10
$panel3.Controls.Add($textBoxRemove1)
$buttonRemove1 = Create-Button -text "Remove IP" -len 40
$panel3.Controls.Add($buttonRemove1)


# Removal Input 2 (For Column 2)
$textBoxRemove2 = Create-Text-Box -len 199
$panel3.Controls.Add($textBoxRemove2)
$buttonRemove2 = Create-Button -text "Remove Domain" -len 229
$panel3.Controls.Add($buttonRemove2)


# Removal Input 3 (For Column 3)
$textBoxRemove3 = Create-Text-Box -len 290
$panel3.Controls.Add($textBoxRemove3)
$buttonRemove3 = Create-Button -text "Remove Email" -len 320
$panel3.Controls.Add($buttonRemove3)

$form.Controls.Add($panel3)





function Handle-ButtonClick {
    param (
        [string]$InputText,
        [scriptblock]$Action,
        [string]$SuccessMessage
    )

    if (![string]::IsNullOrWhiteSpace($InputText)) {
        & $Action
        [System.Windows.Forms.MessageBox]::Show($SuccessMessage)
    } elseif ([string]::IsNullOrWhiteSpace($InputText)) {
        [System.Windows.Forms.MessageBox]::Show("Input is empty")
    } else {
        [System.Windows.Forms.MessageBox]::Show("Unknown error")
    }
}



# Block a single IP
$button1.Add_Click({
    $input1 = $textBoxInput1.Text
    Handle-ButtonClick -InputText $input1 -Action { Add-IPBlockListEntry -IPAddress $input1 | Out-Host } -SuccessMessage "IP '$input1' has been blocked"
})

# Block IP range
$button2.Add_Click({
    $input2 = $textBoxInput2.Text
    Handle-ButtonClick -InputText $input2 -Action { Add-IPBlockListEntry -IPRange $input2 | Out-Host } -SuccessMessage "IP range '$input2' has been blocked"
})

# Block domain
$button3.Add_Click({
    $input3 = $textBoxInput3.Text
    Handle-ButtonClick -InputText $input3 -Action { Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Add="$input3"} | Out-Host } -SuccessMessage "Domain '$input3' has been blocked"
})

# Block email
$button4.Add_Click({
    $input4 = $textBoxInput4.Text
    Handle-ButtonClick -InputText $input4 -Action { Set-SenderFilterConfig -BlockedSenders @{Add="$input4"} } -SuccessMessage "Email '$input4' has been blocked"
})

# Unblock IP/IP range
$buttonRemove1.Add_Click({
    $inputRemove1 = $textBoxRemove1.Text
    Handle-ButtonClick -InputText $inputRemove1 -Action { 
        Get-IPBlockListEntry | Where {$_.IPRange -eq $inputRemove1} | Remove-IPBlockListEntry -Confirm:$false | Out-Host
    } -SuccessMessage "IP '$inputRemove1' has been removed"
})

# Unblock domain
$buttonRemove2.Add_Click({
    $inputRemove2 = $textBoxRemove2.Text
    Handle-ButtonClick -InputText $inputRemove2 -Action { Set-SenderFilterConfig -BlockedDomainsAndSubdomains @{Remove=$inputRemove2} | Out-Host } -SuccessMessage "Domain '$inputRemove2' has been removed"
})

# Unblock email
$buttonRemove3.Add_Click({
    $inputRemove3 = $textBoxRemove3.Text
    Handle-ButtonClick -InputText $inputRemove3 -Action { Set-SenderFilterConfig -BlockedSenders @{Remove=$inputRemove3} } -SuccessMessage "Email '$inputRemove3' has been removed"
})





$form.ShowDialog()
