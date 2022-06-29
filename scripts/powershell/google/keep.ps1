$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$keep = "keep.google.com"

$validLabels = @(
	@{ name=@("react"); short=@("r"); label="react" }
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validLabels -values $values -params $params #-noheader
}
else {
	if($values) {
		foreach($label in $values) {
			if($label -in $devLabels.name -or $label -in $devLabels.short) {
				foreach($dl in $devLabels) {
					$url = $keep
					if($label -in $dl.name -or $label -in $dl.short) {
						$url = $url + "/#label/dev-" + $dl.label
						& q $url $param
					}
				}
			}
			elseif($label -in $validLabels.name -or $label -in $validLabels.short) {
				foreach($vl in $validLabels) {
					$url = $keep
					if($label -in $vl.name -or $label -in $vl.short) {
						$url = $url + "/#label/" + $vl.label
						& q $url $params
					}
				}
			}
			else {
				$url = $keep + "/#label/" + $label
				& q $url $params
			}
		}
	}
	else {
		& q $keep $params
	}
}
