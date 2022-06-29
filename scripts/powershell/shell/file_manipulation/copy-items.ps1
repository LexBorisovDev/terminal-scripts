$items = Get-Params $MyInvocation.UnboundArguments -values
$params = Get-Params $MyInvocation.UnboundArguments

$count = $items.count

if($count -lt 2) {
	write-host "invalid number of parameters" -ForegroundColor Red
}
else {
	$copyTo = $items[$count - 1]
	
	for($i = 0; $i -lt $count - 1; $i++) {
		$item = $items[$i]
		if($params) {
			Copy-Item $params -Path $item -Destination $copyTo
		}
		else {
			Copy-Item -Path $item -Destination $copyTo
		}
	}
}
