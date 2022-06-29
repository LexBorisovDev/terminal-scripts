function Help-Params {
	param(
		[switch]$short = $false
	)

	if($short) {
		$helpParams = @(
			@{name=@("--help");short=@("-h")}
		)
	}
	else {
		$helpParams = @(
			@{name=@("--help")}
		)
	}
	
	return $helpParams
}
