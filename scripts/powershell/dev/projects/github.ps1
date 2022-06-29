$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$github = "github.com"
$lex = "LexBorisovDev"
$second = "LehmanDev"
$urls = @()

$validParams = @(
	@{category = "websiteLinks"; groupDescription = "GitHub URLs";
		names = @(
			@{ name = @("--docs"); short = @("-d"); suburl = "docs" }
			@{ name = @("--main"); short = @("-m"); url = $github }
			@{ name = @("--pulls", "--pull", "--pr"); short = @("-p"); path = "pulls" }
			@{ name = @("--issues", "--issue"); short = @("-i"); path = "issues" }
			@{ name = @("--marketplace", "--market", "--mp"); path = "marketplace" }
			@{ name = @("--explore"); short = @("-e"); path = "explore" }
		)
	}
	@{category = "profileTabs"; groupDescription = "Profiles Tabs";
		names = @(
			@{ name = @("--overview", "--ov"); notab = $true }
			@{ name = @("--repositories", "--repos", "--rs") }
			@{ name = @("--projects", "--proj", "--pj") }
			@{ name = @("--packages", "--pack", "--pk") }
			@{ name = @("--stars", "--star"); short = @("-s") }
			@{ name = @("--people", "--ppl") }
		)
	}
	@{category = "profiles"; groupDescription = "My Profiles";
		names = @(
			@{ name = @($second, "2"); full = $second; params = @("--personal") }
		)
	}
	@{category = "options"; groupDescription = "Miscellaneous";
		names = @(
			@{ name = @("--repo"); short = @("-r") }
			@{ name = @("--orgs"); short = @("-o") }
		)
	}
)

if (Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params
}
else {
	# create boolean variables
	$githubParams = Get-Params $params -validParams $validParams -local
	$params = Get-Params $params -validParams $validParams -query
	$booleanNames = Get-BooleanNames $githubParams $validParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	function composePath {
		param(
			[string]$initialURL = ""
		)

		$pathURLs = @()
		if ($initialURL) {
			if (!$profileTabSet) {
				$pathURLs += $initialURL
			}
			else {
				foreach ($ghp in $githubParams) {
					foreach ($pt in $profileTabs) {
						if ($ghp -in $pt.name -or $ghp -in $pt.short) {
							$url = $initialURL
							if (!$pt.notab) {
								if ($orgs) { $url = $url + "/" + $pt.name[0].split("--")[1] }
								else { $url = $url + "?tab=" + $pt.name[0].split("--")[1] }
							}
							$pathURLs += $url
						}
					}
				}
			}
		}
		return $pathURLs
	}

	# compose URL
	function composeURLs {
		$fullURLs = @()
		
		# profiles
		if ($values) {
			foreach ($value in $values) {
				if ($repo) { $fullURLs += "$github/$lex/$value" }
				elseif ($orgs) { $pathURLs = composePath "$github/orgs/$value" }
				else { $pathURLs = composePath "$github/$value" }

				if ($pathURLs) {
					foreach ($pu in $pathURLs) {
						$fullURLs += $pu
					}
				}
			}
		}

		# website links
		foreach ($ghp in $githubParams) {
			foreach ($wl in $websiteLinks) {
				if ($ghp -in $wl.name -or $ghp -in $wl.short) {
					if ($wl.url) {
						$fullURLs += $wl.url
					}
					else {
						if ($wl.suburl) {
							$url = $wl.suburl + "." + $github
							$fullURLs += $url
						}

						if ($wl.path) {
							$url = $github + "/" + $wl.path
							$fullURLs += $url
						}
					}
				}
			}
		}
	
		return $fullURLs
	}

	# default account
	$profiles = Get-CategoryNames $validParams @("profiles")
	$profileTabs = Get-CategoryNames $validParams @("profileTabs")
	$websiteLinks = Get-CategoryNames $validParams @("websiteLinks")

	$profileTabSet = $false
	$websiteLinkSet = $false

	foreach ($param in $githubParams) {
		if ($param -in $profileTabs.name -or $param -in $profileTabs.short) {
			if (!$profileTabSet) { $profileTabSet = $true }
		}
		
		if ($param -in $websiteLinks.name -or $param -in $websiteLinks.short) {
			if (!$websiteLinkSet) { $websiteLinkSet = $true }
		}
	}

	$setDefault = (!$values -and !$githubParams) -or (!$values -and $profileTabSet)
	if ($setDefault) { $values += $lex }

	if ($values) {
		$stringValues = @()
		foreach($value in $values) {
			if($value -is [int]) {
				$stringValues += "$value"
			}
			elseif($value -is [string]) {
				$stringValues += $value
			}
		}
		$values = $stringValues

		foreach ($value in $values) {
			foreach ($p in $profiles) {
				if ($value -in $p.name -or $value -in $p.short) {
					$values = $values.replace($value, $p.full)
					if ($p.params -and !$params) { $params += $p.params }
				}
			}
		}
	}

	$urls += composeURLs
	& q $urls $params
}
