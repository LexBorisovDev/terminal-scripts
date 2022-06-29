$items = Get-Params $MyInvocation.UnboundArguments -values

if(!$items) {
	write-host "no values provided" -ForegroundColor Red
}
else {
	foreach($item in $items) {
		New-Item .\"$item"
	}
}
