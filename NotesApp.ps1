# Windows 11 Support Notes App - layout skeleton
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# XAML layout: menu, notes body, info strips, action buttons
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Support Notes" Height="750" Width="1100" WindowStartupLocation="CenterScreen"
        Background="#0f172a" Foreground="#e2e8f0" FontFamily="Segoe UI" FontSize="14">
    <Window.Resources>
        <Style TargetType="Label">
            <Setter Property="Foreground" Value="#e2e8f0"/>
            <Setter Property="Margin" Value="0 0 6 0"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="Padding" Value="6"/>
            <Setter Property="Margin" Value="0 0 10 0"/>
            <Setter Property="Background" Value="#1e293b"/>
            <Setter Property="Foreground" Value="#e2e8f0"/>
            <Setter Property="BorderBrush" Value="#334155"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Padding" Value="10 6"/>
            <Setter Property="Margin" Value="6 0 0 0"/>
            <Setter Property="Background" Value="#2563eb"/>
            <Setter Property="Foreground" Value="#e2e8f0"/>
            <Setter Property="BorderBrush" Value="#1e3a8a"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <SolidColorBrush x:Key="Card" Color="#111827"/>
    </Window.Resources>

    <DockPanel LastChildFill="True">
        <Menu DockPanel.Dock="Top" Background="#0b1224" Foreground="#e2e8f0">
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
            <Border Grid.Row="0" Background="{StaticResource Card}" CornerRadius="8" Padding="10" BorderBrush="#1f2937" BorderThickness="1">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>
                    <TextBox x:Name="NotesBox" Grid.Row="0" AcceptsReturn="True" VerticalScrollBarVisibility="Auto" SpellCheck.IsEnabled="True"
                             TextWrapping="Wrap" Background="#0b1224" BorderBrush="#1f2937" BorderThickness="1"/>
                </Grid>
            </Border>

            <!-- Info strip: auto-filled metadata placeholders -->
            <Border Grid.Row="1" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="8" Padding="10" BorderBrush="#1f2937" BorderThickness="1">
                <UniformGrid Columns="6" Rows="1" Margin="0" HorizontalAlignment="Stretch">
                    <StackPanel Orientation="Vertical">
                        <Label Content="Asset Tag"/>
                        <TextBox x:Name="AssetTagBox"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Machine Name"/>
                        <TextBox x:Name="MachineNameBox"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="IP Address"/>
                        <TextBox x:Name="IpAddressBox"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="User Name"/>
                        <TextBox x:Name="UserNameBox"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Phone"/>
                        <TextBox x:Name="PhoneBox"/>
                    </StackPanel>
                    <StackPanel Orientation="Vertical">
                        <Label Content="Ticket"/>
                        <TextBox x:Name="TicketBox"/>
                    </StackPanel>
                </UniformGrid>
            </Border>

            <!-- Quick add buttons placeholder -->
            <Border Grid.Row="2" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="8" Padding="10" BorderBrush="#1f2937" BorderThickness="1">
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                    <Label Content="Quick Add:" Margin="0 0 10 0"/>
                    <Button x:Name="BtnAddTemplateA" Content="Template A"/>
                    <Button x:Name="BtnAddTemplateB" Content="Template B"/>
                    <Button x:Name="BtnAddTemplateC" Content="Template C"/>
                </StackPanel>
            </Border>

            <!-- Clipboard + checklists row -->
            <Border Grid.Row="3" Margin="0 10 0 0" Background="{StaticResource Card}" CornerRadius="8" Padding="10" BorderBrush="#1f2937" BorderThickness="1">
                <StackPanel Orientation="Horizontal" HorizontalAlignment="Left">
                    <Button x:Name="BtnCopy" Content="Copy Notes"/>
                    <Button x:Name="BtnChecklist" Content="Checklist"/>
                    <Button x:Name="BtnEscalation" Content="Escalation"/>
                </StackPanel>
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

# Placeholder event wiring
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
$window.FindName('MenuExit').Add_Click({ $window.Close() })

# Show window
$null = $window.ShowDialog()
