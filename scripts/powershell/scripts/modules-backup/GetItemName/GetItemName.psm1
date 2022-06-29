function Get-ItemName {
	param(
		[string]$item = ""
	)

	$itemName = $item
	if($item) {
		$pattern = "^(\.\\|\.\/|\\|\/)([\.\w\d\-_ ]+)"
		if("$item" -match $pattern) {
			$itemName = $matches[2]
		}
	}

	return $itemName
}	
