param(
	[string]$from,
	[string]$to
)

Add-Type -AssemblyName System.web

$params = Get-Params $MyInvocation.UnboundArguments
$query = Get-Params $MyInvocation.UnboundArguments -values

$url = "https://translate.google.com/"

if($query) {
	$query = "?sl=$from&tl=$to&text=$query&op=translate"
	$url = $url + $query
}

& q $url $params
