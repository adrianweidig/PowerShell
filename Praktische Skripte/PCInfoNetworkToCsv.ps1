param (
    [string]$WorkPath = 'C:\',
    [string]$CsvFileName = 'unternehmensliste.csv',
    [string]$CsvDelimiter = ';',
    [string]$DomainController = 'dc2016.spielwiese.intern'
)

# Array für die gesamte Liste
$gesamtliste = @()

# Alle Computer in der Domäne abrufen
$computers = Invoke-Command { Get-ADComputer -Filter * } -ComputerName $DomainController | Select-Object -ExpandProperty Name

# Informationen von jedem Computer abrufen
foreach ($computer in $computers) {
    # Testen, ob der Computer per WMI erreichbar ist
    $null = Get-WmiObject Win32_BIOS -ComputerName $computer -ErrorAction SilentlyContinue

    # $? prüft ob der vorherige Befehl (Zeile 17) erfolgreich war oder nicht
    if ($? -eq $true) {
        # Name - $computer
        # Hersteller - Get-WmiObject Win32_ComputerSystem - Manufacturer, TotalPhysicalMemory
        $hw = Get-WmiObject Win32_ComputerSystem -ComputerName $computer
        # Betriebssystem - Get-WmiObject Win32_OperatingSystem - Name
        $os = Get-WmiObject Win32_OperatingSystem -ComputerName $computer
        # Anzahl CPUs - Get-WmiObject Win32_Processor - NumberOfCores
        $cpu = Get-WmiObject Win32_Processor -ComputerName $computer
        # Laufwerk C - Get-WmiObject Win32_LogicalDisk - Size, FreeSpace
        $lw_c = Get-WmiObject Win32_LogicalDisk -ComputerName $computer | Where-Object { $_.DeviceID -eq 'C:' }

        $prozent_belegt_lw_c = ($lw_c.Size - $lw_c.FreeSpace) / $lw_c.Size * 100

        # Hashtable für den aktuellen Computer
        $temp = @{
            'ComputerName'        = $computer
            'Hersteller'          = $hw.Manufacturer
            'RAM'                 = ('{0:.} GB' -f ($hw.TotalPhysicalMemory / 1GB))
            'Betriebssystem'      = $os.Caption
            'CPU'                 = $cpu.NumberOfCores
            'LW_Size_C'           = ('{0:.0} GB' -f ($lw_c.Size / 1GB))
            'Prozent_belegt_LW_C' = ('{0:.} %' -f $prozent_belegt_lw_c)
        }

        # Objekt aus Hashtable erstellen
        $zeile = New-Object -TypeName PSObject -Property $temp

        # Das Objekt der gesamten Liste hinzufügen
        $gesamtliste += $zeile
    }
    else {
        Write-Host '!!! Fehler. Rechner' -NoNewline -ForegroundColor White -BackgroundColor Red
        Write-Host $computer -NoNewline -ForegroundColor Red -BackgroundColor White
        Write-Host 'konnte nicht per WMI erreicht werden.' -ForegroundColor White -BackgroundColor Red
        Write-Host ''
    }
}

# Informationen in CSV-Datei exportieren
$gesamtliste |
    Select-Object -Property ComputerName, Hersteller, Betriebssystem, RAM, CPU, LW_Size_C, Prozent_belegt_LW_C |
    Export-Csv -Path (Join-Path -Path $WorkPath -ChildPath $CsvFileName) -Delimiter $CsvDelimiter -NoTypeInformation -Encoding UTF8
