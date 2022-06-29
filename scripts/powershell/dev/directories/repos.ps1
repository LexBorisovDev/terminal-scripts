$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial = "$env:UserProfile\source\repos"
Navigate -directories $dirs -params $params -initial $initial
