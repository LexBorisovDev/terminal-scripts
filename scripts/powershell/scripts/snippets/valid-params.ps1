$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name=@("--help"); short=@("-h") }
)

$validParams = @(
	@{ name=@("--category", "--cat"); short=@("-c") }
)

if(Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $localParams $validParams #$helpParams
	if($booleanNames) {
		foreach($bn in $booleanNames) {
			if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	if($category) {
	'$validParams = @(
		@{category=""; groupDescription="";
			names=@(
				@{ name=@("--"); short=@("-") }
			)
		}
	)' | Set-Clipboard
	}
	else {
	'$validParams = @(
		@{ name=@("--"); short=@("-") }
	)' | Set-Clipboard
	}
}
