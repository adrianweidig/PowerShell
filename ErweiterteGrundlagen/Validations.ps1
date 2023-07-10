# Entsprechende Eingaben ändern, sodass der Fehler ersichtlich ist
# Ermöglicht auch das Tabben durch möglich zulässige Parameter

##############################################
# Abschnitt 1: Einführung und Mandatory-Attribut
##############################################
Write-Host "`n### Abschnitt 1: Einführung und Mandatory-Attribut ###`n"

Function Validate-Mandatory {
    param (
        [Parameter(Mandatory=$true)]
        [String]$name
    )

    Write-Host "Der Name ist: $name"
}

# Funktion Validate-Mandatory aufrufen
Validate-Mandatory -name "Alice"

##############################################
# Abschnitt 2: AllowNull- und AllowEmptyString- Attribut
##############################################
Write-Host "`n### Abschnitt 2: AllowNull- und AllowEmptyString- Attribut ###`n"

Function Validate-AllowNullAndEmptyString {
    param (
        [Parameter(Mandatory=$true)]
        [AllowNull()]
        [AllowEmptyString()]
        [String]$name
    )

    Write-Host "Der Name ist: $name"
}

# Funktion Validate-AllowNullAndEmptyString aufrufen
Validate-AllowNullAndEmptyString -name ""

##############################################
# Abschnitt 3: ValidateCount-Attribut
##############################################
Write-Host "`n### Abschnitt 3: ValidateCount-Attribut ###`n"

Function Validate-Count {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateCount(1, 5)]
        [String[]]
        $names
    )

    foreach ($name in $names) {
        Write-Host "Name: $name"
    }
}

# Funktion Validate-Count aufrufen
Validate-Count -names "Bob", "Charlie", "David"

##############################################
# Abschnitt 4: ValidatePattern-Attribut
##############################################
Write-Host "`n### Abschnitt 4: ValidatePattern-Attribut ###`n"

Function Validate-Pattern {
    param (
        [Parameter(Mandatory=$true)]
        [ValidatePattern("[0-9][0-9][0-9]")]
        [String]$code
    )

    Write-Host "Der Code ist: $code"
}

# Funktion Validate-Pattern aufrufen
Validate-Pattern -code "123"

##############################################
# Abschnitt 5: ValidateNotNullOrEmpty-Attribut
##############################################
Write-Host "`n### Abschnitt 5: ValidateNotNullOrEmpty-Attribut ###`n"

Function Validate-NotNullOrEmpty {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [String]$text
    )

    Write-Host "Der Text ist: $text"
}

# Funktion Validate-NotNullOrEmpty aufrufen
Validate-NotNullOrEmpty -text "Hello"

##############################################
# Abschnitt 6: ValidateRange-Attribut
##############################################
Write-Host "`n### Abschnitt 6: ValidateRange-Attribut ###`n"

Function Validate-Range {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateRange(1, 100)]
        [Int]$age
    )

    Write-Host "Das Alter ist: $age"
}

# Funktion Validate-Range aufrufen
Validate-Range -age 25

##############################################
# Abschnitt 7: ValidateSet-Attribut
##############################################
Write-Host "`n### Abschnitt 7: ValidateSet-Attribut ###`n"

Function Validate-Set {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet("Option1", "Option2", "Option3")]
        [String]$option
    )

    Write-Host "Die Option ist: $option"
}

# Funktion Validate-Set aufrufen
Validate-Set -option "Option2"