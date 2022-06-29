$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values
& q --godaddy $values $params
