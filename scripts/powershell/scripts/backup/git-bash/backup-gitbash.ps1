# profile
$script:profileDirectory = "$env:ProgramFiles\Git\etc\profile.d"
$script:profileBackup = "$env:UserProfile\terminal\scripts\git-bash\profile-backup"
Remove-Item -Recurse -Path "$onedriveProfile\*"
Copy-Item -Recurse -Path "$profileDirectory\*" -Destination "$profileBackup"

write-host "✅ backed up " -ForegroundColor DarkYellow -NoNewline
write-host "Git-Bash" -ForegroundColor Blue -NoNewline
write-host " profile" -ForegroundColor DarkYellow
