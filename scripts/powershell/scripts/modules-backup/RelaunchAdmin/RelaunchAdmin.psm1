function Relaunch-Admin {
	try {
		Start-Process -Verb RunAs (Get-Process -Id $PID).Path
	}
	catch {
		write-host "cancelled" -ForegroundColor Red
	}
}