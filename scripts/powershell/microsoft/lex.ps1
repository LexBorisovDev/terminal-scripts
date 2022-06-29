$dirs = Get-Params $MyInvocation.UnboundArguments -values
& onedrive lex $dirs
