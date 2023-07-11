function Send-Nachricht {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Nachricht,
        [Parameter(Mandatory=$false)]
        [string]$Titel = "Testnachricht"
    )
    $SmtpServer = "srv12016.spielwiese.intern"
    $Von = "test@spielwiese.intern"
    $Zu = "administrator@spielwiese.intern"
    
    $ErrorActionPreference = "Stop"
    try {
        $EmailProps = @{
            To = $Zu
            From = $Von
            Subject = $Titel
            Body = $Nachricht
            SmtpServer = $SmtpServer
        }
    
        Send-MailMessage @EmailProps
        
        Write-Host "Nachricht erfolgreich gesendet!"
    }
    catch {
        Write-Host "Fehler beim Senden der Nachricht: $($_.Exception.Message)" -ForegroundColor Red
        throw $Error
    }
}
# Beispielaufruf der Funktion
Send-Nachricht -Nachricht "Hallo, dies ist eine Testnachricht!"