$dir = Get-Params $MyInvocation.UnboundArguments -values

if (!($dir.count -eq 1)) {
	Print-Error "provide 1 React directory"
}
elseif($dir.count -eq 1) {
	& npx create-react-app $dir
}
