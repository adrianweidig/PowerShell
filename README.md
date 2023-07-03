# PowerShell
Einführungskurs PowerShell Teil 1 und 2

Umlaute in VisualStudio Code PowerShell Dateien:

https://github.com/PowerShell/vscode-powershell/issues/1035#issuecomment-331060804

"Hi,
this is a problem with encoding. Check the enconding of the original file and if you edit and save this file in VS code the encoding is changed to UTF-8

There is a VS code setting which is not always working correctly (guessing the encoding) :
"files.autoGuessEncoding": true

You can also set this setting to save the files with correct encoding:
"files.encoding": "windows1252""

ACHTUNG: Dies funktioniert nur für neue Dateien nach der Änderung