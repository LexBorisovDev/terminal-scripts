$params = Get-Params $MyInvocation.UnboundArguments
$services = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

# validate the command
$google = "google.com"

$validServices = @(
	@{ name = @("images", "image", "img"); url = "images" }
	@{ name = @("docs", "doc"); url = "docs" }
	@{ name = @("sheets", "sheet"); url = "sheets" }
	@{ name = @("slides", "slide"); url = "slides" }
	@{ name = @("gmail", "mail"); url = "mail" }
	@{ name = @("keep"); url = "keep" }
	@{ name = @("maps", "map"); url = "maps" }
	@{ name = @("admin"); url = "admin" }
	@{ name = @("myaccount", "account", "acct", "acc"); url = "myaccount" }
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validServices -values $services -params $params #-noheader
}
else {
	if (!$services) {
		& q $google $params
	}
	else {
		foreach ($service in $services) {
			if ($service -in $validServices.name -or $service -in $validServices.short) {
				foreach ($vs in $validServices) {
					if ($service -in $vs.name -or $service -in $vs.short) {
						$url = $vs.url + "." + $google
						& q $url $params
					}
				}
			}
			else {
				write-host "invalid service: $service" -ForegroundColor Red
			}
		}
	}
}
