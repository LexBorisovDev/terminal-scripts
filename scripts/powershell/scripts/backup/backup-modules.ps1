$script:modulesOriginal = "$env:ProgramFiles\PowerShell\7\Modules\MyModules"
$script:modulesBackup = "$env:PowershellScriptsDirectory\scripts\modules-backup"

# backup to dev
Remove-Item -Recurse -Path "$modulesBackup\*"
Copy-Item -Recurse -Path "$modulesOriginal\*" -Destination "$modulesBackup"
