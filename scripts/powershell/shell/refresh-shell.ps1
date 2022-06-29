$params = Get-Params $MyInvocation.UnboundArguments

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{ name=@("--clear"); short=@("-c") }
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
	
	if($clear) { Clear-Host }
	
	# restart shell
	& pwsh -nologo

	# $id = $PID
	# Get-Process -Id $id | Select-Object -ExpandProperty Path | ForEach-Object { Invoke-Command { & "$_" } -NoNewScope }
}
