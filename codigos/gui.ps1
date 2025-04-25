Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Command Outputs and Input"
$form.Size = New-Object System.Drawing.Size(1300,400)

# Panel 1: Output of the first command
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

# Panel 2: Output of the second command
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

# Panel 3: Output of the third command
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

# Panel 4: Input fields and add button
$panel4 = New-Object System.Windows.Forms.Panel
$panel4.Size = New-Object System.Drawing.Size(250,300)
$panel4.Location = New-Object System.Drawing.Point(830,20)
$panel4.BorderStyle = 'FixedSingle'

# Input 1
$textBoxInput1 = New-Object System.Windows.Forms.TextBox
$textBoxInput1.Size = New-Object System.Drawing.Size(230,30)
$textBoxInput1.Location = New-Object System.Drawing.Point(10,10)
$panel4.Controls.Add($textBoxInput1)

# Input 2
$textBoxInput2 = New-Object System.Windows.Forms.TextBox
$textBoxInput2.Size = New-Object System.Drawing.Size(230,30)
$textBoxInput2.Location = New-Object System.Drawing.Point(10,50)
$panel4.Controls.Add($textBoxInput2)

# Input 3
$textBoxInput3 = New-Object System.Windows.Forms.TextBox
$textBoxInput3.Size = New-Object System.Drawing.Size(230,30)
$textBoxInput3.Location = New-Object System.Drawing.Point(10,90)
$panel4.Controls.Add($textBoxInput3)

# Button to add new item
$buttonAdd = New-Object System.Windows.Forms.Button
$buttonAdd.Text = "Add Item"
$buttonAdd.Size = New-Object System.Drawing.Size(100,30)
$buttonAdd.Location = New-Object System.Drawing.Point(10,130)
$panel4.Controls.Add($buttonAdd)

$form.Controls.Add($panel4)

# Sample lists (or data structure) to simulate adding
$list1 = @()
$list2 = @()
$list3 = @()

# Refresh logic for all outputs
function Refresh-Output {
    # Replace with your real commands
    $output1 = Get-Process | Select-Object -First 5 | Out-String
    $output2 = Get-Service | Select-Object -First 5 | Out-String
    $output3 = Get-Date | Out-String  # New example command (replace with actual command)

    $box1.Text = $output1
    $box2.Text = $output2
    $box3.Text = $output3
}

$buttonAdd.Add_Click({
    if ($textBoxInput1.Text -or $textBoxInput2.Text -or $textBoxInput3.Text) {
        $list1 += $textBoxInput1.Text
        $list2 += $textBoxInput2.Text
        $list3 += $textBoxInput3.Text
        $textBoxInput1.Clear()
        $textBoxInput2.Clear()
        $textBoxInput3.Clear()
        Refresh-Output
    }
})

Refresh-Output
$form.ShowDialog()
