$items = Get-Params $MyInvocation.UnboundArguments -values
& z --hidden $items
