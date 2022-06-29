# profile
$script:profileDirectory = "$env:ProgramFiles\Git\etc\profile.d"
$script:bashrcFile = "$env:ProgramFiles\Git\etc\bash.bashrc"
$script:profileBackup = "$env:UserProfile\terminal\scripts\git-bash\profile-backup"
Remove-Item -Recurse -Path "$profileBackup\*"
Copy-Item -Recurse -Path "$profileDirectory\*" -Destination "$profileBackup"
Copy-Item -Path $bashrcFile  -Destination "$profileBackup"

write-host "✅ backed up " -ForegroundColor DarkYellow -NoNewline
write-host "Git-Bash" -ForegroundColor Blue -NoNewline
write-host " profile" -ForegroundColor DarkYellow
