$items = Get-Params $MyInvocation.UnboundArguments -values
& z --files $items
