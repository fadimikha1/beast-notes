# Windows 11 Support Notes App - layout skeleton
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# XAML layout: menu, notes body, info strips, action buttons
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Support Notes" Height="750" Width="1100" WindowStartupLocation="CenterScreen"
        Background="#f5f5f5" Foreground="#1a1a1a" FontFamily="Segoe UI" FontSize="14">
    <Window.Resources>
        <Style TargetType="Label">
            <Setter Property="Foreground" Value="#1a1a1a"/>
            <Setter Property="Margin" Value="0 0 6 0"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Padding" Value="6"/>
            <Setter Property="Margin" Value="0 0 10 0"/>
            <Setter Property="Background" Value="White"/>
            <Setter Property="Foreground" Value="#1a1a1a"/>
            <Setter Property="BorderBrush" Value="#d1d5db"/>
            <Setter Property="BorderThickness" Value="1"/>
        </Style>
        <Style x:Key="ClickableField" TargetType="TextBox">
            <Setter Property="Padding" Value="6"/>
            <Setter Property="Margin" Value="0 0 10 0"/>
            <Setter Property="Background" Value="White"/>
            <Setter Property="Foreground" Value="#1a1a1a"/>
            <Setter Property="BorderBrush" Value="#60a5fa"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="IsReadOnly" Value="True"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Padding" Value="10 6"/>
            <Setter Property="Margin" Value="6 0 0 0"/>
            <Setter Property="Background" Value="#3b82f6"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderBrush" Value="#2563eb"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <SolidColorBrush x:Key="Card" Color="White"/>
    </Window.Resources>

    <DockPanel LastChildFill="True">
        <Menu DockPanel.Dock="Top" Background="White" Foreground="#1a1a1a">
            <MenuItem Header="File">
                <MenuItem Header="New" x:Name="MenuNew"/>
                <MenuItem Header="Open" x:Name="MenuOpen"/>
                <Separator/>
                <MenuItem Header="Save" x:Name="MenuSave"/>
                <MenuItem Header="Save As" x:Name="MenuSaveAs"/>
                <Separator/>
                <MenuItem Header="Exit" x:Name="MenuExit"/>
            </MenuItem>
            <MenuItem Header="Insert">
                <MenuItem Header="Checklist" x:Name="MenuChecklist"/>
                <MenuItem Header="Escalation" x:Name="MenuEscalation"/>
            </MenuItem>
            <MenuItem Header="Help" x:Name="MenuHelp"/>
        </Menu>

        <Grid Margin="10" DockPanel.Dock="Bottom">
            <Grid.RowDefinitions>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <!-- Notes body with spell check -->
            <Border Grid.Row="0" Background="{StaticResource Card}" CornerRadius="4" Padding="10" BorderBrush="#d1d5db" BorderThickness="1">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <TextBox x:Name="NotesBox" Grid.Row="0" AcceptsReturn="True" VerticalScrollBarVisibility="Auto" SpellCheck.IsEnabled="True"
                             TextWrapping="Wrap" Background="White" BorderBrush="#d1d5db" BorderThickness="1"/>
                </Grid>
            </Border>

            <!-- Info strip: auto-filled metadata (clickable to copy, right-click to edit) -->
            <Border Grid.Row="1" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="10" BorderBrush="#d1d5db" BorderThickness="1">
                <UniformGrid Columns="6" Rows="1" Margin="0" HorizontalAlignment="Stretch">
                    <StackPanel Orientation="Vertical">
                        <Label Content="Asset Tag"/>
                        <TextBox x:Name="AssetTagBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Machine Name"/>
                        <TextBox x:Name="MachineNameBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="IP Address"/>
                        <TextBox x:Name="IpAddressBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="User Name"/>
                        <TextBox x:Name="UserNameBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Phone"/>
                        <TextBox x:Name="PhoneBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Ticket"/>
                        <TextBox x:Name="TicketBox" Style="{StaticResource ClickableField}"/>
                    </StackPanel>
                </UniformGrid>
            </Border>

            <!-- Quick add buttons placeholder -->
            <Border Grid.Row="2" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="10" BorderBrush="#d1d5db" BorderThickness="1">
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                    <Label Content="Quick Add:" Margin="0 0 10 0"/>
                    <Button x:Name="BtnAddTemplateA" Content="Template A"/>
                    <Button x:Name="BtnAddTemplateB" Content="Template B"/>
                    <Button x:Name="BtnAddTemplateC" Content="Template C"/>
                </StackPanel>
            </Border>

            <!-- Clipboard + checklists row with timer, note counter, navigation -->
            <Border Grid.Row="3" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="10" BorderBrush="#d1d5db" BorderThickness="1">
                <Grid>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                        <Button x:Name="BtnCopy" Content="Copy Notes"/>
                        <Button x:Name="BtnEscalation" Content="Escalation"/>
                        <Button x:Name="BtnChecklist" Content="Checklist"/>
                    </StackPanel>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                        <Label x:Name="TimerLabel" Content="00:00" FontSize="16" FontWeight="Bold" Margin="0 0 15 0"/>
                        <Label x:Name="NoteCountLabel" Content="Note: 1" FontSize="16" FontWeight="Bold" Margin="0 0 10 0"/>
                        <Button x:Name="BtnPrevNote" Content="◄" Width="40" Margin="0 0 5 0"/>
                        <Button x:Name="BtnNextNote" Content="►" Width="40"/>
                    </StackPanel>
                </Grid>
            </Border>
        </Grid>
    </DockPanel>
</Window>
"@

# Parse XAML and build window
$reader = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Helper to wire up controls
$NotesBox       = $window.FindName('NotesBox')
$AssetTagBox    = $window.FindName('AssetTagBox')
$MachineNameBox = $window.FindName('MachineNameBox')
$IpAddressBox   = $window.FindName('IpAddressBox')
$UserNameBox    = $window.FindName('UserNameBox')
$PhoneBox       = $window.FindName('PhoneBox')
$TicketBox      = $window.FindName('TicketBox')
$BtnCopy        = $window.FindName('BtnCopy')
$BtnChecklist   = $window.FindName('BtnChecklist')
$BtnEscalation  = $window.FindName('BtnEscalation')
$BtnAddTemplateA = $window.FindName('BtnAddTemplateA')
$BtnAddTemplateB = $window.FindName('BtnAddTemplateB')
$BtnAddTemplateC = $window.FindName('BtnAddTemplateC')
$TimerLabel     = $window.FindName('TimerLabel')
$NoteCountLabel = $window.FindName('NoteCountLabel')
$BtnPrevNote    = $window.FindName('BtnPrevNote')
$BtnNextNote    = $window.FindName('BtnNextNote')

# Note management state
$script:notes = @(@{
    NotesText = ""
    AssetTag = ""
    MachineName = ""
    IpAddress = ""
    UserName = ""
    Phone = ""
    Ticket = ""
    StartTime = Get-Date
})
$script:currentNoteIndex = 0

# Timer for note duration
$script:timerDispatcher = [System.Windows.Threading.DispatcherTimer]::new()
$script:timerDispatcher.Interval = [TimeSpan]::FromSeconds(1)
$script:timerDispatcher.Add_Tick({
    $elapsed = (Get-Date) - $script:notes[$script:currentNoteIndex].StartTime
    $TimerLabel.Content = "{0:mm\:ss}" -f ([datetime]$elapsed.Ticks)
})
$script:timerDispatcher.Start()

# Helper: Save current note state
function Save-CurrentNote {
    $script:notes[$script:currentNoteIndex].NotesText = $NotesBox.Text
    $script:notes[$script:currentNoteIndex].AssetTag = $AssetTagBox.Text
    $script:notes[$script:currentNoteIndex].MachineName = $MachineNameBox.Text
    $script:notes[$script:currentNoteIndex].IpAddress = $IpAddressBox.Text
    $script:notes[$script:currentNoteIndex].UserName = $UserNameBox.Text
    $script:notes[$script:currentNoteIndex].Phone = $PhoneBox.Text
    $script:notes[$script:currentNoteIndex].Ticket = $TicketBox.Text
}

# Helper: Load note into UI
function Load-Note {
    param([int]$index)
    $note = $script:notes[$index]
    $NotesBox.Text = $note.NotesText
    $AssetTagBox.Text = $note.AssetTag
    $MachineNameBox.Text = $note.MachineName
    $IpAddressBox.Text = $note.IpAddress
    $UserNameBox.Text = $note.UserName
    $PhoneBox.Text = $note.Phone
    $TicketBox.Text = $note.Ticket
    $NoteCountLabel.Content = "Note: $($index + 1)"
}

# Helper: Create context menu for editing field value
function Add-FieldContextMenu {
    param($textBox, $fieldName)
    
    # Left-click copies field to clipboard
    $textBox.Add_MouseLeftButtonDown({
        if ($this.Text) {
            Set-Clipboard -Value $this.Text
        }
    })
    
    # Right-click opens edit dialog
    $textBox.Add_MouseRightButtonDown({
        param($sender, $e)
        $inputDialog = New-Object System.Windows.Window
        $inputDialog.Title = "Edit $fieldName"
        $inputDialog.Width = 400
        $inputDialog.Height = 150
        $inputDialog.WindowStartupLocation = "CenterOwner"
        $inputDialog.Owner = $window
        $inputDialog.Background = "#f5f5f5"
        
        $grid = New-Object System.Windows.Controls.Grid
        $grid.Margin = "15"
        
        $rowDef1 = New-Object System.Windows.Controls.RowDefinition
        $rowDef1.Height = "Auto"
        $rowDef2 = New-Object System.Windows.Controls.RowDefinition
        $rowDef2.Height = "*"
        $rowDef3 = New-Object System.Windows.Controls.RowDefinition
        $rowDef3.Height = "Auto"
        $grid.RowDefinitions.Add($rowDef1)
        $grid.RowDefinitions.Add($rowDef2)
        $grid.RowDefinitions.Add($rowDef3)
        
        $label = New-Object System.Windows.Controls.Label
        $label.Content = $fieldName
        $label.Margin = "0 0 0 5"
        [System.Windows.Controls.Grid]::SetRow($label, 0)
        
        $inputBox = New-Object System.Windows.Controls.TextBox
        $inputBox.Text = $this.Text
        $inputBox.Padding = "6"
        $inputBox.Margin = "0 0 0 10"
        [System.Windows.Controls.Grid]::SetRow($inputBox, 1)
        
        $buttonPanel = New-Object System.Windows.Controls.StackPanel
        $buttonPanel.Orientation = "Horizontal"
        $buttonPanel.HorizontalAlignment = "Right"
        [System.Windows.Controls.Grid]::SetRow($buttonPanel, 2)
        
        $okButton = New-Object System.Windows.Controls.Button
        $okButton.Content = "OK"
        $okButton.Padding = "15 5"
        $okButton.Margin = "0 0 5 0"
        $okButton.Background = "#3b82f6"
        $okButton.Foreground = "White"
        $okButton.Add_Click({
            $sender.Text = $inputBox.Text
            $inputDialog.Close()
        }.GetNewClosure())
        
        $cancelButton = New-Object System.Windows.Controls.Button
        $cancelButton.Content = "Cancel"
        $cancelButton.Padding = "15 5"
        $cancelButton.Background = "#9ca3af"
        $cancelButton.Foreground = "White"
        $cancelButton.Add_Click({ $inputDialog.Close() })
        
        $buttonPanel.Children.Add($okButton) | Out-Null
        $buttonPanel.Children.Add($cancelButton) | Out-Null
        
        $grid.Children.Add($label) | Out-Null
        $grid.Children.Add($inputBox) | Out-Null
        $grid.Children.Add($buttonPanel) | Out-Null
        
        $inputDialog.Content = $grid
        $inputBox.Focus() | Out-Null
        $inputDialog.ShowDialog() | Out-Null
        $e.Handled = $true
    }.GetNewClosure())
}

# Wire up clickable fields
Add-FieldContextMenu $AssetTagBox "Asset Tag"
Add-FieldContextMenu $MachineNameBox "Machine Name"
Add-FieldContextMenu $IpAddressBox "IP Address"
Add-FieldContextMenu $UserNameBox "User Name"
Add-FieldContextMenu $PhoneBox "Phone"
Add-FieldContextMenu $TicketBox "Ticket"

# Navigation buttons
$BtnPrevNote.Add_Click({
    Save-CurrentNote
    if ($script:currentNoteIndex -gt 0) {
        $script:currentNoteIndex--
        Load-Note $script:currentNoteIndex
    }
})

$BtnNextNote.Add_Click({
    Save-CurrentNote
    $script:currentNoteIndex++
    if ($script:currentNoteIndex -ge $script:notes.Count) {
        $script:notes += @{
            NotesText = ""
            AssetTag = ""
            MachineName = ""
            IpAddress = ""
            UserName = ""
            Phone = ""
            Ticket = ""
            StartTime = Get-Date
        }
    }
    Load-Note $script:currentNoteIndex
})

# Action buttons
$BtnCopy.Add_Click({
    Set-Clipboard -Value $NotesBox.Text
})
$BtnChecklist.Add_Click({
    $NotesBox.AppendText("`n[Checklist placeholder]\n- Item 1\n- Item 2\n")
})
$BtnEscalation.Add_Click({
    $NotesBox.AppendText("`n[Escalation placeholder]\n- Action 1\n- Action 2\n")
})
$BtnAddTemplateA.Add_Click({ $NotesBox.AppendText("`n[Template A]") })
$BtnAddTemplateB.Add_Click({ $NotesBox.AppendText("`n[Template B]") })
$BtnAddTemplateC.Add_Click({ $NotesBox.AppendText("`n[Template C]") })

# Safe close on menu exit
$window.FindName('MenuExit').Add_Click({ 
    $script:timerDispatcher.Stop()
    $window.Close() 
})

# Show window
$null = $window.ShowDialog()
