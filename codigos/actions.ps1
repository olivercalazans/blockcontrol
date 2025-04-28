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
$button2.Text = "Block a IP (CIDR)"
$button2.Size = New-Object System.Drawing.Size(130,25)
$button2.Location = New-Object System.Drawing.Point(10,110)
$panel4.Controls.Add($button2)


# Input 3
$textBoxInput3 = New-Object System.Windows.Forms.TextBox
$textBoxInput3.Size = New-Object System.Drawing.Size(230,25)
$textBoxInput3.Location = New-Object System.Drawing.Point(10,150)
$panel4.Controls.Add($textBoxInput3)

$button3 = New-Object System.Windows.Forms.Button
$button3.Text = "Block an domain"
$button3.Size = New-Object System.Drawing.Size(100,25)
$button3.Location = New-Object System.Drawing.Point(10,180)
$panel4.Controls.Add($button3)


# Input 4
$textBoxInput4 = New-Object System.Windows.Forms.TextBox
$textBoxInput4.Size = New-Object System.Drawing.Size(230,25)
$textBoxInput4.Location = New-Object System.Drawing.Point(10,220)
$panel4.Controls.Add($textBoxInput4)

$button4 = New-Object System.Windows.Forms.Button
$button4.Text = "Block an email"
$button4.Size = New-Object System.Drawing.Size(100,25)
$button4.Location = New-Object System.Drawing.Point(10,250)
$panel4.Controls.Add($button4)

$form.Controls.Add($panel4)



# Removal Input 1 (For Column 1)
$textBoxRemove1 = New-Object System.Windows.Forms.TextBox
$textBoxRemove1.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove1.Location = New-Object System.Drawing.Point(10,10)
$panel5.Controls.Add($textBoxRemove1)

$buttonRemove1 = New-Object System.Windows.Forms.Button
$buttonRemove1.Text = "Remove IP"
$buttonRemove1.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove1.Location = New-Object System.Drawing.Point(10,40)
$panel5.Controls.Add($buttonRemove1)


# Removal Input 2 (For Column 2)
$textBoxRemove2 = New-Object System.Windows.Forms.TextBox
$textBoxRemove2.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove2.Location = New-Object System.Drawing.Point(10,80)
$panel5.Controls.Add($textBoxRemove2)

$buttonRemove2 = New-Object System.Windows.Forms.Button
$buttonRemove2.Text = "Remove Domain"
$buttonRemove2.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove2.Location = New-Object System.Drawing.Point(10,110)
$panel5.Controls.Add($buttonRemove2)


# Removal Input 3 (For Column 3)
$textBoxRemove3 = New-Object System.Windows.Forms.TextBox
$textBoxRemove3.Size = New-Object System.Drawing.Size(230,25)
$textBoxRemove3.Location = New-Object System.Drawing.Point(10,150)
$panel5.Controls.Add($textBoxRemove3)

$buttonRemove3 = New-Object System.Windows.Forms.Button
$buttonRemove3.Text = "Remove Email"
$buttonRemove3.Size = New-Object System.Drawing.Size(100,25)
$buttonRemove3.Location = New-Object System.Drawing.Point(10,180)
$panel5.Controls.Add($buttonRemove3)

$form.Controls.Add($panel5)