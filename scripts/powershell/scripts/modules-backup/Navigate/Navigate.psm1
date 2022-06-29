function Navigate {
	param(
		$directories = @(),
		$params = @(),
		[string]$initial = ""
	)
	
	$validParams = @(
		@{ name=@("--full"); short=@("-f") }
		@{ name=@("--display"); short=@("-d") }
	)
	
	$booleanNames = Get-BooleanNames $params $validParams
	if($booleanNames) {
		foreach($bn in $booleanNames) {
			if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
				New-Variable -Name $bn -Value $true
			}
		}
	}

	if(Ask-Help $params) {
		$params = Get-Params $params -help
		Show-ValidSet $validParams -values $values -params $params -noheader
	}
	else {
		$shorthand = Folders
		$advance = $true
		
		if($initial) {
			if(Test-Path $initial) {
				Set-Location $initial
			}
			else {
				Print-Error "cannot set path to $initial"
				$advance = $false
			}
		}
		
		if($advance) {
			if($directories) {
				$advance = $true
				$pathPattern = Path-Pattern
				
				foreach($dir in $directories) {
					if(!([string]::IsNullOrEmpty($dir))) {
						if($advance) {
							$items = Get-ChildItem -Directory -Force
							$location = ""
							
							if(!$full) {
								if($dir.length -gt 1 -and $dir -in $shorthand.short) {
									foreach($sh in $shorthand) {
										if($dir -in $sh.short) {
											$dir = $sh.name
											break
										}
									}
								}
							}
							
							if($dir -match $pathPattern)  {
								if(Test-Path $dir) {
									Set-Location $dir
								}
								else {
									Print-Error "no directory: $dir"
								}
							}
							else {
								$keepGoing = $true
								for ($j = 0; $j -lt $items.count -and $keepGoing; $j++) {	
									$dirname = $items[$j].Name
									
									if($dir.length -eq 1) {
										if($dirname -match "^$dir") {
											$location = $dirname
											$keepGoing = $false
										}
									}
									elseif ($dirname -match "$dir$") {
										$location = $dirname
										$keepGoing = $false
									}
									elseif ($dirname -match "^$dir") {
										$location = $dirname
										$keepGoing = $false
									}
									elseif ($dirname -match ".+$dir.+") {
										$location = $dirname
										$keepGoing = $false
									}
								}
								
								if ($location -ne "" -and (Test-Path .\"$location")) {
									Set-Location .\"$location"
								}
								else {
									Print-Error "no directory: $dir"
									$advance = $false
								}
							}
						}
					}
				}
			}
			
			if($display) {
				Invoke-Expression "x"
			}
		}
	}
}
