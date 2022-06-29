$params = Get-Params $MyInvocation.UnboundArguments
$youtube = "www.youtube.com/playlist"
$playlist = "list=PLBo_08j5fnuUBeDg3p_esP_eM2G7Hyhcv"
$url = $youtube + '?' + $playlist

& q $url $params
