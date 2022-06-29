'$localParams = Get-Params $params -validParams $validParams -local
$booleanNames = Get-BooleanNames $localParams $validParams #$helpParams
if($booleanNames) {
	foreach($bn in $booleanNames) {
		if(!(Get-Variable $bn -Value -ErrorAction SilentlyContinue)) {
			New-Variable -Name $bn -Value $true
		}
	}
}' | Set-Clipboard
