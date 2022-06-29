param(
	[switch]$empty = $false
)

if($empty) {
	& Clear-RecycleBin -Force
}
else {
	& explorer shell:RecycleBinFolder
}
