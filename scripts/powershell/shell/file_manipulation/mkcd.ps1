param ( $dir )

if(!(Test-Path $dir)) {
	New-Item -Path $dir -ItemType "directory" | Out-Null
	Set-Location $dir
}
else {
	Print-Error "$dir already exists"
}
