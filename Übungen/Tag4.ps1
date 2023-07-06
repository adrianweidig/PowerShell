<#
1. Geben Sie das Ereignisprotokoll „Anwendung“ als „csv“ aus.
#>
Get-EventLog -LogName Application | Export-Csv -Path "Anwendungsprotokoll.csv" -NoTypeInformation

<#
2. Zeigen Sie die Eigenschaften und Methoden der Variable $test ($test = 77).
#>
$test = 77
$test | Get-Member

<#
3. Geben Sie die Namen der laufenden Dienste auf Ihrem Rechner in einer 7-spaltigen Tabelle aus.
#>
Get-Service | Format-Table -Property Name -AutoSize
Get-service | Where-object { $_.status -eq „Running“ } | Format-Wide -column 7

<#
4. Sie möchten herausfinden, ob der Ordner „HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\NetBT\Parameters“ existiert.
#>
Test-Path -Path "HKLM:\SYSTEM\CurrentControlSet\services\NetBT\Parameters"

<#
5. Erstellen Sie den DWORD-Wert 'NodeType' im Ordner „HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NetBT\Parameters“ und weisen sie den Wert 8 zu.
#>
New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters" -Name "NodeType" -Value 0x8 -PropertyType DWORD

<#
6. Stellen Sie sicher, dass jede Minute getestet wird, ob der DNS-Client läuft. Falls nicht, soll er automatisch gestartet werden.
#>
while ($true) {
    if ((Get-Service -Name "Dnscache").Status -ne "Running") {
        Start-Service -Name "Dnscache"
    }
    Start-Sleep -Seconds 60
}

<#
7. Senden Sie eine Mail von xxx@xx.xx“ über „xxx.xxx.xxx“ an xxx@xxx.xxx „. Im Betreff soll der betroffene Computer genannt werden.
#>
Send-MailMessage -From "xxx@xxx.xx" -To "xxx@xx.xx" -Subject "Computer XYZ ist betroffen" -SmtpServer "xxx.xxx.xxx"

<#
8. Get-Eventlog System | Where-Object { $_.EntryType -eq „Warning“ }
Ist dieser Ansatz ökonomisch?

Die Lösung funktioniert einwandfrei, aber ökonomisch ist sie nicht. Where-Object ist eine clientseitige Filterung, welche erst alle Daten beschafft und dann filtert.
#>
Get-EventLog -LogName System | Where-Object { $_.EntryType -eq "Warning" }

<#
9. Warum funktioniert die folgende Zeile nicht?
Get-Process | Ft Name, Company | Sort-Object Company
#>
# Die Zeile funktioniert nicht, da das Format-Table (`Ft`) nicht mit Sort-Object (`Sort-Object`) in einer Pipeline verwendet werden kann. 
# Man kann jedoch das Sortieren und Formatieren in getrennten Schritten durchführen:
Get-Process | Sort-Object -Property Company | Format-Table -Property Name, Company

<#
10. Berechnen Sie den Absolutwert der Zahl -7348.
#>
$number = -7348
$absoluteValue = [Math]::Abs($number)
$absoluteValue

<#
11. Geben Sie die statischen Methoden des Types [datetime] aus.
#>
[datetime] | Get-Member -Static
#>