param (
	[switch]$reintro = $false
)

$params = $MyInvocation.UnboundArguments

if ($reintro) {
	& learn-code reintro $params
}
else {
	& learn-code js $params
}
