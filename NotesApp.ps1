# Windows 11 Support Notes App - layout skeleton
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# XAML layout: menu, notes body, info strips, action buttons
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Beast Notes" Height="750" Width="1100" WindowStartupLocation="CenterScreen"
        Background="#1e1e1e" Foreground="#e0e0e0" FontFamily="Segoe UI" FontSize="14">
    <Window.Resources>
        <Style TargetType="Label">
            <Setter Property="Foreground" Value="#e0e0e0"/>
            <Setter Property="Margin" Value="0 0 3 0"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Padding" Value="3"/>
            <Setter Property="Margin" Value="0 0 4 0"/>
            <Setter Property="Background" Value="#2d2d2d"/>
            <Setter Property="Foreground" Value="#e0e0e0"/>
            <Setter Property="BorderBrush" Value="#3f3f3f"/>
            <Setter Property="BorderThickness" Value="1"/>
        </Style>
        <Style x:Key="ClickableField" TargetType="TextBox">
            <Setter Property="Padding" Value="3"/>
            <Setter Property="Margin" Value="0 0 4 0"/>
            <Setter Property="Background" Value="#2d2d2d"/>
            <Setter Property="Foreground" Value="#e0e0e0"/>
            <Setter Property="BorderBrush" Value="#60a5fa"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="IsReadOnly" Value="True"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Padding" Value="4 0"/>
            <Setter Property="Margin" Value="2 0 0 0"/>
            <Setter Property="Height" Value="22"/>
            <Setter Property="Background" Value="#0078d4"/>
            <Setter Property="Foreground" Value="White"/>
            <Setter Property="BorderBrush" Value="#005a9e"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <SolidColorBrush x:Key="Card" Color="#252526"/>
    </Window.Resources>

    <DockPanel LastChildFill="True">
        <Menu DockPanel.Dock="Top" Background="#2d2d2d" Foreground="#e0e0e0">
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

        <Grid Margin="2" DockPanel.Dock="Bottom">
            <Grid.RowDefinitions>
                <RowDefinition Height="*"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>

            <!-- Notes body with spell check (primary space) -->
            <Border Grid.Row="0" Background="{StaticResource Card}" CornerRadius="4" Padding="6" BorderBrush="#3f3f3f" BorderThickness="1">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <TextBox x:Name="NotesBox" Grid.Row="0" AcceptsReturn="True" VerticalScrollBarVisibility="Auto" SpellCheck.IsEnabled="True"
                             TextWrapping="Wrap" Background="#2d2d2d" Foreground="#e0e0e0" BorderBrush="#3f3f3f" BorderThickness="1" FontSize="16"/>
                </Grid>
            </Border>

            <!-- Info strip: auto-filled metadata (clickable to copy, right-click to edit) -->
            <Border Grid.Row="1" Margin="0 2 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="1.5" BorderBrush="#3f3f3f" BorderThickness="1" MinHeight="0">
                <UniformGrid Columns="6" Rows="1" Margin="0" HorizontalAlignment="Stretch">
                    <TextBox x:Name="AssetTagBox" Style="{StaticResource ClickableField}" Tag="Asset Tag"/>
                    <TextBox x:Name="MachineNameBox" Style="{StaticResource ClickableField}" Tag="Machine Name"/>
                    <TextBox x:Name="IpAddressBox" Style="{StaticResource ClickableField}" Tag="IP Address"/>
                    <TextBox x:Name="UserNameBox" Style="{StaticResource ClickableField}" Tag="User Name"/>
                    <TextBox x:Name="PhoneBox" Style="{StaticResource ClickableField}" Tag="Phone"/>
                    <TextBox x:Name="TicketBox" Style="{StaticResource ClickableField}" Tag="Ticket"/>
                </UniformGrid>
            </Border>

            <!-- Quick add buttons placeholder -->
            <Border Grid.Row="2" Margin="0 2 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="1.5" BorderBrush="#3f3f3f" BorderThickness="1" MinHeight="0">
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                    <Button x:Name="BtnAddTemplateA" Content="NIPR" Margin="0 0 0 0" Padding="4 1"/>
                    <Button x:Name="BtnAddTemplateB" Content="RA"/>
                    <Button x:Name="BtnAddTemplateC" Content="RDC"/>
                    <Button x:Name="BtnAddTemplateD" Content="UNC"/>
                </StackPanel>
            </Border>

            <!-- Clipboard + checklists row with timer, note counter, navigation -->
            <Border Grid.Row="3" Margin="0 2 0 0" Background="{StaticResource Card}" CornerRadius="4" Padding="1.5" BorderBrush="#3f3f3f" BorderThickness="1" MinHeight="0">
                <Grid>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                        <Button x:Name="BtnCopy" Content="Copy Notes"/>
                        <Button x:Name="BtnEscalation" Content="Escalation"/>
                        <Button x:Name="BtnChecklist" Content="Checklist"/>
                    </StackPanel>
                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                            <Label x:Name="TimerLabel" Content="00:00" FontSize="14" FontWeight="Bold" Margin="0 0 12 0"/>
                            <Label x:Name="NoteCountLabel" Content="Note: 1" FontSize="14" FontWeight="Bold" Margin="0 0 8 0"/>
                            <Button x:Name="BtnPrevNote" Content="&lt;" Width="36" Margin="0 0 4 0" FontSize="18" FontWeight="Bold"/>
                            <Button x:Name="BtnNextNote" Content="&gt;" Width="36" FontSize="18" FontWeight="Bold"/>
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
$BtnAddTemplateD = $window.FindName('BtnAddTemplateD')
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
    ElapsedTime = [TimeSpan]::Zero
    SelectedTemplates = @('NIPR')
})
$script:currentNoteIndex = 0

# Quick template notes (injected after Phone when copying)
$script:templateNotes = @{
    NIPR = "NIPR"
    RA = @"
Connected with MSRA, verified with user that no sensitive information was displayed.
KM005609: HOW TO: Set Up Microsoft Windows Remote Assistance for Remote Control in Windows
"@.Trim()
    RDC = @"
Connected with RDC, received permission to connect into the background of the machine.
KM000783: HOW TO: Connect With Microsoft RDC
"@.Trim()
    UNC = @"
Connected with UNC, received permission to connect into the background of the machine.
KM000805: HOW TO: Connect to a Remote Computer or Folder Using Map Network Drive or UNC
"@.Trim()
}
$script:selectedTemplateKeys = New-Object System.Collections.Generic.List[string]
$script:selectedTemplateKeys.Add('NIPR')
$script:templateSelectedBrush = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(250, 204, 21)) # yellow
$script:templateDefaultBrush = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(0, 120, 212)) # default blue

# Escalation quick-pick items
$script:escalationItems = @(
    "SVD.Voice Mail/Email"
    "SVD.NNPI"
    "SVD.Classified"
    "SvD.Flank Speed Tier 1.5"
    "SVD.Remote Support USN"
    "SVD.Remote Support ESD"
)

# Checklist quick-pick items (display order + content)
$script:checklistItems = @{
    Location = @"
---Location Information---
Base: 
Building: 
Floor: 
Room/Cube: 
Contact:
Contact Number: 
Alt Contact: 
Alt Number: 
"@.Trim()
    Printer = @"
KM000828: HOW TO: Network Printer Troubleshooting
Asset tag:
Printer name:
Printer IP :
Port Number:
Printer Tier:
Server:

---Location Information---
Base: 
Building: 
Floor: 
Room/Cube: 
Contact:
Contact Number: 
Alt Contact: 
Alt Number: 
"@.Trim()
    BUR = @"
 KM000633: CHECKLIST: BUR
Date to restore from: 
Full path name of old data: 
Specific files / folders to restore: 
Restore to path: 
Overwrite data (or rename information)? 
User's name: first.m.last
Site: 
User can be reached at: 
Attempted to restore from Snapshot. 
Date and Time of Last Snapshot entry: Date? / Time?
"@.Trim()
}
$script:checklistOrder = @("Location", "Printer", "BUR")

function Set-TemplateButtonState {
    param(
        [System.Windows.Controls.Button]$Button,
        [bool]$Selected
    )
    if ($Selected) {
        $Button.Background = $script:templateSelectedBrush
        $Button.Foreground = "#1e1e1e"
    } else {
        $Button.Background = $script:templateDefaultBrush
        $Button.Foreground = "White"
    }
}

function Toggle-TemplateSelection {
    param(
        [string]$Key,
        [System.Windows.Controls.Button]$Button
    )

    if ($script:selectedTemplateKeys.Contains($Key)) {
        [void]$script:selectedTemplateKeys.Remove($Key)
        Set-TemplateButtonState -Button $Button -Selected:$false
    } else {
        $script:selectedTemplateKeys.Add($Key)
        Set-TemplateButtonState -Button $Button -Selected:$true
    }
}

# Show escalation picker and copy chosen value
function Show-EscalationMenu {
    param(
        [System.Windows.Controls.Button]$Button,
        [string[]]$Items
    )

    $menu = New-Object System.Windows.Controls.ContextMenu
    foreach ($text in $Items) {
        $item = New-Object System.Windows.Controls.MenuItem
        $item.Header = $text
        $item.Add_Click({
            $script:ignoreNextClipboardChange = $true
            [System.Windows.Clipboard]::SetText($this.Header)
            $menu.IsOpen = $false
        }.GetNewClosure())
        [void]$menu.Items.Add($item)
    }

    $menu.PlacementTarget = $Button
    $menu.Placement = [System.Windows.Controls.Primitives.PlacementMode]::Bottom
    $menu.IsOpen = $true
}

# Show checklist picker and copy chosen template
function Show-ChecklistMenu {
    param(
        [System.Windows.Controls.Button]$Button,
        [hashtable]$Items,
        [string[]]$Order
    )

    $menu = New-Object System.Windows.Controls.ContextMenu
    foreach ($key in $Order) {
        $content = $Items[$key]
        if ($null -ne $content) {
            $item = New-Object System.Windows.Controls.MenuItem
            $item.Header = $key
            $item.Add_Click({
                $script:ignoreNextClipboardChange = $true
                [System.Windows.Clipboard]::SetText($content)
                $menu.IsOpen = $false
            }.GetNewClosure())
            [void]$menu.Items.Add($item)
        }
    }

    $menu.PlacementTarget = $Button
    $menu.Placement = [System.Windows.Controls.Primitives.PlacementMode]::Bottom
    $menu.IsOpen = $true
}

# Timer for note duration
$script:timerDispatcher = [System.Windows.Threading.DispatcherTimer]::new()
$script:timerDispatcher.Interval = [TimeSpan]::FromSeconds(1)
$script:timerDispatcher.Add_Tick({
    $currentNote = $script:notes[$script:currentNoteIndex]
    $elapsed = $currentNote.ElapsedTime + ((Get-Date) - $currentNote.StartTime)
    $TimerLabel.Content = "{0:mm\:ss}" -f ([datetime]$elapsed.Ticks)
})
$script:timerDispatcher.Start()

# Helper: Save current note state (skip placeholder text)
function Save-CurrentNote {
    # Save elapsed time before switching
    $currentNote = $script:notes[$script:currentNoteIndex]
    $currentNote.ElapsedTime = $currentNote.ElapsedTime + ((Get-Date) - $currentNote.StartTime)
    
    $script:notes[$script:currentNoteIndex].NotesText = $NotesBox.Text
    $script:notes[$script:currentNoteIndex].AssetTag = if ($AssetTagBox.Tag.IsPlaceholder) { "" } else { $AssetTagBox.Text }
    $script:notes[$script:currentNoteIndex].MachineName = if ($MachineNameBox.Tag.IsPlaceholder) { "" } else { $MachineNameBox.Text }
    $script:notes[$script:currentNoteIndex].IpAddress = if ($IpAddressBox.Tag.IsPlaceholder) { "" } else { $IpAddressBox.Text }
    $script:notes[$script:currentNoteIndex].UserName = if ($UserNameBox.Tag.IsPlaceholder) { "" } else { $UserNameBox.Text }
    $script:notes[$script:currentNoteIndex].Phone = if ($PhoneBox.Tag.IsPlaceholder) { "" } else { $PhoneBox.Text }
    $script:notes[$script:currentNoteIndex].Ticket = if ($TicketBox.Tag.IsPlaceholder) { "" } else { $TicketBox.Text }
    $script:notes[$script:currentNoteIndex].SelectedTemplates = @($script:selectedTemplateKeys)
}

# Helper: Load note into UI
function Load-Note {
    param([int]$index)
    $note = $script:notes[$index]
    # Reset start time for the newly loaded note
    $note.StartTime = Get-Date
    
    $NotesBox.Text = $note.NotesText
    $AssetTagBox.Text = $note.AssetTag
    $MachineNameBox.Text = $note.MachineName
    $IpAddressBox.Text = $note.IpAddress
    $UserNameBox.Text = $note.UserName
    $PhoneBox.Text = $note.Phone
    $TicketBox.Text = $note.Ticket
    $NoteCountLabel.Content = "Note: $($index + 1)"
    
    # Reset background colors for pingable fields
    $defaultBrush = New-Object System.Windows.Media.SolidColorBrush([System.Windows.Media.Color]::FromRgb(45, 45, 45))
    $MachineNameBox.Background = $defaultBrush
    $IpAddressBox.Background = $defaultBrush
    
    # Update placeholders
    Update-Placeholder $AssetTagBox "Asset Tag"
    Update-Placeholder $MachineNameBox "Machine Name"
    Update-Placeholder $IpAddressBox "IP Address"
    Update-Placeholder $UserNameBox "User Name"
    Update-Placeholder $PhoneBox "Phone"
    Update-Placeholder $TicketBox "Ticket"
    
    # Restore template button selections from note
    $script:selectedTemplateKeys.Clear()
    if ($note.SelectedTemplates) {
        foreach ($key in $note.SelectedTemplates) {
            $script:selectedTemplateKeys.Add($key)
        }
    } else {
        # Default to NIPR if no templates saved
        $script:selectedTemplateKeys.Add('NIPR')
    }
    Set-TemplateButtonState -Button $BtnAddTemplateA -Selected:($script:selectedTemplateKeys.Contains('NIPR'))
    Set-TemplateButtonState -Button $BtnAddTemplateB -Selected:($script:selectedTemplateKeys.Contains('RA'))
    Set-TemplateButtonState -Button $BtnAddTemplateC -Selected:($script:selectedTemplateKeys.Contains('RDC'))
    Set-TemplateButtonState -Button $BtnAddTemplateD -Selected:($script:selectedTemplateKeys.Contains('UNC'))
    
    # Re-run ping tests if fields have values
    if ($note.MachineName -and $note.MachineName.Trim() -ne "") {
        Test-HostReachability $note.MachineName $MachineNameBox $window
    }
    if ($note.IpAddress -and $note.IpAddress.Trim() -ne "") {
        Test-HostReachability $note.IpAddress $IpAddressBox $window
    }
}

# Helper: Show/hide placeholder text
function Update-Placeholder {
    param($textBox, $placeholderText)
    if ([string]::IsNullOrWhiteSpace($textBox.Text)) {
        $textBox.Text = $placeholderText
        $textBox.Foreground = "#808080"
        $textBox.FontStyle = "Italic"
        $textBox.Tag = @{ IsPlaceholder = $true; PlaceholderText = $placeholderText }
    } else {
        $textBox.Foreground = "#e0e0e0"
        $textBox.FontStyle = "Normal"
        $textBox.Tag = @{ IsPlaceholder = $false; PlaceholderText = $placeholderText }
    }
}

function Setup-PlaceholderBehavior {
    param($textBox, $placeholderText)
    
    Update-Placeholder $textBox $placeholderText
    
    $textBox.Add_GotFocus({
        if ($this.Tag.IsPlaceholder) {
            $this.Text = ""
            $this.Foreground = "#e0e0e0"
            $this.FontStyle = "Normal"
        }
    })
    
    $textBox.Add_LostFocus({
        if ([string]::IsNullOrWhiteSpace($this.Text)) {
            Update-Placeholder $this $this.Tag.PlaceholderText
        } else {
            $this.Tag.IsPlaceholder = $false
        }
    })
}

# Helper: get actual value excluding placeholder
function Get-FieldValue {
    param($textBox)
    if ($null -eq $textBox.Tag -or $textBox.Tag.IsPlaceholder) { return "" }
    return $textBox.Text
}

# Helper: Test host reachability asynchronously and color-code the field
function Test-HostReachability {
    param(
        [string]$target,
        [System.Windows.Controls.TextBox]$textBox,
        [System.Windows.Window]$parentWindow
    )
    
    $windowDispatcher = $parentWindow.Dispatcher
    
    # Create runspace for background ping test
    $runspace = [runspacefactory]::CreateRunspace()
    $runspace.ApartmentState = "STA"
    $runspace.ThreadOptions = "ReuseThread"
    $runspace.Open()
    
    $runspace.SessionStateProxy.SetVariable("target", $target)
    $runspace.SessionStateProxy.SetVariable("textBox", $textBox)
    $runspace.SessionStateProxy.SetVariable("windowDispatcher", $windowDispatcher)
    
    $powershell = [powershell]::Create()
    $powershell.Runspace = $runspace
    
    [void]$powershell.AddScript({
        try {
            # Perform 2 quick pings
            $result = Test-Connection -ComputerName $target -Count 2 -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
            $isReachable = $null -ne $result
        } catch {
            $isReachable = $false
        }
        
        # Prepare color based on result
        if ($isReachable) {
            # Light green with transparency: #4CAF50
            $a = 220; $r = 76; $g = 175; $b = 80
        } else {
            # Light red with transparency: #F44336
            $a = 220; $r = 244; $g = 67; $b = 54
        }
        
        # Update UI via dispatcher
        $windowDispatcher.Invoke([System.Action]{
            $color = [System.Windows.Media.Color]::FromArgb($a, $r, $g, $b)
            $brush = New-Object System.Windows.Media.SolidColorBrush($color)
            $brush.Freeze()
            $textBox.Background = $brush
        })
    })
    
    # Start async execution and cleanup when done
    $asyncResult = $powershell.BeginInvoke()
}

# Helper: Create context menu for editing field value
function Add-FieldContextMenu {
    param($textBox, $fieldName, $enablePing = $false)
    
    # Left-click copies field to clipboard (skip if placeholder)
    $textBox.Add_PreviewMouseLeftButtonDown({
        param($sender, $e)
        if ($this.Text -and $this.Text.Trim() -ne "" -and -not $this.Tag.IsPlaceholder) {
            $script:ignoreNextClipboardChange = $true
            [System.Windows.Clipboard]::SetText($this.Text)
            $e.Handled = $false
        }
    })
    
    # Middle-click (scroll wheel) launches ping if enabled
    if ($enablePing) {
        $textBox.Add_PreviewMouseDown({
            param($sender, $e)
            if ($e.MiddleButton -eq [System.Windows.Input.MouseButtonState]::Pressed) {
                $pingTarget = if ($this.Tag.IsPlaceholder) { "" } else { $this.Text.Trim() }
                if ($pingTarget -ne "") {
                    # Launch CMD window with continuous ping
                    Start-Process cmd.exe -ArgumentList "/k ping -t $pingTarget"
                    $e.Handled = $true
                }
            }
        })
    }
    
    # Right-click opens edit dialog
    $textBox.Add_PreviewMouseRightButtonDown({
        param($sender, $e)
        $e.Handled = $true
        
        # Get actual value (empty if placeholder)
        $currentValue = if ($this.Tag.IsPlaceholder) { "" } else { $this.Text }
        
        $inputDialog = New-Object System.Windows.Window
        $inputDialog.Title = "Edit $fieldName"
        $inputDialog.Width = 400
        $inputDialog.Height = 150
        $inputDialog.WindowStartupLocation = "CenterOwner"
        $inputDialog.Owner = $window
        $inputDialog.Background = "#1e1e1e"
        
        $grid = New-Object System.Windows.Controls.Grid
        $grid.Margin = "15"
        
        $rowDef1 = New-Object System.Windows.Controls.RowDefinition
        $rowDef1.Height = "Auto"
        $rowDef2 = New-Object System.Windows.Controls.RowDefinition
        $rowDef2.Height = "*"
        $rowDef3 = New-Object System.Windows.Controls.RowDefinition
        $rowDef3.Height = "Auto"
        $label = New-Object System.Windows.Controls.Label
        $label.Content = $fieldName
        $label.Margin = "0 0 0 5"
        $label.Foreground = "#e0e0e0"
        [System.Windows.Controls.Grid]::SetRow($label, 0)
        $label = New-Object System.Windows.Controls.Label
        $label.Content = $fieldName
        $label.Margin = "0 0 0 5"
        $label.Foreground = "#e0e0e0"
        [System.Windows.Controls.Grid]::SetRow($label, 0)
        
        $inputBox = New-Object System.Windows.Controls.TextBox
        $inputBox.Text = $currentValue
        $inputBox.Padding = "6"
        $inputBox.Margin = "0 0 0 10"
        $inputBox.Background = "#2d2d2d"
        $inputBox.Foreground = "#e0e0e0"
        $inputBox.BorderBrush = "#3f3f3f"
        [System.Windows.Controls.Grid]::SetRow($inputBox, 1)
        
        $buttonPanel = New-Object System.Windows.Controls.StackPanel
        $buttonPanel.Orientation = "Horizontal"
        $buttonPanel.HorizontalAlignment = "Right"
        [System.Windows.Controls.Grid]::SetRow($buttonPanel, 2)
        
        $okButton = New-Object System.Windows.Controls.Button
        $okButton.Content = "OK"
        $okButton.Padding = "15 5"
        $okButton.Margin = "0 0 5 0"
        $okButton.Background = "#0078d4"
        $okButton.Foreground = "White"
        $okButton.Add_Click({
            $sender.Text = $inputBox.Text
            $sender.Foreground = "#e0e0e0"
            $sender.FontStyle = "Normal"
            $sender.Tag.IsPlaceholder = $false
            $inputDialog.Close()
        }.GetNewClosure())
        
        $cancelButton = New-Object System.Windows.Controls.Button
        $cancelButton.Content = "Cancel"
        $cancelButton.Padding = "15 5"
        $cancelButton.Background = "#6e6e6e"
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
    }.GetNewClosure())
}

# Wire up clickable fields with placeholders
Setup-PlaceholderBehavior $AssetTagBox "Asset Tag"
Setup-PlaceholderBehavior $MachineNameBox "Machine Name"
Setup-PlaceholderBehavior $IpAddressBox "IP Address"
Setup-PlaceholderBehavior $UserNameBox "User Name"
Setup-PlaceholderBehavior $PhoneBox "Phone"
Setup-PlaceholderBehavior $TicketBox "Ticket"

Add-FieldContextMenu $AssetTagBox "Asset Tag"
Add-FieldContextMenu $MachineNameBox "Machine Name" $true
Add-FieldContextMenu $IpAddressBox "IP Address" $true
Add-FieldContextMenu $UserNameBox "User Name"
Add-FieldContextMenu $PhoneBox "Phone"
Add-FieldContextMenu $TicketBox "Ticket"

# Clipboard monitoring for automatic field detection
$script:lastClipboardText = ""
$script:ignoreNextClipboardChange = $false
$script:clipboardMonitor = [System.Windows.Threading.DispatcherTimer]::new()
$script:clipboardMonitor.Interval = [TimeSpan]::FromMilliseconds(500)
$script:clipboardMonitor.Add_Tick({
    try {
        if ([System.Windows.Clipboard]::ContainsText()) {
            $clipboardText = [System.Windows.Clipboard]::GetText()
            
            # Skip if we're ignoring this change (app-initiated clipboard change)
            if ($script:ignoreNextClipboardChange) {
                $script:lastClipboardText = $clipboardText
                $script:ignoreNextClipboardChange = $false
                return
            }
            
            # Only process if clipboard content has changed
            if ($clipboardText -ne $script:lastClipboardText) {
                $script:lastClipboardText = $clipboardText
                
                # Check for ticket patterns: SDW/SDE/QW/QE (case insensitive) followed by 8 digits
                if ($clipboardText -match '(?i)(SDW|SDE|QW|QE)(\d{8})') {
                    $ticketNumber = $matches[0].ToUpper()
                    
                    # Update ticket field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($TicketBox.Text) -or $TicketBox.Tag.IsPlaceholder) {
                        $TicketBox.Text = $ticketNumber
                        $TicketBox.Foreground = "#e0e0e0"
                        $TicketBox.FontStyle = "Normal"
                        $TicketBox.Tag.IsPlaceholder = $false
                    }
                }
                
                # Check for asset tag pattern: HPI (case insensitive) followed by 8 digits
                if ($clipboardText -match '(?i)(HPI)(\d{8})') {
                    $assetTag = $matches[0].ToUpper()
                    
                    # Update asset tag field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($AssetTagBox.Text) -or $AssetTagBox.Tag.IsPlaceholder) {
                        $AssetTagBox.Text = $assetTag
                        $AssetTagBox.Foreground = "#e0e0e0"
                        $AssetTagBox.FontStyle = "Normal"
                        $AssetTagBox.Tag.IsPlaceholder = $false
                    }
                }
                
                # Check for machine name pattern: WL/WD/DD/DL/NL/ND/AL/AD followed by 4 letters and 6 digits, optionally ending in NN
                if ($clipboardText -match '(?i)(WL|WD|DD|DL|NL|ND|AL|AD)([a-zA-Z]{4})(\d{6})(NN)?') {
                    $machineName = $matches[0].ToUpper()
                    
                    # Update machine name field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($MachineNameBox.Text) -or $MachineNameBox.Tag.IsPlaceholder) {
                        $MachineNameBox.Text = $machineName
                        $MachineNameBox.Foreground = "#e0e0e0"
                        $MachineNameBox.FontStyle = "Normal"
                        $MachineNameBox.Tag.IsPlaceholder = $false
                        
                        # Start async ping test
                        Test-HostReachability $machineName $MachineNameBox $window
                    }
                }
                
                # Check for phone number pattern: various formats like (111) 111-1111, 111-111-1111, 111.111.1111
                if ($clipboardText -match '\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}') {
                    $phoneNumber = $matches[0]
                    
                    # Update phone field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($PhoneBox.Text) -or $PhoneBox.Tag.IsPlaceholder) {
                        $PhoneBox.Text = $phoneNumber
                        $PhoneBox.Foreground = "#e0e0e0"
                        $PhoneBox.FontStyle = "Normal"
                        $PhoneBox.Tag.IsPlaceholder = $false
                    }
                }
                
                # Check for username pattern: first.last or first.m.last (where m is single letter middle initial)
                # Exclude common TLDs to avoid matching domains like "google.com" or "navy.mil"
                if ($clipboardText -match '(?i)\b([a-z]{2,})\.([a-z])\.([a-z]{2,})(?!\.)\b') {
                    # Has middle initial
                    $userName = $matches[0].ToLower()
                    
                    # Update username field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($UserNameBox.Text) -or $UserNameBox.Tag.IsPlaceholder) {
                        $UserNameBox.Text = $userName
                        $UserNameBox.Foreground = "#e0e0e0"
                        $UserNameBox.FontStyle = "Normal"
                        $UserNameBox.Tag.IsPlaceholder = $false
                    }
                } elseif ($clipboardText -match '(?i)\b([a-z]{2,})\.([a-z]{2,})(?!\.(?:com|org|net|edu|gov|mil|io|co|uk|us|de|fr|jp|au|ca|in|br|ru|cn|es|it|nl|be|ch|se|no|dk|fi|pl|cz|hu|gr|pt|ie|nz|za|mx|sg|hk|tw|kr|th|my|ph|id|vn|bd|pk|ir|sa|ae|qa|il|tr|eg|ng|ke|gh|tz|ug|et|py|ar|cl|pe|co|ve|ec|bo|gy|sr|fk)\b)') {
                    # No middle initial, and doesn't match common TLDs
                    $userName = $matches[0].ToLower()
                    
                    # Update username field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($UserNameBox.Text) -or $UserNameBox.Tag.IsPlaceholder) {
                        $UserNameBox.Text = $userName
                        $UserNameBox.Foreground = "#e0e0e0"
                        $UserNameBox.FontStyle = "Normal"
                        $UserNameBox.Tag.IsPlaceholder = $false
                    }
                }
                
                # Check for IP address pattern: standard IPv4 format (X.X.X.X)
                if ($clipboardText -match '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b') {
                    $ipAddress = $matches[0]
                    
                    # Update IP address field if it's currently empty or placeholder
                    if ([string]::IsNullOrWhiteSpace($IpAddressBox.Text) -or $IpAddressBox.Tag.IsPlaceholder) {
                        $IpAddressBox.Text = $ipAddress
                        $IpAddressBox.Foreground = "#e0e0e0"
                        $IpAddressBox.FontStyle = "Normal"
                        $IpAddressBox.Tag.IsPlaceholder = $false
                        
                        # Start async ping test
                        Test-HostReachability $ipAddress $IpAddressBox $window
                    }
                }
            }
        }
    } catch {
        # Silently ignore clipboard access errors
    }
})
$script:clipboardMonitor.Start()

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
            ElapsedTime = [TimeSpan]::Zero
            SelectedTemplates = @('NIPR')
        }
    }
    Load-Note $script:currentNoteIndex
})

# Action buttons
$BtnCopy.Add_Click({
    $customer = Get-FieldValue $UserNameBox
    $phone    = Get-FieldValue $PhoneBox
    $asset    = Get-FieldValue $AssetTagBox
    $machine  = Get-FieldValue $MachineNameBox
    $ip       = Get-FieldValue $IpAddressBox
    $ticket   = Get-FieldValue $TicketBox

    $metaLines = @()
    if ($customer) { $metaLines += "Customer: $customer" }
    if ($phone)    { $metaLines += "Phone: $phone" }
    foreach ($key in $script:selectedTemplateKeys) {
        $templateText = $script:templateNotes[$key]
        if ($templateText) {
            foreach ($line in ($templateText -split "`r?`n")) {
                $metaLines += $line
            }
        }
    }
    if ($asset)    { $metaLines += "Asset Tag: $asset" }
    if ($machine)  { $metaLines += "Machine Name: $machine" }
    if ($ip)       { $metaLines += "IP Address: $ip" }
    if ($ticket)   { $metaLines += "Ticket: $ticket" }

    $noteBody = $NotesBox.Text
    $parts = @()
    if ($metaLines.Count -gt 0) { $parts += ($metaLines -join "`n") }
    if ($noteBody -and $noteBody.Trim() -ne "") {
        if ($parts.Count -gt 0) { $parts += "" }
        $parts += $noteBody
    }
    $finalText = $parts -join "`n"
    $script:ignoreNextClipboardChange = $true
    [System.Windows.Clipboard]::SetText($finalText)
})
$BtnChecklist.Add_Click({
    Show-ChecklistMenu -Button $BtnChecklist -Items $script:checklistItems -Order $script:checklistOrder
})
$BtnEscalation.Add_Click({
    Show-EscalationMenu -Button $BtnEscalation -Items $script:escalationItems
})
# Set NIPR button to selected state by default
Set-TemplateButtonState -Button $BtnAddTemplateA -Selected:$true

$BtnAddTemplateA.Add_Click({ Toggle-TemplateSelection -Key 'NIPR' -Button $BtnAddTemplateA })
$BtnAddTemplateB.Add_Click({ Toggle-TemplateSelection -Key 'RA' -Button $BtnAddTemplateB })
$BtnAddTemplateC.Add_Click({ Toggle-TemplateSelection -Key 'RDC' -Button $BtnAddTemplateC })
$BtnAddTemplateD.Add_Click({ Toggle-TemplateSelection -Key 'UNC' -Button $BtnAddTemplateD })

# Safe close on menu exit
$window.FindName('MenuExit').Add_Click({ 
    $script:timerDispatcher.Stop()
    $script:clipboardMonitor.Stop()
    $window.Close() 
})

# Show window
$null = $window.ShowDialog()
