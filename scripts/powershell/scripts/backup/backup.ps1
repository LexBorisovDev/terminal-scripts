
write-host ""

<# ==== BACKUP ==== #>
& backup-gitbash
write-host ""
write-host "=================================" -ForegroundColor Magenta

& backup-aliases
& backup-modules

write-host ""
write-host "✅ backed up " -ForegroundColor DarkYellow -NoNewline
write-host "PowerShell" -ForegroundColor Blue -NoNewline
write-host " aliases, modules" -ForegroundColor DarkYellow

<# ==== PUSH TO GITHUB ==== #>
& backup-github
		
write-host "✅ pushed " -ForegroundColor DarkYellow -NoNewline
write-host "PowerShell" -ForegroundColor Blue -NoNewline
write-host " to GitHub" -ForegroundColor DarkYellow
write-host ""
