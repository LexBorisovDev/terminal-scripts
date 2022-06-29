function Go-Back {
	param(
		[int]$times = 1
	)

	for($i = 0; $i -lt $times; $i++) {
		Set-Location ..
	}
}
