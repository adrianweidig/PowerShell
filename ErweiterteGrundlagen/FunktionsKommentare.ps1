function Testnachricht {
    <#
    .SYNOPSIS
    Zeigt eine Testnachricht an.

    .DESCRIPTION
    Diese Funktion gibt eine Testnachricht aus, um die Funktionalität zu überprüfen.

    .PARAMETER FirstParameter
    Der erste Parameter, falls erforderlich.

    .PARAMETER SecondParameter
    Der zweite Parameter, falls erforderlich.

    .INPUTS
    Es werden keine Eingabeobjekte erwartet.

    .OUTPUTS
    Es werden keine Ausgabeobjekte erzeugt.

    .EXAMPLE
    Beispielaufruf der Funktion:
    Testnachricht -FirstParameter "Wert1" -SecondParameter "Wert2"

    .LINK
    Weitere Informationen finden Sie unter https://dokumentationslink.com

    .NOTES
    Dieses Skript dient nur zu Demonstrationszwecken und hat keine tatsächliche Funktionalität.
    #>
    param (
        [Parameter(Mandatory=$false)]
        [string]$FirstParameter,

        [Parameter(Mandatory=$false)]
        [string]$SecondParameter
    )

    Write-Host "Dies ist eine Testnachricht."
    Write-Host "FirstParameter: $FirstParameter"
    Write-Host "SecondParameter: $SecondParameter"
}

Testnachricht

$scriptInfo = Get-Help Testnachricht

Write-Host "Synopsis: $($scriptInfo.Synopsis)"
Write-Host "Description: $($scriptInfo.Description)"

Write-Host "Parameters:"
foreach ($paramInfo in $scriptInfo.Parameters.Values) {
    Write-Host "- $($paramInfo.Name): $($paramInfo.Description)"
}

if ($scriptInfo.Inputs) {
    Write-Host "Inputs: $($scriptInfo.Inputs.Description)"
}

if ($scriptInfo.Outputs) {
    Write-Host "Outputs: $($scriptInfo.Outputs.Description)"
}

Write-Host "Examples:"
foreach ($exampleInfo in $scriptInfo.Examples) {
    Write-Host "- $($exampleInfo.Text)"
}

Write-Host "Link: $($scriptInfo.Links.Link)"
Write-Host "Notes: $($scriptInfo.Notes)"


Get-Help Testnachricht