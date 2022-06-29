$params = Get-Params $MyInvocation.UnboundArguments
$items = Get-Params $MyInvocation.UnboundArguments -values

$count = $items.count

if($count -lt 2) {
	write-host "invalid number of parameters" -ForegroundColor Red
}
else {
	$moveTo = $items[$count - 1]
	
	for($i = 0; $i -lt $count - 1; $i++) {
		$item = $items[$i]
		if($params) {
			Move-Item $params -Path $item -Destination $moveTo
		}
		else {
			Move-Item -Path $item -Destination $moveTo
		}
	}
}
