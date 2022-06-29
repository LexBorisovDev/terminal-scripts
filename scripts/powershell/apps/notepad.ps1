$files = Get-Params $MyInvocation.UnboundArguments -values
& "$env:ProgramFiles\Notepad++\notepad++.exe" $files
