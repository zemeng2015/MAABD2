Option Explicit

Dim shell, fso, scriptDir, ps1, command, i

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = fso.BuildPath(scriptDir, "bd2_input.ps1")

command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File " & Chr(34) & ps1 & Chr(34)

For i = 0 To WScript.Arguments.Count - 1
    command = command & " " & Chr(34) & WScript.Arguments(i) & Chr(34)
Next

shell.Run command, 0, True
