function Get-CategoryNames {
	param(
		$set =@(),
		[string[]]$categories = @()
	)
	
	$subset = @()
	if($set -and $categories) {
		foreach($obj in $set) {
			foreach($category in $obj.category) {
				if($category -in $categories) {
					$subset += $obj.names
				}
			}
		}
	}
	
	return $subset
}
