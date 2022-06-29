$items = Get-Params $MyInvocation.UnboundArguments -values
& z --all $items
