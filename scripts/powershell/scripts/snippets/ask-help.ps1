'if (Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validParams -values $values -params $params #-noheader
}
# if (Ask-Help $params) {
# 	$params = Get-Params $params -help
# 	Show-ValidSet $validParams -values $values -params $params #-noheader
# }' | Set-Clipboard
