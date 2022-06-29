$params = Get-Params $MyInvocation.UnboundArguments
$dirs = Get-Params $MyInvocation.UnboundArguments -values
$initial =  "$env:HOMEDRIVE\dev\scripts\plexxis"
Navigate -directories $dirs -params $params -initial $initial
