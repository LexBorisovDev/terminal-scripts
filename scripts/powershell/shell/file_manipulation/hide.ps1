$params = Get-Params $MyInvocation.UnboundArguments
$items = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{ name=@("--unhide"); short=@("-u") }
	@{ name=@("--all"); short=@("-a") }
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $items -params $params -noheader
}
else {
	$booleanNames = Get-BooleanNames $params $validParams @helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	$pathPattern = Path-Pattern
	$slashPattern = "[\\\/].*[\w\d_]$"
	$slashEndPattern = "([\w\-_\. \\\/]+)[\\\/]$"

	function hideAll {
		$childItems = Get-ChildItem -Name
		foreach($ci in $childItems) {
			attrib +h $ci
		}
	}

	function unhideAll {
		$childItems = Get-ChildItem -Name -Force
		foreach($ci in $childItems) {
			if((Get-Item "$ci" -Force).Attributes -match "Hidden") {
				attrib -h $ci
			}
		}
	}

	if($all -and !$items) {
		if($unhide) {
			unhideAll
			write-host "unhid all hidden items" -ForegroundColor Cyan
		}
		else {
			hideAll
			write-host "hid all items" -ForegroundColor Cyan
		}
	}
	elseif($all -and $items) {
		$initial = Get-Location
		foreach($item in $items) {
			$location = ""
			if($item -match $pathPattern) {
				$location = $item
			}
			else {
				$childDirs = Get-ChildItem -Name -Directory
				foreach($dir in $childDirs) {
					if($item.length -eq 1) {
						if($dir -match "^$item") {
							$location = $dir
							break
						}
					}
					elseif($item.length -gt 1) {
						$item = Get-ItemName $item
						if($dir -ieq $item) {
							$location = $dir
							break
						}
					}
				}
			}

			if($location) {
				if(Test-Path $location) {
					Set-Location $location

					if($unhide) {
						unhideAll
						write-host "unhid all hidden items in " -ForegroundColor Cyan -NoNewline
						write-host "$location" -ForegroundColor DarkYellow
					}
					else {
						hideAll
						write-host "hid all items in " -ForegroundColor Cyan -NoNewline
						write-host "$location" -ForegroundColor DarkYellow
					}
				}
				else {
					Print-Error "invalid path: $location"
				}
			}
			else {
				Print-Error "$item does not exist"
			}
			Set-Location $initial
		}
	}
	elseif($items) {
		$childItems = Get-ChildItem -Name -Force
		foreach($item in $items) {
			$hidItem = ""

			if($item -match $slashEndPattern) {
				$hidItem = $matches[1]
			}
			elseif($item -match $slashPattern) {
				$hidItem = $item
			}
			else {
				$item = Get-ItemName $item
				foreach($ci in $childItems) {
					if($item -ieq $ci) {
						$hidItem = $ci
						break
					}
				}
			}

			if($hidItem) {
				if($unhide) {
					if((Get-Item "$hidItem" -Force).Attributes -match "Hidden") {
						attrib -h $hidItem
						write-host "unhid " -ForegroundColor Cyan -NoNewline
						write-host $hidItem
					}
					else {
						Print-Error "$hidItem is not hidden"
					}
				}
				else {
					if(!((Get-Item "$hidItem" -Force).Attributes -match "Hidden")) {
						attrib +h $hidItem
						write-host "hid " -ForegroundColor Cyan -NoNewline
						write-host $hidItem
					}
					else {
						Print-Error "$hidItem is already hidden"
					}
				}
			}
			else {
				Print-Error "$item does not exist"
			}
		}
	}
}
