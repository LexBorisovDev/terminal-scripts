function Show-ValidSet {
	param(
		$validSet = @(),
		$values = @(),
		$params = @(),
		[switch]$noheader = $false
	)
	[switch]$script:linegap = $true
	
	# found matches
	$showNames = @()

	# SHOW HEADER
	function showHeader {
		write-host "+-----------------------------------------------+" -ForegroundColor DarkGray
		write-host "|  " -Foreground DarkGray -NoNewline
		write-host "Group description  " -Foreground DarkYellow -NoNewline
		write-host "Parameter description" -Foreground Green -NoNewline
		write-host "     |" -Foreground DarkGray
		
		write-host "|  " -Foreground DarkGray -NoNewline
		write-host "primary  " -Foreground Cyan -NoNewline
		write-host "alternate  " -Foreground Magenta -NoNewline
		write-host "shorthand  " -Foreground DarkGray -NoNewline
		write-host "examples" -Foreground Gray -NoNewline
		write-host "      |" -Foreground DarkGray
		write-host "+-----------------------------------------------+" -ForegroundColor DarkGray
	}

	function showName {
		param(
			$obj = @{},
			[switch]$nohighlight = $false
		)
		$highlight = $false
		
		if ($obj) {
			$names = $obj.name
			
			# highlight found values, if any
			if (!$nohighlight) {
				foreach ($name in $names) {
					if ($name -in $showNames) {
						$highlight = $true
					}
				}
				
				if (!$highlight) {
					if ($obj.short) {
						foreach ($short in $obj.short) {
							if ($short -in $showNames) {
								$highlight = $true
							}
						}
					}
				}
			}
			
			if ($highlight) {
				write-host "> " -ForegroundColor Green -NoNewline
				write-host $names[0] -ForegroundColor Cyan -NoNewline
			}
			else {
				if ($groups) {
					write-host " "$names[0] -ForegroundColor Cyan -NoNewline
				}
				else {
					write-host $names[0] -ForegroundColor Cyan -NoNewline
				}
			}
			
			if ($names.count -gt 1) {
				for ($i = 1; $i -lt $names.count; $i++) {
					$name = $names[$i]
					write-host " "$name -ForegroundColor Magenta -NoNewline
				}
			}
			if ($obj.short) {
				foreach ($short in $obj.short) {
					write-host " "$short -ForegroundColor DarkGray -NoNewline
				}
			}
			write-host ""

			if ($obj.description) {
				if ($groups) {
					write-host "    "$obj.description -ForegroundColor Green
				}
				else {
					write-host "  "$obj.description -ForegroundColor Green
				}
			}
			
			if ($obj.examples) {
				foreach ($example in $obj.examples) {
					if ($groups) {
						write-host "      "$example -ForegroundColor Gray
					}
					else {
						write-host "    "$example -ForegroundColor Gray
					}
				}
			}

			if ($obj.description -or $obj.examples) {
				$script:linegap = $true
			}
			else {
				$script:linegap = $false
			}
			
			if ($script:linegap) { write-host "" }
		}
	}
	
	if (!$values -and !$params) {
		if (!$noheader) {
			write-host ""
			showHeader
		}
	}

	if ($validSet) {
		# DETERMINE IF THERE ARE GROUP DESCRIPTIONS
		$groups = $false
		$setCount = $validSet.count
		$descriptionCount = 0
		foreach ($vs in $validSet) {
			if ($vs.groupDescription) {
				$descriptionCount++
				if (!$groups) { $groups = $true }
			}
		}

		# MAKE A MIX SET, IF ANY
		# mixSet is when there are values with categories and without
		if ($groups -and !($setCount -eq $descriptionCount)) {
			$mixSet = @()
			foreach ($vs in $validSet) {
				if (!$vs.groupDescription) {
					$mixSet += $vs
				}
			}
		}
		
		# FILTER WHAT PARAMS TO SHOW
		function withDash {
			param(
				[string]$name = ""
			)
			
			$withDash = $false
			if ($name) {
				$withDash = $name -match "^-.+"
			}
			return $withDash
		}

		function withDoubleDash {
			param(
				[string]$name = ""
			)
			
			$withDoubleDash = $false
			if ($name) {
				$withDoubleDash = $name -match "^--.+"
			}
			return $withDoubleDash
		}

		$showSet = $validSet

		$searchValues = @()
		foreach ($value in $values) {
			$searchValues += $value
		}
		
		if ($params) {
			foreach ($param in $params) {
				if (withDoubleDash $param) {
					$searchValues += $param.split("--")[1]
				}
				elseif (withDash $param) {
					$searchValues += $param.split("-")[1]
				}
			}
		}
		$values = $searchValues
		
		if ($values) {
			$values = $values | Sort-Object
			$singleChar = $false
			$showSet = @()
			$showMixSet = @()
			
			foreach ($value in $values) {
				$searchValue = $value
				
				# groups and mixset
				if ($groups) {
					# search by groups
					foreach ($vs in $validSet) {
						if ($value.length -eq 1) {
							if ($vs.groupDescription -match "^-?$value") {
								if (!($vs -in $showSet)) {
									$showSet += $vs
								}
								if (!($vs.groupDescription -in $showNames)) {
									$showNames += $vs.groupDescription
								}
							}
						}
						elseif ($vs.groupDescription -match "$value") {
							if (!($vs -in $showSet)) {
								$showSet += $vs
							}
							if (!($vs.groupDescription -in $showNames)) {
								$showNames += $vs.groupDescription
							}
						}
					}
					
					# search by individual values
					foreach ($group in $validSet) {
						foreach ($vs in $group.names) {
							$value = $searchValue
							$dash = withDoubleDash $vs.name[0]
							if ($dash) {
								if ($value.length -eq 1) {
									$value = "-$value"
								}
								elseif ($value.length -gt 1) {
									$value = "--$value"
								}
							}
							
							if ($dash) { $singleChar = $value.length -eq 2 }
							else { $singleChar = $value.length -eq 1 }
							
							# find full match
							if ($value -in $vs.name -or $value -in $vs.short) {
								if (!($group -in $showSet)) {
									$showSet += $group
								}
								if (!($value -in $showNames)) {
									$showNames += $value
								}
							}
							# find partial match
							else {
								foreach ($name in $vs.name) {
									if ($singleChar) {
										if ($name -match "^-?$value") {
											if (!($group -in $showSet)) {
												$showSet += $group
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
									else {
										if ($name -match "$value") {
											if (!($group -in $showSet)) {
												$showSet += $group
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
								}
								
								foreach ($name in $vs.short) {
									if ($singleChar) {
										if ($name -match "^-?$value") {
											if (!($group -in $showSet)) {
												$showSet += $group
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
									else {
										if ($name -match "$value") {
											if (!($group -in $showSet)) {
												$showSet += $group
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
								}
							}
						}
					}
					
					# search in mixSet
					if ($mixSet) {
						foreach ($vs in $mixSet) {
							$value = $searchValue
							$dash = withDoubleDash $vs.name[0]
							if ($dash) {
								if ($value.length -eq 1) {
									$value = "-$value"
								}
								elseif ($value.length -gt 1) {
									$value = "--$value"
								}
							}

							if ($dash) { $singleChar = $value.length -eq 2 }
							else { $singleChar = $value.length -eq 1 }
							
							# find full match
							if ($value -in $vs.name -or $value -in $vs.short) {
								if (!($vs -in $showMixSet)) {
									$showMixSet += $vs
								}
								if (!($value -in $showNames)) {
									$showNames += $value
								}
							}
							# find partial match
							else {
								foreach ($name in $vs.name) {
									if ($singleChar) {
										if ($name -match "^-?$value") {
											if (!($vs -in $showMixSet)) {
												$showMixSet += $vs
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
									else {
										if ($name -match "$value") {
											if (!($vs -in $showMixSet)) {
												$showMixSet += $vs
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
								}
								
								foreach ($name in $vs.short) {
									if ($singleChar) {
										if ($name -match "^-?$value") {
											if (!($vs -in $showMixSet)) {
												$showMixSet += $vs
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
									else {
										if ($name -match "$value") {
											if (!($vs -in $showMixSet)) {
												$showMixSet += $vs
											}
											if (!($name -in $showNames)) {
												$showNames += $name
											}
										}
									}
								}
							}
						}
					}
				}
				# no groups
				else {					
					foreach ($vs in $validSet) {
						$value = $searchValue
						$dash = withDoubleDash $vs.name[0]
						if ($dash) {
							if ($value.length -eq 1) {
								$value = "-$value"
							}
							elseif ($value.length -gt 1) {
								$value = "--$value"
							}
						}
						
						if ($dash) { $singleChar = $value.length -eq 2 }
						else { $singleChar = $value.length -eq 1 }
						
						# find full match
						if ($value -in $vs.name -or $value -in $vs.short) {
							if (!($vs -in $showSet)) {
								$showSet += $vs
							}
						}
						
						# find partial match
						else {
							foreach ($name in $vs.name) {
								if ($singleChar) {
									if ($name -match "^-?$value") {
										if (!($vs -in $showSet)) {
											$showSet += $vs
										}
										if (!($name -in $showNames)) {
											$showNames += $name
										}
									}
								}
								else {
									if ($name -match "$value") {
										if (!($vs -in $showSet)) {
											$showSet += $vs
										}
										if (!($name -in $showNames)) {
											$showNames += $name
										}
									}
								}
							}
							
							foreach ($name in $vs.short) {
								if ($singleChar) {
									if ($name -match "^-?$value") {
										if (!($vs -in $showSet)) {
											$showSet += $vs
										}
										if (!($name -in $showNames)) {
											$showNames += $name
										}
									}
								}
								else {
									if ($name -match "$value") {
										if (!($vs -in $showSet)) {
											$showSet += $vs
										}
										if (!($name -in $showNames)) {
											$showNames += $name
										}
									}
								}
							}
						}
					}
				}
			}
		}
		
		if ($values) {
			$mixSet = $showMixSet
		}
		
		if (!$showSet -and !$mixSet) {
			Print-Error "no matches"
		}
		else {
			write-host ""
			
			# NO GROUP DESCRIPTIONS
			if (!$groups) {
				$showSet = $showSet | Sort-Object -Property name
				foreach ($name in $showSet) {
					showName $name -nohighlight
				}
				if (!$script:linegap) { write-host "" }
			}
			else {
				# GROUP DESCRIPTIONS
				if ($groups) {
					$groupDescriptions = @()
			
					foreach ($vs in $showSet) {
						if (!($vs.groupDescription -in $groupDescriptions)) {
							$groupDescriptions += $vs.groupDescription
						}
					}

					$groupDescriptions = $groupDescriptions | Sort-Object

					# show items within each group
					foreach ($description in $groupDescriptions) {
						if ($description -in $showNames) {
							write-host "*** " -ForegroundColor Green -NoNewline
							write-host $description -ForegroundColor DarkYellow -NoNewline
							write-host " ***" -ForegroundColor Green
						}
						else {
							write-host $description -ForegroundColor DarkYellow
						}
					
						foreach ($vs in $showSet) {
							$names = $vs.names | Sort-Object -Property name
							if ($vs.groupDescription -ieq $description) {
								foreach ($obj in $names) {
									showName $obj
								}
							}
						}
						write-host ""
					}
				}

				if ($mixSet) {
					write-host "Other Parameters" -ForegroundColor Red
					$mixSet = $mixSet | Sort-Object -Property name
					
					foreach ($name in $mixSet) {
						showName $name
					}
					write-host ""
				}
			}
		}
	}
}
