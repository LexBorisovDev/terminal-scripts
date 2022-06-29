$allParams = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$validParams = @(
	@{ name=@("--settings"); short=@("-s"); path="settings" }
	@{ name=@("--label"); short=@("-l"); path="label" }
)

# BOOLEAN VARIABLES
$booleanNames = Get-BooleanNames $params $validParams
if($booleanNames) {
	foreach($bn in $booleanNames) {
		if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
			New-Variable -Name $bn -Value $true
		}
	}
}

$gmail = "mail.google.com/"
$urls = @()
$params = @()
$queryParams = @()

if(Ask-Help $allParams) {
	$params = Get-Params $allParams -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	# local params vs. query params
	if($allParams) {
		foreach($param in $allParams) {
			if($param -in $validParams.name -or $param -in $validParams.short) {
				$params += $param
			}
			else {
				$queryParams += $param
			}
		}
	}

	if(!$params -and !$values) {
		$urls += $gmail
	}
	elseif($params) {
		foreach($param in $params) {
			foreach($vp in $validParams) {
				if($param -in $vp.name -or $param -in $vp.short) {
					$url += $gmail + "#" + $vp.path
					if($values) {
						foreach($value in $values) {
							$url = $url + "/" + $value
						}
					}
					$urls += $url
				}
			}
		}
	}
	elseif($values -and !$params) {
		$url = $gmail + "#"
		foreach($value in $values) {
			$url = $url + $value + "/"
		}
		$urls += $url
	}

	foreach($url in $urls) {
		& q $url $queryParams
	}
}
