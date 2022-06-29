#add and remove canadian language pack so the keyboard doesn't keep being added ffs

$LanguageList = Get-WinUserLanguageList

$LanguageList.Add("en-CA")
Set-WinUserLanguageList $LanguageList -Force

$LanguageList.Remove(($LanguageList | Where-Object LanguageTag -like 'en-CA'))
Set-WinUserLanguageList $LanguageList -Force
