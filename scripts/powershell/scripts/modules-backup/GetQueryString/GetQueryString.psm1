function Get-QueryString {
	param(
		[string[]]$queryParams = @(),
		[string]$delimeter = "",
		[switch]$encode = $false
	)
	
	if (!$delimeter) { $delimeter = " " }
	$query = ""

	if ($queryParams) {
		if ($encode) {
			for ($i = 0; $i -lt $queryParams.count; $i++) {
				if ($queryParams.count -eq 1) {
					$word = $queryParams
				}
				elseif ($queryParams.count -gt 1) {
					$word = $queryParams[$i]
				}
	
				if ($idx -lt $queryParams.count) {
					$encodeWord = $false
					$keepGoing = $true
					for ($j = 0; $j -lt $word.length -and $keepGoing; $j++) {
						if (!($word[$j] -match "[A-Za-z0-9]")) {
							$encodeWord = $true
							$keepGoing = $false
						}
					}
	
					if ($encodeWord) {
						$query = $query + [System.Web.HttpUtility]::UrlEncode($word)
					}
					else {
						$query = $query + $word
					}
					
					if ($i -lt $queryParams.count - 1) {
						$query = $query + [uri]::EscapeDataString($delimeter)
					}
				}
			}
		}
		else {
			if($delimeter -ieq " ") { $delimeter = "+" }

			for ($i = 0; $i -lt $queryParams.count; $i++) {
				$query = $query + $queryParams[$i]
				if ($i -lt $queryParams.count - 1) {
					$query += $delimeter
				}
			}
		}
	}

	return $query
}