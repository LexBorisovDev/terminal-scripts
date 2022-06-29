param(
	[switch]$x = $false
)
$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values

# initial location
if (!$x) {
	$initial = "$env:ProgramFiles"
}
else {
	$initial = "${env:ProgramFiles(x86)}"
}

Navigate -directories $dirs -params $params -initial $initial
