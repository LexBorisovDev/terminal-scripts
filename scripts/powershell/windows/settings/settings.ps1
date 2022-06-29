$settings = Get-Params $MyInvocation.UnboundArguments -values

if ($settings) {
	Start-Process ms-settings:$settings
}
else {
	Start-Process ms-settings:
}
