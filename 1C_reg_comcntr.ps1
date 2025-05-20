#regsvr32.exe "C:\Program Files (x86)\1cv8\8.3.25.1546\bin\comcntr.dll"

$ver = '8.3.25.1546'
$comp = 'PC-069'

function comcntr {
	if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$ver") {
		Write-Host $d $comp - есть x86 версия! -ForegroundColor Green
		Write-Host $d $comp - Регистрирую x86 версию comcntr.dll! -ForegroundColor Green
		& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s C:\Windows\System32\regsvr32.exe "C:\Program Files (x86)\1cv8\$ver\bin\comcntr.dll" 2>> $PSScriptRoot\1C_reg_comcntr.PsExec.log
		"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
	}
	else {
		if (Test-Path "\\$comp\c$\Program Files\1cv8\$ver") {
			Write-Host $d $comp - есть x64 версия! -ForegroundColor Green
			Write-Host $d $comp - Регистрирую x64 версию comcntr.dll! -ForegroundColor Green
			& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s C:\Windows\System32\regsvr32.exe "C:\Program Files\1cv8\$ver\bin\comcntr.dll"  2>> $PSScriptRoot\1C_reg_comcntr.PsExec.log
			"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
		}
	}
}

if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	write-host У пользователь запустившего скрипт есть права Administrator
	$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
	comcntr
}
else {
	write-host 
	write-host Нет прав Administrator
	write-host 
	write-host Запустите командный файл от имени Администратора.
	write-host 
	write-host Для выхода нажмите Enter ...
	Read-Host
}
