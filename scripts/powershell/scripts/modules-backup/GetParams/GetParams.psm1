function Get-Params {
	param(
		$params = @(),
		$validParams = @(),
		$helpParams = @(),
		$excludeParams = @(),
		[switch]$values = $false, # requires params
		[switch]$query = $false, # requires validParams
		[switch]$local = $false, # requires validParams
		[switch]$exclude = $false, # requires excludeParams
		[switch]$help = $false, # requires helpParams (or default is used)
		[switch]$about = $false # about this module
	)
	
	if ($about) {
		function writeArray {
			param ([string]$value = '')
			write-host "`$$value" -ForegroundColor Red -NoNewline
			write-host ' = ' -ForegroundColor Cyan -NoNewline
			write-host '@' -ForegroundColor Magenta -NoNewline
			write-host '()' -ForegroundColor DarkGray -NoNewline
			write-host ',' -ForegroundColor Gray
		}
		function writeSwitch {
			param(
				[string]$value = '',
				[string]$comment = '',
				[switch]$last = $false
			)
			write-host '[' -ForegroundColor DarkGray -NoNewline
			write-host 'switch' -ForegroundColor Magenta -NoNewline
			write-host ']' -ForegroundColor DarkGray -NoNewline
			write-host "`$$value" -ForegroundColor Red -NoNewline
			write-host ' = ' -ForegroundColor Cyan -NoNewline
			write-host '$false' -ForegroundColor DarkYellow -NoNewline
			if ($comment) {
				if (!$last) {
					write-host ',' -ForegroundColor Gray -NoNewline
				}
				write-host " `e[3m# $comment`e[m" -ForegroundColor DarkGray
			}
			else {
				if (!$last) {
					write-host ',' -ForegroundColor Gray
				}
			}
		}

		write-host ""
		writeArray "params"
		writeArray "validParams"
		writeArray "helpParams"
		writeArray "excludeParams"
		writeSwitch "values" "requires params"
		writeSwitch "query" "requires validParams"
		writeSwitch "local" "requires validParams"
		writeSwitch "exlude" "requires excludeParams"
		writeSwitch "help" "requires helpParams (or default is used)"
		writeSwitch "about" "about this module" -last
		write-host ""
	}
	else {
		$foundParams = @()
		
		# get query params (to be sent to q) or local params
		if ($params) {
			if ($query -or $local) {
				if ($validParams) {
					foreach ($param in $params) {
						if(!([string]::IsNullOrEmpty($param))) {
							if ($query) {
								$validNames = @()
								foreach ($vp in $validParams) {
									if ($vp.category) {
										$validNames += $vp.names
									}
									else {
										$validNames += $vp
									}
								}
		
								if (!($param -in $validNames.name -or $param -in $validNames.short)) {
									if (!($param -in $foundParams)) {
										$foundParams += $param
									}
								}
							}
							elseif ($local) {
								foreach ($vp in $validParams) {
									if ($vp.category) {
										if ($param -in $vp.names.name -or $param -in $vp.names.short) {
											if (!($param -in $foundParams)) {
												$foundParams += $param
											}
										}
									}
									else {
										if ($param -in $vp.name -or $param -in $vp.short) {
											if (!($param -in $foundParams)) {
												$foundParams += $param
											}
										}
									}
								}
							}
						}
					}
				}
			}
			# get help search params (i.e. everything except "help" parameters)
			elseif ($help -or $exclude) {
				$validNames = @()
				if ($help) {
					if (!$helpParams) { $helpParams = Help-Params }
					$excludeParams = $helpParams
				}
	
				foreach ($ep in $excludeParams) {
					if ($ep.category) {
						$validNames += $ep.names
					}
					else {
						$validNames += $ep
					}
				}
	
				foreach ($param in $params) {
					if(!([string]::IsNullOrEmpty($param))) {
						if (!($param -in $validNames.name -or $validNames.short)) {
							if (!($param -in $foundParams)) {
								$foundParams += $param
							}
						}
					}
				}
			}
			# get values or params
			else {
				$foundValues = @()
				$wordPattern = "^[A-Za-zА-Яа-я]+"
				$dashPattern = "^-[A-Za-zА-Яа-я]+"
				$doubleDashPattern = "^--[A-Za-zА-Яа-я]+"
	
				foreach ($param in $params) {
					if(!([string]::IsNullOrEmpty($param))) {
						if ($param -match $doubleDashPattern) {
							$foundParams += $param
						}
						elseif ($param -match $dashPattern) {
							$letters = $param.split("-")[1]
							for ($i = 0; $i -lt $letters.length; $i++) {
								$letter = $letters[$i]
								if ($letter -match $wordPattern) {
									$param = "-$letter"
									if (!($param -in $foundParams)) {
										$foundParams += $param
									}
								}
							}
						}
						else {
							$foundValues += $param
						}
					}
				}
				
				if ($values) {
					$foundParams = $foundValues
				}
			}
		}
		return $foundParams
	}
}
