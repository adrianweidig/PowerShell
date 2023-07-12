<#
Aufgabe 02: (Version 1.12 vom 19. Januar 2022)

Schreiben Sie ein Script auf dem Windows10-Client, in dem 

Teil A
- auf LW C: ein Ordner "system" in c:\ erzeugt wird
- in Ordner c:\system ein file "logfile.txt" erzeugt wird
- es soll in beiden Fällen vorher geprüft werden, ob das Element bereits existiert

Teil B
- in HKCU:\software ein Ordner "geheim" angelegt wird
- in dem angelegten Ordner HKCU:\Software\geheim" ein neuer Eintrag
  mit Namen "Supergeheim" und dem Wert 4711 angelegt wird

Teil C
- remote auf "dc" der AD-Modul geladen wird
- die Liste aller AD-Computer in das File c:\system\computers.txt exportiert wird
  (das File enthält pro Zeile nur einen Computernamen, sonst keine weiteren
   Informationen.

Teil A und Teil C sollen fehlerueberwacht werden mit eigener Fehlerbehandlung, Teil B 
definitiv nicht.
Im Falle eines auftretenden Fehlers soll der Nutzer mit einer Meldung "Achtung - Systemfehler"
ohne weitere Informationen informiert werden. Bei Fehlern im Teil A soll das Script weiter
fortgeführt werden, bei Fehlern im Teil C soll das Script abgebrochen werden.
Im Mittelteil B sollen die Fehler nur nicht angezeigt werden.

Bauen Sie am Beginn und Ende jedes Blocks die Ausgabe einer Debug-Statusmeldung
mit dem Text "Beginn des Scriptes Teil X" bzw. Ende des Scriptes Teil X" ein!

#>

# Teil A
function TeilA {
    param (
        [Parameter(Mandatory = $false)]
        [string]$SystemOrdner = "C:\system"
    )

    try {
        Write-Debug "Beginn des Scripts Teil A"

        if (-not (Test-Path $SystemOrdner)) {
            New-Item -ItemType Directory -Path $SystemOrdner | Out-Null
            Write-Host "Der Ordner 'system' wurde auf Laufwerk C: erstellt."
        }
        else {
            Write-Host "Der Ordner 'system' existiert bereits auf Laufwerk C:."
        }

        $ProtokollDateiPfad = Join-Path -Path $SystemOrdner -ChildPath "logfile.txt"
        if (-not (Test-Path $ProtokollDateiPfad)) {
            $null | Out-File -FilePath $ProtokollDateiPfad
            Write-Host "Die Datei 'logfile.txt' wurde im Ordner 'system' erstellt."
        }
        else {
            Write-Host "Die Datei 'logfile.txt' existiert bereits im Ordner 'system'."
        }

        Write-Debug "Ende des Scripts Teil A"
    }
    catch {
        Write-Host "Achtung - Systemfehler"
    }
}

# Teil B
function TeilB {
    param (
        [Parameter(Mandatory = $false)]
        [string]$GeheimOrdnerPfad = "HKCU:\Software\geheim",
        [Parameter(Mandatory = $false)]
        [string]$Name = "Supergeheim",
        [Parameter(Mandatory = $false)]
        [int]$Value = 4711
    )

    Write-Debug "Beginn des Scripts Teil B"
    New-Item -Path $GeheimOrdnerPfad -ItemType Directory | Out-Null
    Set-ItemProperty -Path $GeheimOrdnerPfad -Name $Name -Value $Value | Out-Null
    Write-Debug "Ende des Scripts Teil B"

}


# Teil C
function TeilC {
    param (
        [Parameter(Mandatory = $false)]
        [string]$Server = "dc2016",
        [Parameter(Mandatory = $false)]
        [string]$Ordner = "C:\system"
    )

    try {
        Write-Debug "Beginn des Scripts Teil C"

        $Computerdatei = Join-Path -Path $Ordner -ChildPath "computer.txt"

        Invoke-Command -ComputerName $Server -ScriptBlock {
            param($OrdnerPfad)
            param($DateiPfad)

            Import-Module ActiveDirectory

            if (-not (Test-Path $OrdnerPfad)) {
                New-Item -ItemType Directory -Path $OrdnerPfad | Out-Null
                Write-Host "Der Ordner 'system' wurde auf Laufwerk C: auf dem Server '$env:COMPUTERNAME' erstellt."
            }
            else {
                Write-Host "Der Ordner 'system' existiert bereits auf Laufwerk C: auf dem Server '$env:COMPUTERNAME'."
            }

            if (-not (Test-Path $DateiPfad)) {
                $null | Out-File -FilePath $DateiPfad
                Write-Host "Die Datei 'computer.txt' wurde im Ordner 'system' auf dem Server '$env:COMPUTERNAME' erstellt."
            }
            else {
                Write-Host "Die Datei 'computer.txt' existiert bereits im Ordner 'system' auf dem Server '$env:COMPUTERNAME'."
            }

            $ComputerNamen = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
            $ComputerNamen | Out-File -FilePath $DateiPfad
        } -ArgumentList $Ordner,$Computerdatei 

        Write-Debug "Ende des Scripts Teil C"
    }
    catch {
        Write-Host "Achtung - Systemfehler"
    }
}

# Aufruf
TeilA -SystemOrdner "C:\system"
TeilB -GeheimOrdnerPfad "HKCU:\Software\geheim"
TeilC -Server "dc2016" -Ordner "C:\system"
