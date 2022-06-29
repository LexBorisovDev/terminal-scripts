$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values

$pwsh = $env:PowershellScriptsDirectory
$items = Get-ChildItem -Path $pwsh -Directory -Name
$initial = Get-Location
$pathPattern = Path-Pattern

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{ name = @("--all"); short = @("-a") }
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $localParams $validParams $helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	if($all) {
		& code $pwsh
	}
	else {
		foreach($dir in $dirs) {
			if($dir -match $pathPattern) {
				if(Test-Path $dir) {
					Set-Location $dir
					& code .
					Set-Location $initial
				}
				else {
					Print-Error "wrong path"
				}
			}
			else {
				try {
					$foundOne = $false
					foreach($item in $items) {
						if($item -match "^$dir") {
							& code "$pwsh\$item"
							if(!$foundOne) { $foundOne = $true }
						}
					}
					if(!$foundOne) {
						Print-Error "no directory(s) that match"
					}
				}
				catch {
					Print-Error "wrong argument"
				}
			}
		}
	}
}
