$params = Get-Params $MyInvocation.UnboundArguments
$sources = Get-Params $MyInvocation.UnboundArguments -values

$helpParams = @(
	@{ name=@("--help"); short=@("-h") }
)

$validSources = @(
	@{
		category=@("javascript"); groupDescription="JavaScript";
		names=@(
			@{name=@("freeCodeCamp", "fcc");
				url="www.freecodecamp.org/learn"
			}
			@{name=@("FrontEndMasters", "fem");
				url="frontendmasters.com/dashboard/"
			}
			@{name=@("mdn", "mozilla");
				url="developer.mozilla.org/"
			}
			@{name=@("javascript", "js");
				url="developer.mozilla.org/en-US/docs/Web/JavaScript"
			}
			@{name=@("reintro", "re");
				url="developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript"
			}
			@{name=@("eloquentJS", "eloquent", "el");
				url="eloquentjavascript.net/"
			}
			@{name=@("speakingJS", "speaking", "speak");
				url="speakingjs.com/"
			}
			@{name=@("exploringJS", "exploring", "explore");
				url="exploringjs.com/"
			}
			@{name=@("exploringES6", "ES6", "6");
				url="exploringjs.com/es6/index.html"
			}
		)
	}
	@{
		category=@("webdev"); groupDescription="Web Development";
		names=@(
			@{name=@("w3schools", "w3");
				url="www.w3schools.com/html/default.asp"
			}
			@{name=@("css-tricks", "csstricks", "css");
				url="css-tricks.com"
			}
		)
	}
	@{
		category=@("editors"); groupDescription="Online Editors";
		names=@(
			@{ name=@("codepen", "pen"); url="codepen.io" }
			@{ name=@("jsfiddle", "fiddle"); url="jsfiddle.net/" }
			@{ name=@("codesandbox", "sandbox", "csb"); url="codesandbox.io/" }
		)
	}
)

if(Ask-Help $params -helpParams @helpParams) {
	$params = Get-Params $params -help -helpParams @helpParams
	Show-ValidSet $validSources -values $sources -params $params #-noheader
}
else {
	if (!$sources) {
		$sources = "fem"
	}

	$valid = $true
	
	foreach($source in $sources) {
		$names = $validSources.names
		if($source -in $names.name -or $source -in $names.short) {
			for($i = 0; $i -lt $names.count; $i++) {
				if($source -in $names[$i].name -or $source -in $names[$i].short) {
					$url = $names[$i].url
				}
			}
		}
		else {
			$valid = $false
			write-host "invalid source: $source" -ForegroundColor Red
		}
		
		# open URL
		if ($valid) {
			& q $url $params
		}
	}
}
