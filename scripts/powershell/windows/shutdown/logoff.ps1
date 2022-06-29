param(
	[switch]$force = $false
)

if($force) { shutdown /l }
else {
	Write-Host "Are you sure? (YES to continue) " -ForegroundColor Red -NoNewline
	if(Get-Answer @("yes")) { shutdown /l }
}
