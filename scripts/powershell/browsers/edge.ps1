$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values
& q --edge $values $params
