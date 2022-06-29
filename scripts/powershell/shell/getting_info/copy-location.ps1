$params = Get-Params $MyInvocation.UnboundArguments

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{
		category = "unixPath"; groupDescription = "Unix Paths";
		names = @(
			@{ name = @("--unix"); short = @("-u") }
			@{ name = @("--wsl"); short = @("-w") }
			@{ name = @("--gitbash", "--git"); short = @("-g") }
		)
	}
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$booleanNames = Get-BooleanNames $params $validParams $helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	function copyLocation {
		param(
			[string]$copyLocation = "",
			[switch]$unixLocation = $false,
			[switch]$wslLocation = $false,
			[switch]$gitbashLocation = $false
		)
	
		if ($copyLocation) {
			$copyLocation | Set-Clipboard
			write-host "copied " -ForegroundColor Cyan -NoNewline
			write-host "$copyLocation " -NoNewline

			if ($unixLocation) {
				write-host "(unix)" -ForegroundColor DarkGray
			}
			elseif ($gitbashLocation) {
				write-host "(git bash)" -ForegroundColor DarkGray
			}
			elseif ($gitbashLocation) {
				write-host "(git bash)" -ForegroundColor DarkGray
			}
			else {
				write-host "(windows)" -ForegroundColor DarkGray
			}
		}
	}
	
	$location = Convert-Path .
	
	if ($unixPath) {
		if ($unix) {
			$location = Unix-Path $location
			copyLocation $location -unixLocation
		}
		
		if ($wsl) {
			$location = Unix-Path $location -wsl
			copyLocation $location -wslLocation
		}

		if ($gitbash) {
			$location = Unix-Path $location -gitbash
			copyLocation $location -gitbashLocation
		}
	}
	else {
		copyLocation $location
	}
}
