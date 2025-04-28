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


# Panel 4 - Inputs Buttons
$panel4 = New-Object System.Windows.Forms.Panel
$panel4.Size = New-Object System.Drawing.Size(250,300)
$panel4.Location = New-Object System.Drawing.Point(830,20)
$panel4.BorderStyle = 'FixedSingle'


# Panel 5 - Removal Inputs
$panel5 = New-Object System.Windows.Forms.Panel
$panel5.Size = New-Object System.Drawing.Size(250,300)
$panel5.Location = New-Object System.Drawing.Point(1100,20)
$panel5.BorderStyle = 'FixedSingle'