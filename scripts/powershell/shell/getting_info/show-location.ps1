$params = Get-Params $MyInvocation.UnboundArguments

$validParams = @(
	@{ name=@("--windows"); short=@("-w") }
)

if(Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $localParams $validParams
	if($booleanNames) {
		foreach($bn in $booleanNames) {
			if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	$location = Convert-Path .
	if(!$windows) {
		$location = Unix-Path $location
	}
	write-host $location
}
