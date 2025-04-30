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



# Input 1
$textBoxInput1 = Create-Text-Box -len 10
$panel4.Controls.Add($textBoxInput1)
$button1 = Create-Button -text "Block a IP" -len 40
$panel4.Controls.Add($button1)


# Input 2
$textBoxInput2 = Create-Text-Box -len 80
$panel4.Controls.Add($textBoxInput2)
$button2 = Create-Button -text "Block a IP (CIDR)" -len 110
$panel4.Controls.Add($button2)


# Input 3
$textBoxInput3 = Create-Text-Box -len 150
$panel4.Controls.Add($textBoxInput3)
$button3 = Create-Button -text "Block an domain" -len 180
$panel4.Controls.Add($button3)


# Input 4
$textBoxInput4 = Create-Text-Box -len 220
$panel4.Controls.Add($textBoxInput4)
$button4 = Create-Button -text "Block an email" -len 250 
$panel4.Controls.Add($button4)



$form.Controls.Add($panel4)



# Removal Input 1 (For Column 1)
$textBoxRemove1 = Create-Text-Box -len 10
$panel5.Controls.Add($textBoxRemove1)
$buttonRemove1 = Create-Button -text "Remove IP" -len 40
$panel5.Controls.Add($buttonRemove1)


# Removal Input 2 (For Column 2)
$textBoxRemove2 = Create-Text-Box -len 150
$panel5.Controls.Add($textBoxRemove2)
$buttonRemove2 = Create-Button -text "Remove Domain" -len 180
$panel5.Controls.Add($buttonRemove2)


# Removal Input 3 (For Column 3)
$textBoxRemove3 = Create-Text-Box -len 220
$panel5.Controls.Add($textBoxRemove3)
$buttonRemove3 = Create-Button -text "Remove Email" -len 250
$panel5.Controls.Add($buttonRemove3)



$form.Controls.Add($panel5)