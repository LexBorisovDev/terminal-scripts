# ============================================== #
# ======= CREATE NEW / ADD TO CATEGORIES ======= #
# ============================================== #
$validParams = @(
	@{
		category = @("searchEngine"); groupDescription = "Search Engines";
		names = @(
			@{
				name = @("--google"); short = @("-g");
				url = "www.google.com/";
				search = "search?q="
			}
			@{
				name   = @("--duckduckgo", "--duck", "--ddg")
				url    = "duckduckgo.com/";
				search = "?q="
			}
			@{
				name = @("--youtube", "--yt"); short = @("-y");
				url = "youtube.com/";
				search = "results?search_query="
			}
		)
	}
	@{
		category = @("searchEngine", "searchDev", "searchDocs"); groupDescription = "Dev Resources - Docs";
		names = @(
			@{
				name   = @("--mdn");
				short  = @("-m")
				url    = "developer.mozilla.org/en-US/";
				search = "search?q="
			}
			@{
				name   = @("--css-tricks", "--csstricks", "--css");
				url    = "css-tricks.com/";
				search = "?s="
			}
			@{
				name    = @("--npm");
				short   = @("-n")
				url     = "www.npmjs.com/";
				search  = "search?q=";
				package = "package/";
			}
			@{
				name    = @("--cdn");
				url     = "cdnjs.com/";
				search  = "libraries?q=";
				package = "libraries/"
			}
			@{
				name   = @("--mongodb", "--mongo");
				url    = "docs.mongodb.com/";
				search = "search/?q="
			}
			@{
				name   = @("--mongoose");
				url    = "mongoosejs.com/docs/";
				search = "search.html?q="
			}
			@{
				name    = @("--powershell-gallery", "--pwsh-gallery", "--gallery");
				url     = "www.powershellgallery.com/";
				search  = "packages?q=";
				package = "packages/"
			}
		)
	}
	@{
		category = @("searchEngine", "searchDev", "searchDomains"); groupDescription = "Dev Resources - Domains";
		names = @(
			@{
				name   = @("--whois", "--who");
				url    = "www.whois.com/";
				search = "whois/"
			}
			@{
				name   = @("--namecheap", "--nc");
				url    = "www.namecheap.com/";
				search = "domains/registration/results/?domain="
			}
			@{
				name   = @("--godaddy", "--gd");
				url    = "www.godaddy.com/";
				search = "domainsearch/find?domainToCheck="
			}
		)
	}
	@{
		category = @("searchEngine"); groupDescription = "Images / Img";
		names = @(
			@{
				name	= @("--unsplash");
				short = @("-u");
				url = "unsplash.com/";
				search = "s/photos/"; delimeter = "-"
			}
			@{
				name   = @("--pexels", "--pexel", "--pex");
				url    = "www.pexels.com/";
				search = "search/";
			}
			@{
				name   = @("--burst");
				url    = "burst.shopify.com/";
				search = "photos/search?q="
			}
		)
	}
	@{
		category = @("searchEngine"); groupDescription = "Miscellaneous";
		names = @(
			@{
				name   = @("--investopedia", "--invest", "--ip");
				url    = "www.investopedia.com/";
				search = "search?q="
			}
			@{
				name   = @("--movie", "--tv");
				url    = "gidonline.io/";
				search = "?s="
			}
			@{
				name   = @("--amazon", "--az");
				short  = @("-a")
				url    = "amazon.ca/";
				search = "s?k="
			}
		)
	}
	@{
		category = @("browser"); groupDescription = "Browsers";
		names = @(
			@{ name = @("--chrome"); short = @("-c") }
			@{ name = @("--firefox", "--ff"); short = @("-f")	}
			@{ name = @("--brave"); short = @("-b") }
			@{ name = @("--edge"); short = @("-e") }
			@{ name = @("--opera"); short = @("-o") }
		)
	}
	@{
		category = @("searchOptions"); groupDescription = "Search Options";
		names = @(
			@{ name      = @("--encoded", "--encode");
				description = "show encoded URL string"
			}
			@{ name = @("--package", "--pack") }
			@{ name = @("--secure", "--https"); short = @("-s") }
			@{ name = @("--private", "--inprivate", "--incognito"); short = @("-i") }
			@{ name      = @("--novisit", "--no", "--nv");
				description = "don't visit the provided link(s), just search"
			}
		)
	}
	@{
		category = @("browserOptions"); groupDescription = 'Browser Options';
		names = @(
			@{ name = @("--extensions", "--ext", "--addons"); short = @("-x"); }
			@{ name = @("--webstore", "--ws") }
			@{ name = @("--history"); short = @("-h") }
			@{ name = @("--clearhistory", "--clear-history", "--clear", "--ch") }
		)
	}
)

# ==== OPEN BROWSER(S) ====
function openBrowser {
	param([string]$url)

	# chrome
	if ($chrome) {
		$chromeApp = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
		
		if ($private) {
			& $chromeApp --profile-directory="Default" -incognito $url
		}
		else {
			& $chromeApp --profile-directory="Default" $url
		}
	}
	
	# firefox
	if ($firefox -or $ff) {
		$firefoxApp = "$env:ProgramFiles\Mozilla Firefox\firefox.exe"

		if ($private) {
			& $firefoxApp $url -private
		}
		else {
			& $firefoxApp $url
		}
		
	}
	
	# edge
	if ($edge) {
		$edgeApp = "$env:ProgramFiles\Microsoft\Edge\Application\edge.exe"

		if ($defaultEdge) {
			$acct = 1
			if ($private) {
				& $edgeApp --profile-directory="Profile $acct" -inprivate $url
			}
			else {
				& $edgeApp --profile-directory="Profile $acct" $url
			}
		}

		if ($seneca) {
			$acct = 2
			if ($private) {
				& $edgeApp --profile-directory="Profile $acct" -inprivate $url
			}
			else {
				& $edgeApp --profile-directory="Profile $acct" $url
			}
		}
	}
	
	# brave
	if ($brave) {
		$braveApp = "$env:ProgramFiles\BraveSoftware\Brave-Browser\Application\brave.exe"

		if ($private) {
			& $braveApp -incognito $url
		}
		else {
			& $braveApp $url
		}
	}
	
	# opera
	if ($opera) {
		$operaApp = "$env:UserProfile\AppData\Local\Programs\Opera\launcher.exe"

		if ($private) {
			& $operaApp -private $url
		}
		else {
			& $operaApp $url
		}
	}
}

$values = Get-Params $MyInvocation.UnboundArguments -values
$allParams = Get-Params $MyInvocation.UnboundArguments
$params = @()
foreach ($param in $allParams) {
	$params += $param
}

# ==== HELP ====
if (Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params
}
# ==== DO A SEARCH QUERY ====
else {
	# create boolean variables
	$booleanNames = Get-BooleanNames $params $validParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	# validate parameters
	$valid = $true
	if ($params -and !(Check-ValidParams -set $validParams -params $params)) {
		if ($valid) { $valid = $false }
	}

	if ($valid) {
		$urls = @()

		# default browswer
		if ($chromeProfile) { $chrome = $browser = $true }
		if ($edgeProfile -or $edge) {
			$browser = $true
			if ($edge) { $defaultEdge = $true }
			else { $defaultEdge = $false }
			if ($edgeProfile) { $edge = $true }
		}
		if (!$browser) { $chrome = $true }
		
		# default chrome profile
		if ($chrome -and !$chromeProfile) {
			if ($private -or $movie) { $personal = $true }
			else { $dev = $true }
		}

		# compose URLs
		$queryParams = @()
		if ($values) {
			foreach ($value in $values) {
				if(!([string]::IsNullOrEmpty($value))) {
					$url = @{}
					
					if ($searchDev) { $novisit = $true }
					if ($novisit) { $isWebsite = $false }
					else { $isWebsite = $value -match "\w+\.\w{2,}" -or $value -match "^[A-Za-z]+\:\/{0,3}\w+" }
					
					if ($isWebsite) {
						$url = @{ url = $value; displayed = $value }
						$urls += $url
					}
					else {
						$queryParams += $value
					}
				}
			}
		}

		# deafult URL for searching
		if ($queryParams -and !$searchEngine) {
			$searchEngine = $true
			$params += "--google"
		}
		
		# get URLs for searching
		$searchEngines = Get-CategoryNames $validParams @("searchEngine")
		$searchDevEngines = Get-CategoryNames $validParams @("searchDev")

		if ($searchEngine) {
			foreach ($param in $params) {
				foreach ($engine in $searchEngines) {
					$query = ""
					$url = @{ url = ""; displayed = "" }
					if ($param -in $engine.name -or $param -in $engine.short) {
						$tempUrl = $url.url = $url.displayed = $engine.url

						# compose a search query
						if ($param -in $searchDevEngines.name -or $param -in $searchDevEngines.short) {
							if ($queryParams) {
								if ($package -and $engine.package) {
									$query = $engine.package
								}
								else {
									$query = $engine.search
								}
								
								foreach ($qp in $queryParams) {
									$url = @{}
									$searchUrl = $tempUrl + $query + $qp
									
									$url.url = $url.displayed = $searchUrl
									$urls += $url
								}
							}
							else {
								$urls += $url
							}
						}
						else {
							$queryDelimeter = " "
							if ($engine.delimeter) { $queryDelimeter = $engine.delimeter }

							if ($queryParams) {
								$query = $engine.search
								
								function getUrlQuery {
									$queryString = Get-QueryString $queryParams -delimeter $queryDelimeter -encode
									$queryString = $query + $queryString
									return $queryString
								}

								if ($encoded) {
									$url.url += getUrlQuery
									$url.displayed = $url.url					
								}
								else {
									$url.displayed = $url.url + $query + (Get-QueryString $queryParams -delimeter $queryDelimeter)
									$url.url += getUrlQuery
								}
							}
							$urls += $url
						}
					}
				}
			}
		}

		if ($browserOptions) {
			if ($webstore) {
				if ($chrome -or $brave) {
					$webstoreURL = "chrome.google.com/webstore/category/extensions"
					$url = @{ url = $webstoreURL; displayed = $webstoreURL }
					$urls += $url
				}
				if ($firefox) {
					$webstoreURL = "addons.mozilla.org/"
					$url = @{ url = $webstoreURL; displayed = $webstoreURL }
					$urls += $url
				}
				if ($edge) {
					$webstoreURL = "microsoftedge.microsoft.com/addons/"
					$url = @{ url = $webstoreURL; displayed = $webstoreURL }
					$urls += $url
				}
				if ($opera) {
					$webstoreURL = "addons.opera.com/en/extensions/"
					$url = @{ url = $webstoreURL; displayed = $webstoreURL }
					$urls += $url
				}
			}

			if ($extensions) {
				if ($chrome) {
					"chrome://extensions" | Set-Clipboard
				}
				if ($brave) {
					"brave://extensions" | Set-Clipboard
				}
				if ($firefox) {
					$urls += "about:addons"
				}
				if ($edge) {
					"edge://extensions" | Set-Clipboard
				}
				if ($opera) {
					"opera://extensions" | Set-Clipboard
				}
			}

			if ($history) {
				if ($chrome) {
					"chrome://history" | Set-Clipboard
				}
				if ($brave) {
					"brave://history" | Set-Clipboard
				}
				if ($edge) {
					"edge://history" | Set-Clipboard
				}
				if ($opera) {
					"opera://history" | Set-Clipboard
				}
			}

			if ($clearhistory) {
				if ($chrome) {
					"chrome://settings/clearBrowserData" | Set-Clipboard
				}
				if ($brave) {
					"brave://settings/clearBrowserData" | Set-Clipboard
				}
				if ($edge) {
					"edge://settings/clearBrowserData" | Set-Clipboard
				}
				if ($opera) {
					"opera://settings/clearBrowserData" | Set-Clipboard
				}
			}
		}

		# open browser(s)
		if ($urls) {
			foreach ($url in $urls) {

				if ($secure) {
					$url.url = "https://" + $url.url
					if ($url.displayed) {
						$url.displayed = "https://" + $url.displayed
					}
				}

				if ($url.displayed) {
					write-host $url.displayed -ForegroundColor DarkYellow
				}

				openBrowser $url.url
			}
		}
		else {
			openBrowser
		}
	}
}


<# ===== Custom Modules Used ===== #>
# Get-Params
# Ask-Help
# Get-BooleanNames
# Show-ValidSet
# Check-ValidParams
# Get-CategoryNames
# Get-QueryString
