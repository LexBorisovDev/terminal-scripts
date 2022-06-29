$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{ name = @("--all") }
	@{ name = @("--file", "--ps1"); short = @("-f") }
	@{ name = @("--starts", "--start"); short = @("-s") }
)

if (Ask-Help $params $helpParams) {
	$params = Get-Params $params -helpParams $helpParams -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $localParams $validParams @helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	$aliasFile = "C:\Program Files\PowerShell\7\Profile.ps1"
	$content = Get-Content $aliasFile
	$aliases = @()
	
	$wordPattern = "^[A-Za-zА-Яа-я0-9\-]+$"
	$scriptPattern = '"?powershellScriptsDirectory\\([^\"]+)"?$'
	$namePattern = "^[^#].+ -Name .+"
	$valuePattern = "^[^#].+ -Value .+"
	$nameCapturePattern = ".+ -Name ([\w\-]+) -Value .+"
	
	function printSplitValue {
		param([string]$value)
		$ext = $value.split(".")[1]
		$value = $value.split(".")[0]
	
		$category = $value.split("\")[0]
		$value -match ("\\([\w\\\-]+)") | Out-Null
		$value = $matches[1]
	
		$nested = $value.split("\")
		$directories = @()
		for ($i = 0; $i -lt $nested.length - 1; $i++) {
			$directories += $nested[$i]
		}
	
		$value = $nested[$nested.length - 1]
	
		write-host "..." -ForegroundColor DarkGray -NoNewline
		write-host "$category\" -ForegroundColor DarkGray -NoNewline
	
		foreach ($dir in $directories) {
			write-host "$dir" -ForegroundColor DarkYellow -NoNewline
			write-host "\" -ForegroundColor DarkGray -NoNewline
		}
	
		write-host "$value" -ForegroundColor Green -NoNewline
		write-host ".$ext" -ForegroundColor DarkGray
	}
	
	if ($values) {
		foreach ($line in $content) {
			if ($line -match $namePattern -and $line -match $valuePattern) {
				$value = $line.split("-Value ")[1]
				$line -match $nameCapturePattern | Out-Null
				$name = $matches[1]
				$aliases += @{ name = $name; value = $value }
			}
		}
	
		$matched = @()
		foreach ($value in $values) {
			if($value -match $wordPattern) {
				foreach ($alias in $aliases) {
					if (!($value -match (Path-Pattern))) {
						if ($value.length -eq 1 -or $starts) {
							if ($alias.name -match "^$value.*") {
								$matched += $alias
							}
						}
						elseif ($value.length -gt 1) {
							if ($file) {
								if ($alias.value -match "$value\.ps1\`"?$") {
									if (!($alias -in $matched)) {
										$matched += $alias
									}
								}
							}
							else {
								if ($alias.name -match "$value") {
									if (!($alias -in $matched)) {
										$matched += $alias
									}
								}
							}
						}
					}
				}
			}
		}
	
		if ($matched) {
			foreach ($alias in $matched) {
				write-host $alias.name -ForegroundColor Cyan -NoNewline
				write-host " --> " -ForegroundColor DarkGray -NoNewline
				if ($alias.value -match $scriptPattern) {
					$alias.value -match $scriptPattern | Out-Null
					$value = $matches[1]
					printSplitValue $value
				}
				elseif ($alias.value -match $wordPattern) {
					write-host $alias.value -ForegroundColor DarkCyan
				}
				else {
					write-host $alias.value -ForegroundColor Gray
				}
			}
		}
		else {
			Print-Error "no matches"
		}
	}
	else {
		if (!$all) {
			write-host "Print all aliases? " -ForegroundColor Cyan -NoNewline
			write-host "(YES to proceed) " -ForegroundColor DarkGray -NoNewline
			$all = Get-Answer @("YES", "Y")
		}
	
		if ($all) {
			foreach ($line in $content) {
				if ($line -match $namePattern -and $line -match $valuePattern) {
					$value = $line.split("-Value ")[1]
					$line -match $nameCapturePattern | Out-Null
					$name = $matches[1]
		
					write-host $name -ForegroundColor Cyan -NoNewline
					write-host " --> " -ForegroundColor DarkGray -NoNewline
					if ($value -match $scriptPattern) {
						$value -match $scriptPattern | Out-Null
						$value = $matches[1]
						printSplitValue $value
					}
					elseif ($value -match $wordPattern) {
						write-host $value -ForegroundColor DarkCyan
					}
					else {
						write-host $value -ForegroundColor Gray
					}
				}
				else {
					write-host $line -ForegroundColor DarkGray
				}
			}
		}
	}
}
