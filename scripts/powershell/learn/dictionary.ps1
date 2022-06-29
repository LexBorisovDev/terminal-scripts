$params = Get-Params $MyInvocation.UnboundArguments
$values = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name=@("--help"); short=@("-h") }
)

$validParams = @(
	@{category = "definition"; groupDescription = "Definition";
		names = @(
			@{ name = @("--dictionary"); short = @("-d") }
			@{ name = @("--thesaurus"); short = @("-t") }
			@{ name = @("--merriam", "-merriam-webster", "--mw"); short = @("-m") }
		)
	}
	@{category = "findWords"; groupDescription = "Find Words";
		names = @(
		 @{ name = @("--start", "--starts", "--begin", "--begins", "--beg"); short = @("-s", "-b") }
		 @{ name = @("--end", "--ends"); short = @("-e") }
		 @{ name = @("--contain", "--contains", "--containing"); short = @("-c") }
		 @{ name = @("--related", "--relates", "--relate"); short = @("-r") }
		)
	}
)

if (Ask-Help $params $helpParams) {
	$params = Get-Params $params -help -helpParams $helpParams
	Show-ValidSet $validParams -values $values -params $params -noheader
}
else {
	$localParams = Get-Params $params -validParams $validParams -local
	if (!$localParams) { $localParams = @("--thesaurus") }
	
	$params = Get-Params $params -validParams $validParams -query
	$booleanNames = Get-BooleanNames $localParams $validParams $helpParams
	if ($booleanNames) {
		foreach ($bn in $booleanNames) {
			if (!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}
	
	$urls = @();
	
	$dictionaryURL = "www.dictionary.com/"
	$thesaurusURL = "www.thesaurus.com/"
	$merriamURL = "www.merriam-webster.com/"
	$freeDictionaryURL = "www.thefreedictionary.com/"
	$startWith = "words-that-start-with-"
	$endIn = "words-that-end-in-"
	$containing = "words-containing-"
	$relatedWordsURL = "relatedwords.org/"
	$relatesTo = "relatedto/"
	
	if ($values) {
		foreach ($value in $values) {
			if ($definition) {
				if ($dictionary) {
					$url = $dictionaryURL + "browse/" + $value
					$urls += $url
				}
		
				if ($thesaurus) {
					$url = $thesaurusURL + "browse/" + $value
					$urls += $url
				}
		
				if ($merriam) {
					$url = $merriamURL + "dictionary/" + $value
					$urls += $url
				}
			}

			if ($findWords) {
				if ($start) {
					$url = $freeDictionaryURL + $startWith + $value
					$urls += $url
				}

				if ($end) {
					$url = $freeDictionaryURL + $endIn + $value
					$urls += $url
				}

				if ($contain) {
					$url = $freeDictionaryURL + $containing + $value
					$urls += $url
				}

				if ($related) {
					$url = $relatedWordsURL + $relatesTo + $value
					$urls += $url
				}
			}
		}
	}
	else {
		if ($definition) {
			if ($dictionary) { $urls += $dictionaryURL }
			if ($thesaurus) { $urls += $thesaurusURL }
			if ($merriam) { $urls += $merriamURL }
		}
		elseif ($related) {
			$urls += $relatedWordsURL
		}
		else {
			$urls += $freeDictionaryURL
		}
	}
	
	if ($urls) {
		foreach ($url in $urls) {
			& q $url $params
		}
	}
}
