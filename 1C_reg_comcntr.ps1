#regsvr32.exe "C:\Program Files (x86)\1cv8\8.3.25.1546\bin\comcntr.dll"

$ver = '8.3.25.1546'
$comp = 'PC-069'

function comcntr {
	if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$ver") {
		Write-Host $d $comp - ���� x86 ������! -ForegroundColor Green
		Write-Host $d $comp - ����������� x86 ������ comcntr.dll! -ForegroundColor Green
		& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s C:\Windows\System32\regsvr32.exe "C:\Program Files (x86)\1cv8\$ver\bin\comcntr.dll" 2>> $PSScriptRoot\1C_reg_comcntr.PsExec.log
		"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
	}
	else {
		if (Test-Path "\\$comp\c$\Program Files\1cv8\$ver") {
			Write-Host $d $comp - ���� x64 ������! -ForegroundColor Green
			Write-Host $d $comp - ����������� x64 ������ comcntr.dll! -ForegroundColor Green
			& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s C:\Windows\System32\regsvr32.exe "C:\Program Files\1cv8\$ver\bin\comcntr.dll"  2>> $PSScriptRoot\1C_reg_comcntr.PsExec.log
			"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
		}
	}
}

if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	write-host � ������������ ������������ ������ ���� ����� Administrator
	$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
	comcntr
}
else {
	write-host 
	write-host ��� ���� Administrator
	write-host 
	write-host ��������� ��������� ���� �� ����� ��������������.
	write-host 
	write-host ��� ������ ������� Enter ...
	Read-Host
}
