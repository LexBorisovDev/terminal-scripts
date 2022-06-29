function Zip-File {
	$files = Get-Params $MyInvocation.UnboundArguments -values
	$childItems = Get-ChildItem -Name
	
	if($files) {
		foreach($file in $files) {
			$compressFile = ""
			for($i = 0; $i -lt $file.length; $i++) {
				if(!($file[$i] -match "[\.\\]")) {
					$compressFile += $file[$i]
				}
			}
			
			if($childItems -and ($compressFile -in $childItems)) {
				$compressFile += ".zip"
				Compress-Archive -Path "$file" -DestinationPath "$compressFile" -Update
			}
			else {
				write-host "$compressFile is not in current directory" -ForegroundColor Red
			}
		}
	}
	else {
		write-host "No files provided" -ForegroundColor Red
	}
}

function Unzip-File {
	param(
		[switch]$force = $false
	)
	
	$files = Get-Params $MyInvocation.UnboundArguments -values
	
	if(!$files) {
		$files = Get-ChildItem -Name
	}

	if($files) {
		$allFiles = Get-ChildItem -Name
		
		foreach($file in $files) {
			$unzipped = $file | Convert-String -Example "file.zip=file"
			
			if($file -match "\.zip$") {
				if(!($unzipped -in $allFiles)) {
					Expand-Archive $file -Force
				}
				else {
					write-host "$unzipped already exists" -ForegroundColor Red
				}
				
				if($force) {
					Remove-Item $file
				}
				else {
					write-host "Delete ${file}? " -ForegroundColor DarkYellow -NoNewline
					write-host "(NO to keep) " -ForegroundColor DarkGray -NoNewline
					
					$acceptedAnswers = @("no", "n")
					if(!(Get-Answer $acceptedAnswers)) {
						Remove-Item $file
					}
				}
			}
		}
	}
	else {
		write-host "No files found" -ForegroundColor Red
	}
}
