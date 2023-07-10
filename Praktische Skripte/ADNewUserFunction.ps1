function New-OwnADUser {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Vorname,
        
        [Parameter(Mandatory=$true)]
        [string]$Nachname,
        
        [Parameter(Mandatory=$true)]
        [ValidateSet("S1", "S2", "S3", "S4", "S5", "S6", "Unbekannt")]
        [string]$Abteilung,
        
        [Parameter(Mandatory=$false)]
        [string]$Passwort,
        
        [Parameter(Mandatory=$false)]
        [string]$Ort
    )

    Write-Verbose "Erstelle neuen Benutzer '$Vorname $Nachname' in Active Directory."

    try {
        $SamAccountName = "$Vorname.$Nachname".ToLower()
        $Name = "$Vorname $Nachname"
        $GivenName = $Vorname
        $Surname = $Nachname
        $Domain = "spielwiese.intern"
        $EmailAddress = "$($SamAccountName)@$($Domain)"
        $UserPrincipalName = "$($SamAccountName)@$($Domain)"
        $Path = "OU=standardbenutzer,OU=benutzer,OU=spielwiese,DC=spielwiese,DC=intern"
        $Enabled = $true
        $StandardPasswort = "P@ssw0rd"
        $Ort = $Ort.Substring(0,1).ToUpper() + $Ort.Substring(1).ToLower()

        Write-Verbose "SamAccountName: $SamAccountName"
        Write-Verbose "Name: $Name"
        Write-Verbose "GivenName: $GivenName"
        Write-Verbose "Surname: $Surname"
        Write-Verbose "EmailAddress: $EmailAddress"
        Write-Verbose "Path: $Path"
        Write-Verbose "Enabled: $Enabled"
        Write-Verbose "Abteilung: $Abteilung"

        $UserParams = @{
            SamAccountName = $SamAccountName
            Name = $Name
            GivenName = $GivenName
            Surname = $Surname
            EmailAddress = $EmailAddress
            UserPrincipalName = $UserPrincipalName
            Path = $Path
            Enabled = $Enabled
            Department = $Abteilung
        }

        if ($Passwort) {
            $UserParams.AccountPassword = ConvertTo-SecureString -String $Passwort -AsPlainText -Force
            $UserParams.ChangePasswordAtLogon = $false
            $UserParams.PasswordNeverExpires = $true
        }
        else {
            $UserParams.AccountPassword = ConvertTo-SecureString -String $StandardPasswort -AsPlainText -Force
            $UserParams.ChangePasswordAtLogon = $true
            $UserParams.PasswordNeverExpires = $false
        }
        
        if ($Ort) {
            $jsonPath = "C:\temp\ort.json"
            $jsonContent = Get-Content -Path $jsonPath -Raw | ConvertFrom-Json
            $foundEntry = $jsonContent | Where-Object { $_.ort -eq $Ort }
            
            if ($foundEntry) {
                $UserParams.City = $foundEntry.ort
                $UserParams.PostalCode = $foundEntry.plz
                # Beachte, dass hier nur Ländercodes wie DE erlaubt sind
                $UserParams.Country = $foundEntry.land
                $UserParams.State = $foundEntry.bundesland
            } else {
                Write-Warning "Der Ort '$Ort' wurde nicht in der JSON-Datei gefunden."
            }
        }

        New-ADUser @UserParams
        
        Write-Verbose "Der Benutzer $Vorname $Nachname wurde erfolgreich erstellt."
    }
    catch {
        Write-Verbose "Fehler beim Erstellen des Benutzers '$Vorname $Nachname': $_"
    }
}

# Beispielaufruf der Funktion mit Passwort und Ort
New-OwnADUser -Vorname "Max" -Nachname "Mustermann" -Abteilung "S1" -Passwort "P@ssw0rd123" -Ort "Berlin" -Verbose

# Beispielaufruf der Funktion ohne Passwort und Ort
#New-OwnADUser -Vorname "Max" -Nachname "Mustermann" -Abteilung "S1" -Verbose
