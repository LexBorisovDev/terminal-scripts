$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial = Get-Location
Navigate -directories $dirs -params $params -initial $initial
