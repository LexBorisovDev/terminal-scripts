function Check-ValidParam {
	param(
		$set = @(),
		[string]$param = ""
	)
	
	$valid = $true
	if($set -and $params) {
		$validSet = @()
		
		foreach($param in $set) {
			if($param.category) {
				$validSet += $param.names
			}
			elseif($param.name -or $param.short) {
				$validSet += $param
			}
		}
		
		if($validSet) {
			$valid = $param -in $validSet.name -or $param -in $validSet.short
		}
	}
	return $valid
}