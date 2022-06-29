$initial = Get-Location
& terminal

# stage
write-host ""
write-host "staging..." -ForegroundColor Green
& git add .

# status
write-host ""
write-host "status:" -ForegroundColor Cyan
& git status

# commit
write-host "committing:" -ForegroundColor Green
& git commit -m "terminal scripts"

# push
write-host ""
write-host "pushing:" -ForegroundColor Green
& git push origin master

# status
write-host ""
write-host "status:" -ForegroundColor Cyan
& git status

Set-Location $initial
write-host ""
