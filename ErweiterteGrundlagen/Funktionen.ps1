# Vorhandene Parameter können via -"Tab" auch durchge"tab"t werden

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
        # Definiert einen Parameter als "verpflichtend"
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

##############################################
# Abschnitt 5: Weitere Attribute für Parameter
##############################################

Write-Host "`n### Abschnitt 5: Weitere Attribute für Parameter ###`n"

# Mandatory - Legt fest, dass ein Parameter nicht optional ist
Function SayHello {
    param (
        [Parameter(Mandatory=$true)]
        [String]$name
    )

    Write-Host "Hallo, $name! Willkommen zur Funktion SayHello!"
}

# Funktion mit Position-Attribut und Parameterarray definieren
Function Greet {
    param (
        [Parameter(Position=0)]
        [String[]]
        $names
    )

    foreach ($name in $names) {
        Write-Host "Hallo, $name! Willkommen zur Funktion Greet!"
    }
}


# ValueFromPipeline - Legt fest, dass der Parameter Argumente von der Pipeline akzeptiert
Function Process-Name {
    param (
        [Parameter(ValueFromPipeline=$true)]
        [String]$name
    )

    Write-Host "Verarbeite den Namen: $name"
}

# HelpMessage - Bietet die Möglichkeit, eine kurze Hilfe für den Parameter anzugeben
Function Get-Info {
    param (
        [Parameter(HelpMessage="Geben Sie den Computer-Namen ein.")]
        [String]$computerName
    )

    Write-Host "Abrufen von Informationen für den Computer: $computerName"
}

# Alias - Legt einen alternativen Namen für den Parameter fest
Function Get-Info {
    param (
        [Parameter(Mandatory=$true)]
        [Alias("CN")]
        [String]$computerName
    )

    Write-Host "Abrufen von Informationen für den Computer: $computerName"
}

# Weitere Attribute wie AllowNull, AllowEmptyString, AllowEmptyCollection, ValidateCount, ValidateLength, ValidatePattern,
# ValidateRange, ValidateScript, ValidateSet, ValidateNotNull, ValidateNotNullOrEmpty können ebenfalls verwendet werden,
# um die Parametervalidierung und -beschränkungen anzupassen.

# Aufrufen der Funktionen mit den Attributen
SayHello -name "Alice"

Greet -names "Bob", "Charlie", "David"

"Server01", "Server02" | Process-Name

Get-Info -computerName "Server01"

Get-Info -CN "Server01"

Write-Host "Weitere Attribute für Parameter wurden demonstriert."

##############################################
# Abschnitt 6: Verwendung von Write-Verbose
##############################################

Write-Host "`n### Abschnitt 6: Verwendung von Write-Verbose ###`n"

# Funktion mit Write-Verbose definieren
Function Get-InfoVerbose {
    param (
        [Parameter(Mandatory=$true)]
        [String]$computerName
    )

    # Schritt 1: Informationen abrufen
    Write-Verbose "Schritt 1: Informationen für den Computer $computerName abrufen..."
    # Code zum Abrufen der Informationen

    # Schritt 2: Informationen verarbeiten
    Write-Verbose "Schritt 2: Informationen für den Computer $computerName verarbeiten..."
    # Code zur Verarbeitung der Informationen

    # Schritt 3: Informationen anzeigen
    Write-Host "Informationen für den Computer $computerName anzeigen."
    # Code zur Anzeige der Informationen
}

# Funktion aufrufen mit -Verbose-Parameter
Get-InfoVerbose -computerName "Server01" -Verbose

