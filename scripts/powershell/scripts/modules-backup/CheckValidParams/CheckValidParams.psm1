function Check-ValidParams {
	param(
		$set = @(),
		[string[]]$params = @()
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
			foreach($param in $params) {
				if(!($param -in $validSet.name -or $param -in $validSet.short)) {
					if($valid) { $valid = $false }
					Print-Error "invalid parameter: $param"
				}
			}
		}
	}
	return $valid
}
