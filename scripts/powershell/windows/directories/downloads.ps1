$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial = "$env:UserProfile\Downloads"
Navigate -directories $dirs -params $params -initial $initial
