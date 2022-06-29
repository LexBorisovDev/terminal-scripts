$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial = "$env:UserProfile\Personal"
Navigate -directories $dirs -params $params -initial $initial
