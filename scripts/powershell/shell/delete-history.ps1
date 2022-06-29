$params = Get-Params $MyInvocation.UnboundArguments

$validParams = @(
	@{ name = @("--clear"); short = @("-c") }
	# @{ name = @("--force"); short = @("-f") }
)

if (Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$booleanNames = Get-BooleanNames $params $validParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}
	
	$commandHistoryFile = (Get-PSReadlineOption).HistorySavePath
	
	# delete history
	Clear-Content $commandHistoryFile
	
	if ($clear) { Clear-Host }
	& refresh
	
	# if ($force) {
	# 	# delete history
	# 	Clear-Content $commandHistoryFile
	
	# 	if ($clear) { Clear-Host }
	# 	Invoke-Expression "refresh"
	# }
	# else {
	# 	write-host "delete command history? (YES to proceed) " -ForegroundColor Red -NoNewline
	# 	if (Get-Answer "YES", "Y") {
	# 		write-host "deleting command history..." -ForegroundColor Cyan

	# 		# delete history
	# 		Clear-Content $commandHistoryFile
		
	# 		if ($clear) { Clear-Host }
	# 		Invoke-Expression "refresh"
	# 	}
	# }
}
