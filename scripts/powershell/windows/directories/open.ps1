$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{ name = @("--go"); short = @("-g") }
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params #-noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $localParams $validParams $helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}
	
	$initial = Get-Location
	
	if ($dirs) {
		Navigate -directories $dirs $params
		$path = Get-Location
		explorer $path
		if (!$go) {
			Navigate -initial $initial
		}
	}
	else {
		explorer "."
	}
}
