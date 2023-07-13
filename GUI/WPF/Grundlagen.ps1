[xml]$XAML = @"
<Window x:Class="WpfApplication.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="MainWindow" Height="300" Width="400">
    <Grid>
        <Button x:Name="MeinButton" Content="Klick mich!" HorizontalAlignment="Center" VerticalAlignment="Center"/>
        <Label x:Name="MeinLabel" Content="Hallo, Welt!" HorizontalAlignment="Center" VerticalAlignment="Top" Margin="0,50,0,0"/>
    </Grid>
</Window>
"@ -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window' #-replace wird benötigt, wenn XAML aus Visual Studio kopiert wird.

##############################################
# Abschnitt 1: Einführung in WPF
##############################################

Write-Output "`n### Abschnitt 1: Einführung in WPF ###`n"

# Erst hiermit ist WPF wie beim Import eines Moduls aufrufbar
Add-Type -AssemblyName PresentationFramework

# XAML-Daten aus Datei laden (Auskommentieren, falls InCode Variante (siehe oben) genutzt werden will)
$XAML = [xml](Get-Content "E:\Programmierung\PowerShell\GUI\WPF\XAMLGrundlagen.xaml")

# XAML-Daten laden
$window=[Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $XAML) )

# Fenster anzeigen
$result = $window.ShowDialog()

##############################################
# Abschnitt 2: Hinzufügen von Steuerelementen
##############################################

Write-Output "`n### Abschnitt 2: Hinzufügen von Steuerelementen ###`n"

# XAML-Datei laden
$window=[Windows.Markup.XamlReader]::Load( (New-Object System.Xml.XmlNodeReader $XAML) )

# Steuerelemente suchen
$button = $window.FindName("MeinButton")
$label = $window.FindName("MeinLabel")

# Ereignisbehandlung für den Button hinzufügen
$button.Add_Click({
    $label.Content = "Button wurde geklickt!"
})

# Fenster anzeigen
$result = $window.ShowDialog()
