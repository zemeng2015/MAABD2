Option Explicit

Dim shell, fso, scriptDir, ps1, command, i, code, key

Set shell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
ps1 = fso.BuildPath(scriptDir, "bd2_powder_counter.ps1")

command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File " & Chr(34) & ps1 & Chr(34)

For i = 0 To WScript.Arguments.Count - 1
    command = command & " " & Chr(34) & WScript.Arguments(i) & Chr(34)
Next

For Each key In WScript.Arguments.Named
    command = command & " " & Chr(34) & "-" & key & Chr(34)
    command = command & " " & Chr(34) & WScript.Arguments.Named(key) & Chr(34)
Next

code = shell.Run(command, 0, True)
WScript.Quit code
