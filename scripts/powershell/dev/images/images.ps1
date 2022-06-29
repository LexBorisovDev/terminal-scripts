$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$defaultURL = "images.google.com/"
$validParams = @(
	@{ name=@("--squoosh"); short=@("-s"); url="squoosh.app/" }
	@{ name=@("--reduce"); short=@("-r"); url="www.reduceimages.com/" }
	@{ name=@("--tiny"); short=@("-t"); url="tinypng.com/" }
	@{ name=@("--google"); short=@("-g"); url=$defaultURL }
)

$booleanNames = Get-BooleanNames $params $validParams
if($booleanNames) {
	foreach($bn in $booleanNames) {
		if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
			New-Variable -Name $bn -Value $true
		}
	}
}

if(Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
elseif($values) {
	& q  $values $params
} 
else {
	$urls = @()
	$localParams = Get-Params $params -validParams $validParams -local
	$params = Get-Params $params -validParams $validParams -query

	foreach($param in $localParams) {
		if($param -in $validParams.name -or $param -in $validParams.short) {
			foreach($vs in $validParams) {
				if($param -in $vs.name -or $param -in $vs.short) {
					$urls += $vs.url
				}
			}
		}
	}

	if($urls) {
		foreach($url in $urls) {
			& q $url $params
		}
	}
	else {
		& q $defaultURL $params
	}
}
