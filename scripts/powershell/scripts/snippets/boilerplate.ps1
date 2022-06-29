'$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

# $helpParams = @(
# 	@{ name = @("--help"); short = @("-h") }
# )

$validParams = @(
	@{ name = @("--"); short = @("-") }
)

# $validParams = @(
# 	@{category = ""; groupDescription = "";
# 		names = @(
# 			@{ name = @("--"); short = @("-") }
# 		)
# 	}
# )

if (Ask-Help $params) {
	$params = Get-Params $params -help
	Show-ValidSet $validParams -values $values -params $params #-noheader
}
# if (Ask-Help $params -helpParams @helpParams) {
# 	$params = Get-Params $params -help -helpParams @helpParams
# 	Show-ValidSet $validParams -values $values -params $params #-noheader
# }
else {

}' | Set-Clipboard
