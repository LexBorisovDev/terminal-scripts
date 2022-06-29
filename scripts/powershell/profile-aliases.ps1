<# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #>
<# ~~~~~~~~~~~~~~ PLEXXIS WORK ~~~~~~~~~~~~~~~ #>
<# ~~~~~~~~~~~~~~ Powershell 7 ~~~~~~~~~~~~~~~ #>
<# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #>
<# C:\Program Files\PowerShell\7\Profile.ps1 #>

$env:PowershellScriptsDirectory = "$env:UserProfile\terminal\scripts\powershell"

<# ************** POSH GIT + PROMPT ************** #>
# Import-Module posh-git
# $color = @{ green = '#16C60C'; blue = "#5470c4" }
# $GitPromptSettings.BranchColor.ForegroundColor = 'Cyan'
# $GitPromptSettings.DefaultPromptPath.ForegroundColor = $color.blue
# $GitPromptSettings.DefaultPromptPath.Text = "`$(Split-Path -leaf -path (Get-PromptPath))"
# $GitPromptSettings.DefaultPromptSuffix.Text = "`$('$' * (`$nestedPromptLevel + 1)) "
# $GitPromptSettings.WindowTitle = ''

function prompt {
	# & $GitPromptScriptBlock
	Write-Host "pwsh:" -ForegroundColor DarkGray -NoNewline
	$currentDir = Split-Path -leaf -path (Get-Location)
	Write-Host $currentDir -NoNewline -ForegroundColor Blue
	Write-Host "$" -NoNewline
	return " "
}

<# ***************** DEV ***************** #>
<# ~~~~ Directories ~~~~ #>
Set-Alias -Name dev -Value "$env:PowershellScriptsDirectory\dev\directories\dev.ps1"
Set-Alias -Name repos -Value "$env:PowershellScriptsDirectory\dev\directories\repos.ps1"
Set-Alias -Name source -Value "$env:PowershellScriptsDirectory\dev\directories\source.ps1"
Set-Alias -Name src -Value source

<# ~~~~ React ~~~~ #>
Set-Alias -Name cra -Value "$env:PowershellScriptsDirectory\dev\react\create-react-app.ps1"

<# ~~~~ Resources ~~~~ #>
Set-Alias -Name webdev -Value "$env:PowershellScriptsDirectory\dev\resources\webdev.ps1"
Set-Alias -Name docs -Value "$env:PowershellScriptsDirectory\dev\resources\docs.ps1"
Set-Alias -Name odin -Value "$env:PowershellScriptsDirectory\dev\resources\odin.ps1"
Set-Alias -Name regex -Value "$env:PowershellScriptsDirectory\dev\resources\regexp.ps1"
Set-Alias -Name postman -Value "$env:PowershellScriptsDirectory\dev\resources\postman.ps1"
Set-Alias -Name whois -Value "$env:PowershellScriptsDirectory\dev\resources\whois.ps1"
Set-Alias -Name linkedin -Value "$env:PowershellScriptsDirectory\dev\resources\linkedin.ps1"

Set-Alias -Name wd -Value webdev
Set-Alias -Name d -Value docs
Set-Alias -Name pm -Value postman
Set-Alias -Name li -Value linkedin


<# ~~~~ Projects ~~~~ #>
Set-Alias -Name github -Value "$env:PowershellScriptsDirectory\dev\projects\github.ps1"
Set-Alias -Name bitbucket -Value "$env:PowershellScriptsDirectory\dev\projects\bitbucket.ps1"
Set-Alias -Name godaddy -Value "$env:PowershellScriptsDirectory\dev\projects\godaddy.ps1"
Set-Alias -Name namecheap -Value "$env:PowershellScriptsDirectory\dev\projects\namecheap.ps1"

Set-Alias -Name gh -Value github
Set-Alias -Name bb -Value bitbucket
Set-Alias -Name gd -Value godaddy
Set-Alias -Name nc -Value namecheap

<# ~~~~ Images ~~~~ #>
Set-Alias -Name canva -Value "$env:PowershellScriptsDirectory\dev\images\canva.ps1"
Set-Alias -Name images -Value "$env:PowershellScriptsDirectory\dev\images\images.ps1"

Set-Alias -Name unsplash -Value "$env:PowershellScriptsDirectory\dev\images\unsplash.ps1"
Set-Alias -Name burst -Value "$env:PowershellScriptsDirectory\dev\images\burst.ps1"
Set-Alias -Name pexels -Value "$env:PowershellScriptsDirectory\dev\images\pexels.ps1"
Set-Alias -Name squoosh -Value "$env:PowershellScriptsDirectory\dev\images\squoosh.ps1"

Set-Alias -Name img -Value images
Set-Alias -Name uns -Value unsplash
Set-Alias -Name pex -Value pexels
Set-Alias -Name sq -Value squoosh


<# ***************** LEARN ***************** #>
<# ~~~~ Code ~~~~ #>
Set-Alias -Name learn-code -Value "$env:PowershellScriptsDirectory\learn\code\learn-code.ps1"
Set-Alias -Name learn-edit -Value "$env:PowershellScriptsDirectory\learn\code\learn-edit.ps1"
Set-Alias -Name fiddle -Value "$env:PowershellScriptsDirectory\learn\code\fiddle.ps1"
Set-Alias -Name codepen -Value "$env:PowershellScriptsDirectory\learn\code\codepen.ps1"
Set-Alias -Name codesandbox -Value "$env:PowershellScriptsDirectory\learn\code\codesandbox.ps1"

Set-Alias -Name fcc -Value "$env:PowershellScriptsDirectory\learn\code\freecodecamp.ps1"
Set-Alias -Name fem -Value "$env:PowershellScriptsDirectory\learn\code\frontendmasters.ps1"
Set-Alias -Name mdn -Value "$env:PowershellScriptsDirectory\learn\code\mdn.ps1"
Set-Alias -Name js -Value "$env:PowershellScriptsDirectory\learn\code\js.ps1"
Set-Alias -Name reintro -Value "$env:PowershellScriptsDirectory\learn\code\reintro.ps1"
Set-Alias -Name css -Value "$env:PowershellScriptsDirectory\learn\code\css.ps1"
Set-Alias -Name w3schools -Value "$env:PowershellScriptsDirectory\learn\code\w3schools.ps1"

Set-Alias -Name lc -Value learn-code
Set-Alias -Name le -Value learn-edit
Set-Alias -Name pen -Value codepen
Set-Alias -Name sandbox -Value codesandbox
Set-Alias -Name m -Value mdn
Set-Alias -Name w3 -Value w3schools

<# ~~~~ Other ~~~~ #>
Set-Alias -Name dictionary -Value "$env:PowershellScriptsDirectory\learn\dictionary.ps1"
Set-Alias -Name w -Value dictionary


<# ***************** APPS ***************** #>
Set-Alias -Name calc -Value calc.exe
Set-Alias -Name notepad -Value "$env:PowershellScriptsDirectory\apps\notepad.ps1"
Set-Alias -Name ccleaner -Value "$env:PowershellScriptsDirectory\apps\ccleaner.ps1"
Set-Alias -Name slack -Value "$env:PowershellScriptsDirectory\apps\slack.ps1"
Set-Alias -Name telegram -Value "$env:PowershellScriptsDirectory\apps\telegram.ps1"
Set-Alias -Name zoom -Value "$env:PowershellScriptsDirectory\apps\zoom.ps1"
Set-Alias -Name todo -Value "$env:PowershellScriptsDirectory\apps\todoist.ps1"

Set-Alias -Name note -Value notepad
Set-Alias -Name npp -Value notepad
Set-Alias -Name np -Value notepad
Set-Alias -Name cclean -Value ccleaner
Set-Alias -Name tg -Value telegram
Set-Alias -Name td -Value todo


<# ***************** GOOGLE ***************** #>
Set-Alias -Name google -Value "$env:PowershellScriptsDirectory\google\google.ps1"
Set-Alias -Name keep -Value "$env:PowershellScriptsDirectory\google\keep.ps1"
Set-Alias -Name gmail -Value "$env:PowershellScriptsDirectory\google\gmail.ps1"
Set-Alias -Name maps -Value "$env:PowershellScriptsDirectory\google\maps.ps1"
Set-Alias -Name youtube -Value "$env:PowershellScriptsDirectory\google\youtube.ps1"

Set-Alias -Name g -Value google
Set-Alias -Name k -Value keep
Set-Alias -Name y -Value youtube
Set-Alias -Name yt -Value youtube

Set-Alias -Name translate -Value "$env:PowershellScriptsDirectory\google\translate.ps1"
Set-Alias -Name en -Value "$env:PowershellScriptsDirectory\google\translate-en.ps1"
Set-Alias -Name tr -Value translate


<# ***************** MICROSOFT ***************** #>
Set-Alias -Name ms -Value "$env:PowershellScriptsDirectory\microsoft\ms.ps1"
Set-Alias -Name word -Value "$env:PowershellScriptsDirectory\microsoft\word.ps1"
Set-Alias -Name excel -Value "$env:PowershellScriptsDirectory\microsoft\excel.ps1"
Set-Alias -Name powerpoint -Value "$env:PowershellScriptsDirectory\microsoft\powerpoint.ps1"
Set-Alias -Name outlook -Value "$env:PowershellScriptsDirectory\microsoft\outlook.ps1"
Set-Alias -Name teams -Value "$env:PowershellScriptsDirectory\microsoft\teams.ps1"
Set-Alias -Name ppt -Value powerpoint


<# ***************** BROWSERS / SEARCH ***************** #>
Set-Alias -Name query -Value "$env:PowershellScriptsDirectory\browsers\query.ps1"
Set-Alias -Name qh -Value "$env:PowershellScriptsDirectory\browsers\query-help.ps1"

Set-Alias -Name browser -Value "$env:PowershellScriptsDirectory\browsers\chrome.ps1"
Set-Alias -Name browse -Value browser
Set-Alias -Name chrome -Value browser
Set-Alias -Name firefox -Value "$env:PowershellScriptsDirectory\browsers\firefox.ps1"
Set-Alias -Name brave -Value "$env:PowershellScriptsDirectory\browsers\brave.ps1"
Set-Alias -Name edge -Value "$env:PowershellScriptsDirectory\browsers\edge.ps1"
Set-Alias -Name opera -Value "$env:PowershellScriptsDirectory\browsers\opera.ps1"
Set-Alias -Name duck -Value "$env:PowershellScriptsDirectory\browsers\duck.ps1"
Set-Alias -Name incognito -Value "$env:PowershellScriptsDirectory\browsers\incognito.ps1"

Set-Alias -Name q -Value query
Set-Alias -Name qc -Value chrome
Set-Alias -Name ff -Value firefox
Set-Alias -Name qf -Value firefox
Set-Alias -Name qb -Value brave
Set-Alias -Name qe -Value edge
Set-Alias -Name qd -Value duck
Set-Alias -Name qo -Value opera
Set-Alias -Name i -Value incognito


<# **************** WINDOWS ***************** #>
<# ~~~ navigation ~~~ #>
Set-Alias -Name go -Value "$env:PowershellScriptsDirectory\windows\directories\go.ps1"
Set-Alias -Name back -Value Go-Back

<# ~~~ directories ~~~ #>
Set-Alias -Name open -Value "$env:PowershellScriptsDirectory\windows\directories\open.ps1"
Set-Alias -Name drive -Value "$env:PowershellScriptsDirectory\windows\directories\drive.ps1"
Set-Alias -Name desktop -Value "$env:PowershellScriptsDirectory\windows\directories\desktop.ps1"
Set-Alias -Name downloads -Value "$env:PowershellScriptsDirectory\windows\directories\downloads.ps1"
Set-Alias -Name user -Value "$env:PowershellScriptsDirectory\windows\directories\user.ps1"
Set-Alias -Name files -Value "$env:PowershellScriptsDirectory\windows\directories\program-files.ps1"
Set-Alias -Name personal -Value "$env:PowershellScriptsDirectory\windows\directories\personal.ps1"
Set-Alias -Name trash -Value "$env:PowershellScriptsDirectory\windows\directories\recycle-bin.ps1"


<# ~~~ settings ~~~ #>
Set-Alias -Name settings -Value "$env:PowershellScriptsDirectory\windows\settings\settings.ps1"
Set-Alias -Name clipboard -Value "$env:PowershellScriptsDirectory\windows\settings\clipboard.ps1"
Set-Alias -Name display -Value "$env:PowershellScriptsDirectory\windows\settings\display.ps1"
Set-Alias -Name bluetooth -Value "$env:PowershellScriptsDirectory\windows\settings\bluetooth.ps1"
Set-Alias -Name control -Value "$env:PowershellScriptsDirectory\windows\settings\control-panel.ps1"
Set-Alias -Name panel -Value control

<# ~~~ shortcuts for above ~~~ #>
Set-Alias -Name gf -Value go
Set-Alias -Name gb -Value back
Set-Alias -Name xz -Value open
Set-Alias -Name dr -Value drive
Set-Alias -Name desk -Value desktop
Set-Alias -Name dt -Value desktop
Set-Alias -Name dl -Value downloads
Set-Alias -Name usr -Value user
Set-Alias -Name pf -Value files
Set-Alias -Name per -Value personal
Set-Alias -Name rb -Value trash
Set-Alias -Name cb -Value clipboard
Set-Alias -Name dsp -Value display
Set-Alias -Name bt -Value bluetooth

<# ~~~ power ~~~ #>
Set-Alias -Name shut -Value "$env:PowershellScriptsDirectory\windows\shutdown\shutdown.ps1"
Set-Alias -Name restart -Value "$env:PowershellScriptsDirectory\windows\shutdown\restart.ps1"
Set-Alias -Name logoff -Value "$env:PowershellScriptsDirectory\windows\shutdown\logoff.ps1"

Set-Alias -Name stfu -Value shut
Set-Alias -Name rs -Value restart
Set-Alias -Name signoff -Value logoff
Set-Alias -Name signout -Value logoff


<# ***************** SCRIPTS ***************** #>
Set-Alias -Name find-alias -Value "$env:PowershellScriptsDirectory\scripts\find-alias.ps1"
Set-Alias -Name fa -Value find-alias

<# ~~~~ Directories ~~~~ #>
Set-Alias -Name terminal -Value "$env:PowershellScriptsDirectory\scripts\directories\terminal.ps1"
Set-Alias -Name scripts -Value "$env:PowershellScriptsDirectory\scripts\directories\scripts.ps1"
Set-Alias -Name ps1 -Value "$env:PowershellScriptsDirectory\scripts\directories\ps1.ps1"
Set-Alias -Name modules -Value "$env:PowershellScriptsDirectory\scripts\directories\modules.ps1"
Set-Alias -Name t -Value terminal

<# ~~~~ Edit ~~~~ #>
Set-Alias -Name edit-aliases -Value "$env:PowershellScriptsDirectory\scripts\edit\edit-aliases.ps1"
Set-Alias -Name edit-scripts -Value "$env:PowershellScriptsDirectory\scripts\edit\edit-scripts.ps1"
Set-Alias -Name edit-query -Value "$env:PowershellScriptsDirectory\scripts\edit\edit-query.ps1"
Set-Alias -Name edit-docs -Value "$env:PowershellScriptsDirectory\scripts\edit\edit-docs.ps1"

Set-Alias -Name ea -Value edit-aliases
Set-Alias -Name es -Value edit-scripts
Set-Alias -Name esq -Value edit-query
Set-Alias -Name esd -Value edit-docs

<# ~~~~ Backup ~~~~ #>
Set-Alias -Name backup-aliases -Value "$env:PowershellScriptsDirectory\scripts\backup\backup-aliases.ps1"
Set-Alias -Name backup-modules -Value "$env:PowershellScriptsDirectory\scripts\backup\backup-modules.ps1"
Set-Alias -Name backup-github -Value "$env:PowershellScriptsDirectory\scripts\backup\backup-github.ps1"
Set-Alias -Name backup-terminal -Value "$env:PowershellScriptsDirectory\scripts\backup\backup.ps1"
Set-Alias -Name bu -Value backup-terminal


<# ************** SHELL ************** #>
Set-Alias -Name admin -Value "$env:PowershellScriptsDirectory\shell\admin.ps1"
Set-Alias -Name psadmin -Value Relaunch-Admin

Set-Alias -Name delete-history -Value "$env:PowershellScriptsDirectory\shell\delete-history.ps1"
Set-Alias -Name pwsh-process -Value "$env:PowershellScriptsDirectory\shell\pwsh-process.ps1"
Set-Alias -Name refresh -Value "$env:PowershellScriptsDirectory\shell\refresh-shell.ps1"
Set-Alias -Name clear-clipboard -Value "$env:PowershellScriptsDirectory\shell\clear-clipboard.ps1"

Set-Alias -Name dh -Value delete-history
Set-Alias -Name psp -Value pwsh-process
Set-Alias -Name rf -Value refresh
Set-Alias -Name ccb -Value clear-clipboard

<# ~~~ getting info ~~~ #>
Set-Alias -Name z -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-items.ps1"
Set-Alias -Name za -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-all.ps1"
Set-Alias -Name zd -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-directories.ps1"
Set-Alias -Name zf -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-files.ps1"
Set-Alias -Name zh -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-hidden.ps1"

Set-Alias -Name l -Value z
Set-Alias -Name ll -Value za
Set-Alias -Name la -Value za
Set-Alias -Name ld -Value zd
Set-Alias -Name lf -Value zf
Set-Alias -Name lh -Value zh

Set-Alias -Name xc -Value "$env:PowershellScriptsDirectory\shell\getting_info\copy-location.ps1"
Set-Alias -Name pwd -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-location.ps1"
Set-Alias -Name x -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-location.ps1"
Set-Alias -Name xw -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-location-windows.ps1"

Set-Alias -Name size -Value "$env:PowershellScriptsDirectory\shell\getting_info\show-size.ps1"
Set-Alias -Name sz -Value size

<# ~~~ file manipulation ~~~ #>
Set-Alias -Name touch -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\touch.ps1"
Set-Alias -Name mkcd -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\mkcd.ps1"
Set-Alias -Name mvx -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\move-items.ps1"
Set-Alias -Name cpx -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\copy-items.ps1"
Set-Alias -Name hide -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\hide.ps1"
Set-Alias -Name unhide -Value "$env:PowershellScriptsDirectory\shell\file_manipulation\unhide.ps1"
Set-Alias -Name zip -Value Zip-File
Set-Alias -Name unzip -Value Unzip-File

<# ~~~ useful aliases ~~~ #>
Set-Alias -Name getp -Value Get-Params
Set-Alias -Name ga -Value Get-Alias
Set-Alias -Name c -Value Clear-Host
Set-Alias -Name bg -Value Get-Job
Set-Alias -Name scb -Value Set-Clipboard

<# ~~~ code snippets ~~~ #>
Set-Alias -Name boilerplate -Value "$env:PowershellScriptsDirectory\scripts\snippets\boiletplte.ps1"
Set-Alias -Name bp -Value boilerplate
Set-Alias -Name bn -Value "$env:PowershellScriptsDirectory\scripts\snippets\boolean-names.ps1"
Set-Alias -Name qp -Value "$env:PowershellScriptsDirectory\scripts\snippets\query-params.ps1"
Set-Alias -Name vp -Value "$env:PowershellScriptsDirectory\scripts\snippets\valid-params.ps1"
Set-Alias -Name hp -Value "$env:PowershellScriptsDirectory\scripts\snippets\help-params.ps1"
Set-Alias -Name ah -Value "$env:PowershellScriptsDirectory\scripts\snippets\ask-help.ps1"
Set-Alias -Name pv -Value "$env:PowershellScriptsDirectory\scripts\snippets\params-values.ps1"
