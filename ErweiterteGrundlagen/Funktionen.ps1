##############################################
# Abschnitt 1: Einführung in Funktionen
##############################################

Write-Host "`n### Abschnitt 1: Einführung in Funktionen ###`n"

# Funktion definieren
Function SayHello {
    Write-Host "Hallo! Willkommen zur Funktion SayHello!"
}

# Funktion aufrufen
SayHello

##############################################
# Abschnitt 2: Funktionen mit Parametern
##############################################

Write-Host "`n### Abschnitt 2: Funktionen mit Parametern ###`n"

# Funktion mit Parametern definieren
Function Greet {
    param (
        [Parameter(Mandatory=$true)]
        [String]$name
    )

    Write-Host "Hallo, $name! Willkommen zur Funktion Greet!"
}

# Funktion aufrufen und Parameter übergeben
Greet -name "Alice"

##############################################
# Abschnitt 3: Rückgabewerte von Funktionen
##############################################

Write-Host "`n### Abschnitt 3: Rückgabewerte von Funktionen ###`n"

# Funktion mit Rückgabewert definieren
Function AddNumbers {
    param (
        [Parameter(Mandatory=$true)]
        [Int]$num1,
        [Parameter(Mandatory=$true)]
        [Int]$num2
    )

    $sum = $num1 + $num2
    return $sum
}

# Funktion aufrufen und Rückgabewert verwenden
$result = AddNumbers -num1 5 -num2 3
Write-Host "Das Ergebnis der Addition ist: $result"

##############################################
# Abschnitt 4: Funktionen als Parameter übergeben
##############################################

Write-Host "`n### Abschnitt 4: Funktionen als Parameter übergeben ###`n"

# Funktionen als Parameter übergeben
Function ExecuteOperation {
    param (
        [Parameter(Mandatory=$true)]
        [ScriptBlock]$operation,
        [Parameter(Mandatory=$true)]
        [Int]$num1,
        [Parameter(Mandatory=$true)]
        [Int]$num2
    )

    $result = Invoke-Command -ScriptBlock $operation -ArgumentList $num1, $num2
    return $result
}

# Additionsfunktion definieren
$addition = {
    param ($a, $b)
    return $a + $b
}

# Funktion ExecuteOperation aufrufen und Funktion $addition übergeben
$addResult = ExecuteOperation -operation $addition -num1 7 -num2 4
Write-Host "Das Ergebnis der Addition ist: $addResult"
