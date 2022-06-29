$values = Get-Params $MyInvocation.UnboundArguments -values
$params = Get-Params $MyInvocation.UnboundArguments
& q --pexels $values $params
