function Get-BooleanNames {
	param(
		$params = @(),
		$validParams = @(),
		$helpParams = @()
	)

	if(!$helpParams) { $helpParams = Help-Params }
	
	$booleanNames = @()
	if($params -and $validParams) {
		
		function getBooleanName {
			param(
				[string]$param = "",
				$vp
			)
			
			$bn = ""
			if($param -and $vp) {
				if($vp.name) {
					if($param -in $vp.name -or $param -in $vp.short) {
						$bn = $vp.name[0]
						if($bn -match "^--.+") {
							$bn = $bn.split("--")[1]
						}
						elseif($bn -match "^-.+") {
							$bn = $bn.split("-")[1]
						}
					}
				}
			}
			return $bn
		}
		
		foreach($param in $params) {
			foreach($vp in $validParams) {
				if($vp.category) {
					foreach($name in $vp.names) {
						$bn = getBooleanName $param $name
						if($bn) {
							# add category to boolean names
							if(!($vp.category -in $booleanNames)) {
								$booleanNames += $vp.category
							}
							
							# add param itself to boolean names
							if(!($bn -in $booleanNames)) {
								$booleanNames += $bn
							}

						}
					}
				}
				else {
					$bn = getBooleanName $param $vp
					if($bn -and !($bn -in $booleanNames)) {
						$booleanNames += $bn
					}
				}
			}
			
			if($helpParams) {
				foreach($vp in $helpParams) {
				if($vp.category) {
					foreach($name in $vp.names) {
						$bn = getBooleanName $param $name
						if($bn) {
							# add category to boolean names
							if(!($vp.category -in $booleanNames)) {
								$booleanNames += $vp.category
							}
							
							# add param itself to boolean names
							if(!($bn -in $booleanNames)) {
								$booleanNames += $bn
							}

						}
					}
				}
				else {
					$bn = getBooleanName $param $vp
					if($bn -and !($bn -in $booleanNames)) {
						$booleanNames += $bn
					}
				}
			}
			}
		}
	}	
	
	return $booleanNames
}
