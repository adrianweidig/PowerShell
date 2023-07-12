# Version 1.50 vom 20. Januar 2022

# Start:
# Hinweis: bei allen Schritten soll eine Beginn und Endemeldung erfolgen, damit der Nutzer
#          des Scriptes bei Bedarf ausfuehrlich ueber den jeweiligen Abarbeitungsstand informiert ist
# Ausgabe: domainname, aktueller domaincontroller, forestmode, domainmode, pdc-emulator, ridmaster
# eine neue OU unter der Root anlegen: "bundeswehr"
# unterhalb dieser OU ("bundeswehr") neue OU's anlegen: 
#    "technik","vertrieb","verwaltung","it","vorstand","forschung","marketing","kantine","fertigung","werkstatt"
# innerhalb jeder OU 500 neue user anlegen mit dem stamm "u-", OU-Name und fortlaufende Nummer "u-<ou>-<nummer>" (vierstellig)
# (zum testen mit weniger usern arbeiten)
# innerhalb jeder OU 30 neue Admins anlegen mit dem stamm "a-", ou-name und fortlaufende nummer "a-<ou>-<nummer>" (zweistellig)
# alle orte der neuen User auf "Dresden" setzen
# Startpasswort fuer alle user auf "#Beginn678" setzen
# startpasswort fuer alle admins auf "#supergeheim0815" setzen
# fuer alle Benutzer und Admins ist zu setzen, dass das Password bei der ersten Anmeldung
#      geaendert werden muss
# UPN (User Principal Name) pruefen und ggf. setzen auf "<username>@<domainname>"
# alle neu erzeugten accounts enablen
# alle telefonnummern auf "0351-33333/0" setzen
# fuer alle Benutzer ist die Beschaeftigten-ID ist auf "0815xxxx" zu setzen, wobei "xxxx" die vierstellige ID des Benutzernamens ist
# fuer alle Admins ist die Beschaeftigten-ID ist auf "9999xxxx" zu setzen, wobei "xxxx" die vierstellige ID des Benutzernamens ist
# fuer alle Benutzer die strasse auf "August-Bebel-Strasse "setzen
# fuer alle User ist das Land auf "Deutschland" zu setzen
# alle abteilungen auf Name der OU setzen setzen
# alle email setzen auf "<username>@<domainname>"
# in jeder ou neue Sicherheits-Gruppen (global) anlegen:
  # "g_<name ou>"
  # "g_<name ou>_admins"
  # "g_<name ou>_software"
  # "g_<name ou>_test01"
  # "g_<name ou>_test17"
# alle neuen user der ou werden mitglied der gruppe "g_<name ou>"
# alle neuen admins der ou werden mitglied der gruppe "g_<name ou>_admins"
# alle neuen admins der ou werden mitglied der gruppe "Domaenen-Admins"

# Ende:
# OU "bundeswehr" incl. aller Unterobjekte mit grafischer Rueckfrage komplett loeschen
# grafische Abfrage soll aber mit switch-parameter abschaltbar sein
# im Standard ist die grafischer Rueckfrage aber angeschaltet
# Implementierung als Funktion mit Fehlerbehandlung


<#
Zerlegung der Aufgabe in Teilschritte:

1. Lege eine neue OU unter der AD-Root an mit den Namen "bundeswehr"
2. Lege folgende OU unterhalb "bundeswehr" als Root an: "technik","vertrieb","verwaltung","it","vorstand","forschung","marketing","kantine","fertigung","werkstatt"
3. Innerhalb jeder neu angelegten OU 5 neue user mit den Namen "u-<OU NAME>-<Nummer (Vierstellig)>" zähle dabei von 1 beginnend die Nummer hoch (also ab 0001)
4. Innerhalb jeder neu angelegten OU 5 neue administratoren mit dem Namen "a-<OU NAME>-<Nummer (Vierstellig)>" zähle dabei von 1 beginnend die Nummer hoch (also ab 0001)
5. Jeder Nutzer soll im Ort "Dresden" leben
6. Jeder Nutzer soll bei der ersten Anmeldung seinen 
7. Jeder Nutzer soll den UPN (User Principal Name) <nutzername>@<domainname> haben
8. Jeder Nutzer soll einen "enable"ten Account haben
9. Jeder Nutzer soll die Telefonnummer: "0351-33333/0"  haben
10. Jeder USER soll die Beschäftigten-ID "0851XXXX" besitzen, wobei XXXX mit der Nummer des Nutzers (siehe Punkt 3 beginnend ab 0001) ersetzt werden soll
11. Jeder ADMINISTRATOR soll die Beschäftigten-ID "9999XXXX" besitzen, wobei XXXX mit der Nummer des Nutzers (siehe Punkt 4 beginnend ab 0001) ersetzt werden soll
12. Jeder Nutzer soll die Straße auf "August-Bebel-Strasse" gesetzt haben
13. Jeder Nutzer soll das Land auf "DE" gesetzt haben
14. Jeder Nutzer soll als Abteilung den Namen der OU haben
15. Jeder Nutzer soll den UPN ebenfalls als E-Mail Adresse besitzen
16. In Jeder OU sollen folgende Sicherheitsgruppen (global) hinzugefügt werden:
  "g_<name ou>"
  "g_<name ou>_admins"
  "g_<name ou>_software"
  "g_<name ou>_test01"
  "g_<name ou>_test17"
17. Jeder USER soll Mitglied der Sicherheitsgruppe "g_<name_ou>" sein
18. Jeder ADMINISTRATOR soll Mitglied der Sicherheitsgruppe "g_<name_ou>_admins" sein
19. Jeder ADMINISTRATOR soll Mitglied der Gruppe "Domänen-Admins" sein




#>

$domainname = "spielwiese.intern"
$ADRoot = "DC=spielwiese,DC=intern"
$bwPath = "OU=bundeswehr,$ADRoot"

# OU Bundeswehr löschen falls vorhanden

# Überprüfen, ob die OU vorhanden ist
$ou = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$bwPath'"

if ($ou) {
    # Benutzer um Bestätigung bitten
    $confirmation = Read-Host "Die OU '$bwPath' und alle darunterliegenden OUs werden gelöscht. Möchten Sie fortfahren? (J/N)"

    if ($confirmation.ToLower() -eq "j") {
        # OU und alle darunterliegenden OUs und Objekte löschen
        Remove-ADOrganizationalUnit -Identity $bwPath -Recursive
        Write-Host "Die OU '$bwPath' und alle darunterliegenden OUs wurden erfolgreich gelöscht."
    } else {
        Write-Host "Die Löschung der OU '$bwPath' wurde abgebrochen."
    }
} else {
    Write-Host "Die OU '$bwPath' existiert nicht."
}


###
Write-Host "ANFANG - Neue OU "bundeswehr" unter AD-Root anlegen"

New-ADOrganizationalUnit -Name "bundeswehr" -Path $ADRoot -ProtectedFromAccidentalDeletion $false

Write-Host "ENDE - Neue OU "bundeswehr" unter AD-Root anlegen"

Write-Host "ANFANG - Neue OUs unter "bundeswehr" anlegen"

$ous = @("technik","vertrieb","verwaltung","it","vorstand","forschung","marketing","kantine","fertigung","werkstatt")
foreach ($ou in $ous) {
    New-ADOrganizationalUnit -Name $ou -Path $bwPath -ProtectedFromAccidentalDeletion $false
}

Write-Host "ENDE - Neue OUs unter "bundeswehr" anlegen"

Write-Host "ANFANG - Neue Benutzer und Administratoren in den OUs anlegen"

$ous | ForEach-Object {
    $ou = $_
    $ouPath = "OU=$ou,$bwPath"

    # Benutzer erstellen
    foreach ($index in 1..5) {
        $userNumber = $index.ToString("0000")
        $userName = "u-$ou-$userNumber"
        $userProperties = @{
            Name = $userName
            GivenName = $userName
            Surname = "User"
            SamAccountName = $userName
            UserPrincipalName = "$userName@$domainname"
            Description = "User in OU $ou"
            Enabled = $true
            ChangePasswordAtLogon = $true
            StreetAddress = "August-Bebel-Strasse"
            City = "Dresden"
            Country = "DE"
            OfficePhone = "0351-33333/0"
            EmployeeID = "0851$userNumber"
            Department = $ou
            EmailAddress = "$userName@$domainname"
            AccountPassword = ConvertTo-SecureString -String "#Beginn678" -AsPlainText -Force
        }
        New-ADUser @userProperties -Path $ouPath
    }

    # Administratoren erstellen
    foreach ($index in 1..5) {
        $adminNumber = $index.ToString("0000")
        $adminName = "a-$ou-$adminNumber"
        $adminProperties = @{
            Name = $adminName
            GivenName = $adminName
            Surname = "Admin"
            SamAccountName = $adminName
            UserPrincipalName = "$adminName@$domainname"
            Description = "Administrator in OU $ou"
            Enabled = $true
            ChangePasswordAtLogon = $true
            StreetAddress = "August-Bebel-Strasse"
            City = "Dresden"
            Country = "DE"
            OfficePhone = "0351-33333/0"
            EmployeeID = "9999$adminNumber"
            Department = $ou
            EmailAddress = "$adminName@$domainname"
            AccountPassword = ConvertTo-SecureString -String "#supergeheim0815" -AsPlainText -Force
        }
        New-ADUser @adminProperties -Path $ouPath
    }
}

Write-Host "ENDE - Neue Benutzer und Administratoren in den OUs anlegen"

Write-Host "ANFANG - Sicherheitsgruppen erzeugen"

$ous | ForEach-Object {
    $ou = $_
    $ouPath = "OU=$ou,$bwPath"

    # Sicherheitsgruppen erstellen
        $groupPrefix = "g_$ou"
        New-ADGroup -Name $groupPrefix -GroupScope Global -Path $ouPath -Description "Sicherheitsgruppe in OU $ou"

        $groupNames = @("admins","software","test01","test17")
        $groupNames | ForEach-Object {
            $group = $_
            $groupName = "$groupPrefix"+"_"+"$group"
            New-ADGroup -Name $groupName -GroupScope Global -Path $ouPath -Description "Sicherheitsgruppe in OU $ou"
        }
}

Write-Host "ENDE - Sicherheitsgruppen erzeugen"

Write-Host "ANFANG - Sicherheitsgruppen-Mitglieder hinzufügen"

$ous | ForEach-Object {
    $ou = $_
    $ouPath = "OU=$ou,$bwPath"
    $adminGroupName = "g_$ou"+"_"+"admins"
    $userGroupName = "g_$ou"

    Get-ADUser -SearchBase $ouPath -Filter * | ForEach-Object {
        $user = $_
        Add-ADGroupMember -Identity $userGroupName -Members $user

        if ($user.SamAccountName -like "a-*-*") {
            Add-ADGroupMember -Identity $adminGroupName -Members $user
            Add-ADGroupMember -Identity "Domänen-Admins" -Members $user
        }
    }
}

Write-Host "ENDE - Sicherheitsgruppen-Mitglieder hinzufügen"