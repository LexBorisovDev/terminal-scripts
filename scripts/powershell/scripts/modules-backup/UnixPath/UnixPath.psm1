function Unix-Path {
	param(
		[string]$location = "",
		[switch]$wsl = $false,
		[switch]$gitbash = $false
	)

	$unixPath = ""
	if($location) {
		$slash = "[\\\/]"
	
		for($i = 0; $i -lt $location.length; $i++) {
			$drive = $location[$i] + $location[$i + 1]
			if($location[$i] -match $slash) {
				if(!($location[$i - 1] -match $slash)) {
					$locationString += "/"
				}
			}
			elseif($drive -match "[A-Z]{1}\:") {
				if($wsl -or $gitbash) {
					$locationString += $drive.ToLower()[$i]
				}

				if($wsl) {
					$locationString = "/mnt/$locationString"
				}
				elseif($gitbash) {
					$locationString = "/$locationString"
				}
			}
			else {
				if(!($location[$i] -match "\:")) {
					$locationString += $location[$i]
				}
			}
		}

		$unixPath = $locationString
	}
	return $unixPath
}
