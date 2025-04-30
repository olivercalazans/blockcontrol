function Create-Display-Panel {
    param([int]$len)
        $panel             = New-Object System.Windows.Forms.Panel
        $panel.Size        = New-Object System.Drawing.Size(250,300)
        $panel.Location    = New-Object System.Drawing.Point($len,20)
        $panel.BorderStyle = 'FixedSingle'

        $box = New-Object System.Windows.Forms.TextBox
        $box.Multiline  = $true
        $box.WordWrap   = $false
        $box.ScrollBars = 'Both'
        $box.Dock       = 'Fill'
        $panel.Controls.Add($box)
        $form.Controls.Add($panel)
        return @{ 'panel' = $panel; 'box' = $box}
}


$result1 = Create-Display-Panel -len 20
$panel1  = $result1['panel']
$box1    = $result1['box']

$result2 = Create-Display-Panel -len 290
$panel2  = $result2['panel']
$box2    = $result2['box']


$result3 = Create-Display-Panel -len 560
$panel3  = $result3['panel']
$box3    = $result3['box']




function Create-Input-Panel {
    param ([int]$len)
    $panel = New-Object System.Windows.Forms.Panel
    $panel.Size = New-Object System.Drawing.Size(250,300)
    $panel.Location = New-Object System.Drawing.Point($len,20)
    $panel.BorderStyle = 'FixedSingle'
    return $panel
    
}


$panel4 = Create-Input-Panel -len 830
$panel5 = Create-Input-Panel -len 1100
