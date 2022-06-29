$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name = @("--help"); short = @("-h") }
)

$validParams = @(
	@{
		category = @("byteSizes"); groupDescription = "Byte Sizes";
		names = @(
			@{ name = @("--kilobyte", "--kilo"); short = @("-k") }
			@{ name = @("--megabyte", "--mega"); short = @("-m") }
			@{ name = @("--gigabyte", "--giga"); short = @("-g") }
			@{ name = @("--terabyte", "--tera"); short = @("-t") }
		)
	}
	@{
		category = @("options"); groupDescription = "Options";
		names = @(
			@{ name = @("--byte"); short = @("-b") }
			@{ name = @("--format"); short = @("-f") }
		)
	}
)

if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params #-noheader
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
	
	$dirs = $values
	$initial = Get-Location

	# navigate to directory for which to show size info
	if ($dirs) {
		Navigate -directories $dirs -initial $initial
	}

	& x

	# display size info
	function showSizeInfo {
		param(
			[string]$bytesize = "mb",
			[switch]$showBytes = $false
		)

		$size = (Get-ChildItem -Path (Get-Location) -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
		if ($showBytes) {
			$size = '{0:N0}' -f $size
			$byteSize = " B"
		}
		else {
			$size = [math]::Round(($size / "1$bytesize"), 5)
			$byteSize = $byteSize.toUpper()
		}
		
		if ($format) {
			$size = '{0:N5}' -f $size
		}
		
		write-host "$byteSize " -ForegroundColor DarkGray -NoNewline
		write-host "$size" -ForegroundColor Cyan
	}

	# get byteSizes without leading dashes
	$byteSizes = Get-CategoryNames $validParams @("byteSizes")
	$newBytes = @()
	foreach ($bs in $byteSizes) {
		$bs = $bs.name[0].split("--")[1]
		$newBytes += $bs
	}
	$byteSizes = $newBytes

	# show bytes
	if ($byte) {
		showSizeInfo -showBytes
	}

	# show size info based on supplied params
	$bytePrefix = $false
	if ($booleanNames) {
		foreach ($bs in $byteSizes) {
			if ($bs -in $booleanNames) {
				$bs = $bs[0] + "b"
				showSizeInfo $bs

				if (!$bytePrefix) { $bytePrefix = $true }
			}
		}
	}
	
	# show deafult info if no params supplied
	if (!$bytePrefix -and !$byte) {
		showSizeInfo
	}

	Set-Location $initial
}
