$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values

$validParams = @(
	@{
		category = @("options"); groupDescription = "Options";
		names = @(
			@{
				name = @("--all"); short = @("-a");
				powershell = "-Force"
   		}
			@{
				name = @("--hidden"); short = @("-h");
				powershell = "-Hidden"
   		}
			@{
				name = @("--directories", "--directory"); short = @("-d");
				powershell = "-Directory"
   		}
			@{
				name = @("--files", "--file"); short = @("-f");
				powershell = "-File"
   		}
		)
	}
)

# ==== HELP ====
if (Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$params = Get-Params $params -validParams $validParams -local
	$booleanNames = Get-BooleanNames $params $validParams #$helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}
	
	$dirParams = Get-Params $params -excludeParams $validParams -exclude
	$initial = Get-Location
	Navigate -directories $dirs -params $dirParams -initial $initial
	
	if ($options) {
		$optionString = ""
		foreach ($param in $params) {
			foreach ($vp in $validParams.names) {
				if ($param -in $vp.name -or $param -in $vp.short) {
					$optionString = $optionString + $vp.powershell + " "
				}
			}
		}
		Invoke-Expression "Get-ChildItem $optionString"
	}
	else { Get-ChildItem }
	
	Set-Location $initial
}
