$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$w3schoolsURL = "www.w3schools.com"
$url = ""

if($values) {
	foreach($value in $values) {
		$url = $w3schoolsURL + $value
		& q $url $params
	}
}
else {
	& q $w3schoolsURL $params
}
