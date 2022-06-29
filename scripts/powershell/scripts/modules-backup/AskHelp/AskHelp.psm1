function Ask-Help {
	param(
		$params = @(),
		$helpParams = @()
	)
	
	if(!$helpParams) { $helpParams = Help-Params }
	
	$askHelp = $false
	if($params) {
		foreach($param in $params) {
			if($param -in $helpParams.name -or $param -in $helpParams.short) {
				if(!$askHelp) {
					$askHelp = $true
					break
				}
			}
		}
	}
	return $askHelp
}
