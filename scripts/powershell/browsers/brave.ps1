$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values
& q --brave $values $params
