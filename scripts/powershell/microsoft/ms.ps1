$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name=@("--help"); short=@("-h") }
)

$validParams = @(
	@{ name=@("excel"); short=@("e") }
	@{ name=@("word"); short=@("w") }
	@{ name=@("powerpoint", "ppt"); short=@("p") }
	@{ name=@("teams"); short=@("t") }
	@{ name=@("outlook"); short=@("o") }
)

if(Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	if(!$values) {
		Print-Error "1 value must provided"
	}
	else {
		$localParams = Get-Params $values -validParams $validParams -local
		$booleanNames = Get-BooleanNames $localParams $validParams $helpParams
		if($booleanNames) {
			foreach($bn in $booleanNames) {
				if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
					New-Variable -Name $bn -Value $true
				}
			}
		}

		$script:msOffice = "$env:ProgramFiles\Microsoft Office\root\Office16"

		if($excel) {
			& "$msOffice\EXCEL.EXE"
		}
		
		if($word) {
			& "$msOffice\WINWORD.EXE"
		}
		
		if($powerpoint) {
			& "$msOffice\POWERPNT.EXE"
		}
		
		if($teams) {
			& "$env:UserProfile\AppData\Local\Microsoft\Teams\Update.exe" --processStart Teams.exe
		}
		
		if($outlook) {
			& "$msOffice\OUTLOOK.EXE"
		}
	}
}
