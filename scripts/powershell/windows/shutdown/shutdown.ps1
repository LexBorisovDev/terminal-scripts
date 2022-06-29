param(
	[switch]$force = $false,
	[switch]$seconds = $false
)

$value = Get-Params $MyInvocation.UnboundArguments -values
if(!$value) { $value = 0 }
if(!$seconds) { $value = [int]$value * 60 }

if($force) {
	shutdown /s /t $value
}
else {
	Write-Host "Are you sure? (YES to continue) " -ForegroundColor Red -NoNewline
	if(Get-Answer 'yes') { shutdown /s /t $value }
}
