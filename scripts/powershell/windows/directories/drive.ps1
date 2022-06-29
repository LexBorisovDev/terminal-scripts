$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial = "$env:HOMEDRIVE\"
Navigate -directories $dirs -params $params -initial $initial
