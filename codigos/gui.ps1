Add-Type -AssemblyName System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$form.Text = "Command Outputs and List"
$form.Size = New-Object System.Drawing.Size(800,600)

# Panel 1: Output of the first command
$panel1 = New-Object System.Windows.Forms.Panel
$panel1.Size = New-Object System.Drawing.Size(740,150)
$panel1.Location = New-Object System.Drawing.Point(20,20)
$panel1.BorderStyle = 'FixedSingle'

$box1 = New-Object System.Windows.Forms.TextBox
$box1.Multiline = $true
$box1.Dock = 'Fill'
$panel1.Controls.Add($box1)

$form.Controls.Add($panel1)

# Panel 2: Output of the second command
$panel2 = New-Object System.Windows.Forms.Panel
$panel2.Size = New-Object System.Drawing.Size(740,150)
$panel2.Location = New-Object System.Drawing.Point(20,180)
$panel2.BorderStyle = 'FixedSingle'

$box2 = New-Object System.Windows.Forms.TextBox
$box2.Multiline = $true
$box2.Dock = 'Fill'
$panel2.Controls.Add($box2)

$form.Controls.Add($panel2)

# Panel 3: Input and button to add items
$panel3 = New-Object System.Windows.Forms.Panel
$panel3.Size = New-Object System.Drawing.Size(740,150)
$panel3.Location = New-Object System.Drawing.Point(20,340)
$panel3.BorderStyle = 'FixedSingle'

# Input field
$textBoxInput = New-Object System.Windows.Forms.TextBox
$textBoxInput.Size = New-Object System.Drawing.Size(500,30)
$textBoxInput.Location = New-Object System.Drawing.Point(10,10)
$panel3.Controls.Add($textBoxInput)

# Button to add new item
$buttonAdd = New-Object System.Windows.Forms.Button
$buttonAdd.Text = "Add Item"
$buttonAdd.Size = New-Object System.Drawing.Size(100,30)
$buttonAdd.Location = New-Object System.Drawing.Point(520,10)
$panel3.Controls.Add($buttonAdd)

$form.Controls.Add($panel3)

# Example list to be updated
$list1 = @()
$list2 = @()

# Define refresh logic to run commands and update outputs
function Refresh-Output {
    # Run commands (replace these with your actual commands)
    $output1 = Get-Process | Select-Object -First 5 | Out-String  # First command output
    $output2 = Get-Service | Select-Object -First 5 | Out-String  # Second command output

    # Update the TextBoxes with the new output
    $box1.Text = $output1
    $box2.Text = $output2
}

# Button click event: Add input to list and refresh outputs
$buttonAdd.Add_Click({
    if ($textBoxInput.Text) {
        # Add input to both lists
        $list1 += $textBoxInput.Text
        $list2 += $textBoxInput.Text

        # Clear the input field
        $textBoxInput.Clear()

        # Refresh outputs after adding the item
        Refresh-Output
    }
})

# Initial refresh to display command outputs
Refresh-Output

# Show the form
$form.ShowDialog()
