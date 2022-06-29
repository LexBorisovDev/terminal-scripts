function Get-Answer {
	param(
		[string[]]$acceptedAnswers
	)
	
	$answer = read-host
	
	if(!$answer -or ($answer.count -gt 1)) {
		return $false
	}
	else {
		if($answer -ieq $acceptedAnswers -or ($answer -in $acceptedAnswers)) {
			return $true
		}
		return $false
	}
}