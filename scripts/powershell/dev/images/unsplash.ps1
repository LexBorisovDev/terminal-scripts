$values = Get-Params $MyInvocation.UnboundArguments -values
$params = Get-Params $MyInvocation.UnboundArguments
& q --unsplash $values $params
