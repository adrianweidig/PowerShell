# PowerShell (Wird seit 14.07.2023 nicht weiter bearbeitet)
Einführungskurs PowerShell Teil 1 und 2
- Beachten Sie, dass manche PowerShell Funktionen möglicherweise erweiterte Features von Windows Servern etc. benötigt
und auch größere Fehler verursachen kann.

## Umlaute in VisualStudio Code PowerShell Dateien:

https://github.com/PowerShell/vscode-powershell/issues/1035#issuecomment-331060804

>"Hi,
>this is a problem with encoding. Check the enconding of the original file and if you edit and save this file in VS code the encoding is changed to UTF-8
>
>There is a VS code setting which is not always working correctly (guessing the encoding) :
>"files.autoGuessEncoding": true
>
>You can also set this setting to save the files with correct encoding:
>"files.encoding": "windows1252""

ACHTUNG: Dies funktioniert nur für neue Dateien nach der Änderung

## PowerShell zeigt meine Ausgaben in der falschen Reihenfolge an?
https://stackoverflow.com/questions/54344622/why-my-powershell-script-is-not-respecting-the-steps-order

> If you try to test using Write-Output instead of Write-Host I would guess you get it in the correct order, 
> since Write-Output sends an object to the console through the pipeline.

## Praktische Quellen:
- https://powershell.one/powershell-internals/attributes/parameters
- https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.core/?view=powershell-7.3 (ggf. Version auf 5 ändern)
