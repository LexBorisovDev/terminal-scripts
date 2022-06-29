$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name=@("--help"); short=@("-h") }
)

$validParams = @(
	@{ name = @("--open", "--code"); short = @("-o", "-c") }
	@{ name = @("--notepad", "--note", "--np"); short = @("-n") }
)

if(Ask-Help $params -helpParams @helpParams) {
$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $dirs -params $params -noheader
}
else {
	# create boolean variables
	$booleanNames = Get-BooleanNames $params $validParams @helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	$initial = "$env:ProgramFiles\PowerShell\7\Modules\MyModules"
	$currentDir = Get-Location
	Navigate -directories $dirs -params $params -initial $initial

	if ($open -or $notepad) {
		$items = Get-ChildItem -Name
		if ($items) {
			foreach ($item in $items) {
				if ($item -match ".+\.psm1") {
					if ($open) {
						& code $item
					}
					
					if ($notepad) {
						& notepad $item
					}
				}
			}
		}
		Set-Location $currentDir
	}
}
