$items = Get-Params $MyInvocation.UnboundArguments -values
& z --directories $items
