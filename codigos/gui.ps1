Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Command Outputs and Input"
$form.Size = New-Object System.Drawing.Size(1115,400)

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

# Output refresh logic
function Refresh-Output {
    $output1 = Get-Process | Select-Object -First 5 | Out-String
    $output2 = Get-Service | Select-Object -First 5 | Out-String
    $output3 = Get-Date | Out-String

    $box1.Text = $output1
    $box2.Text = $output2
    $box3.Text = $output3
}

# Button click events for executing scripts/files
$button1.Add_Click({
    $input = $textBoxInput1.Text
    if (![string]::IsNullOrWhiteSpace($input)) {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File "
        Refresh-Output
    } else {
        [System.Windows.Forms.MessageBox]::Show("Error")
    }
})

$button2.Add_Click({
    $input = $textBoxInput2.Text
    if (![string]::IsNullOrWhiteSpace($input)) {
        Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\adicionar-bloqueado.ps1`"", "dominios", "`"$input`""
        Refresh-Output
    } else {
        [System.Windows.Forms.MessageBox]::Show("Error")
    }
})

$button3.Add_Click({
    $input = $textBoxInput3.Text
    if (![string]::IsNullOrWhiteSpace($input)) {
        Start-Process powershell -ArgumentList @("-NoProfile", "-ExecutionPolicy", "Bypass", "-File", "`"$PSScriptRoot\adicionar-bloqueado.ps1`"", "emails", "`"$input`"")
        Refresh-Output
    } else {
        [System.Windows.Forms.MessageBox]::Show("Error")
    }
})

Refresh-Output
$form.ShowDialog()
