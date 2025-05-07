Import-Module activedirectory

$old_ver = '8.3.24.1586'
$new_ver = '8.3.25.1546'
$new_ver_64 = '8.3.25.1546_64'
$listFilePath = "$PSScriptRoot\list.txt"
#$not_install = "pc-051", "pc-052", "pc-069", "pc-139", "pc-098", "pc-198", "pc-262"
$not_install = Get-Content "$PSScriptRoot\not_install.txt"

#write-host $not_install

function 1C_update {
	if (-not ($comp -in $not_install)) {
		if ($comp.StartsWith("PC")) {
			if (Test-Connection -count 1 $comp -Quiet) {
				if (Test-Path "\\$comp\c$\Program Files (x86)") {
					if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$old_ver") {
						$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
						Write-Host $d $comp - есть стара€ x86 верси€! -ForegroundColor Green
						$d + ' ' + $comp + ' - есть стара€ x86 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$new_ver") {
							$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
							Write-Host $comp - есть нова€ x86 верси€! -ForegroundColor Green
							$d + ' ' + $comp + ' - есть нова€ x86 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						}
						else {
							$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
							Write-Host $d $comp - ”станавливаю новую x86 версию! -ForegroundColor Green
							$d + ' ' + $comp + ' - устанавливаю новую x86 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
							#& "$PSScriptRoot\PsExec.exe" '-s' '-d' '-n' '60' "\\$comp" "\\srvv-02\NETLOGON\$new_ver\setup.exe" '/S' '/NOW' 2>> "$PSScriptRoot\psexec.log"
							& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s \\srvv-02\NETLOGON\$new_ver\setup.exe /S /NOW 2>> $PSScriptRoot\psexec.log
							"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
						}
					}
					else {
						if (Test-Path "\\$comp\c$\Program Files\1cv8\$old_ver") {
							$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
							Write-Host $d $comp - есть стара€ x64 верси€! -ForegroundColor Green
							$d + ' ' + $comp + ' - есть стара€ x64 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
							if (Test-Path "\\$comp\c$\Program Files\1cv8\$new_ver") {
								$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
								Write-Host $d $comp - есть нова€ x64 верси€! -ForegroundColor Green
								$d + ' ' + $comp + ' - есть нова€ x64 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
							}
							else {
								$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
								Write-Host $d $comp - устанавливаю новую x64 версию! -ForegroundColor Green
								$d + ' ' + $comp + ' - устанавливаю новую x64 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
								#& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s \\srvv-01\NETLOGON\$new_ver_64\vc_redist.x64.exe /install /passive /norestart 2>> $PSScriptRoot\psexec.log
								#Start-Sleep -Seconds 10
								& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s \\srvv-01\NETLOGON\$new_ver_64\setup.exe /S 2>> $PSScriptRoot\psexec.log
								"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
							}
						}
					}
				}
				else {
					if (Test-Path "\\$comp\c$\Program Files\1cv8\$old_ver") {
						$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
						Write-Host $d $comp - есть стара€ x86 верси€! -ForegroundColor Green
						$d + ' ' + $comp + ' - есть стара€ x86 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						if (Test-Path "\\$comp\c$\Program Files\1cv8\$new_ver") {
							$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
							Write-Host $d $comp - есть нова€ x86 верси€! -ForegroundColor Green
							$d + ' ' + $comp + ' - есть нова€ x86 верси€!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						}
						else {
							$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
							Write-Host $d $comp - устанавливаю новую x86 версию! -ForegroundColor Green
							$d + ' ' + $comp + ' - устанавливаю новую x86 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
							#& "$PSScriptRoot\PsExec.exe" '-s' '-d' '-n' '60' "\\$comp" "\\srvv-02\NETLOGON\$new_ver\setup.exe" '/S' '/NOW' 2>> "$PSScriptRoot\psexec.log"
							& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s \\srvv-02\NETLOGON\$new_ver\setup.exe /S /NOW 2>> $PSScriptRoot\psexec.log
							"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
						}
					}
				}
			}
			else {
				Write-Host $comp - не доступен! -ForegroundColor Red
				$comp | Out-File $PSScriptRoot\comps_down.txt -Encoding Default -Append
			}
		}
	}
	else {
		$d = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
		Write-Host $d $comp - компьютер не дл€ установки новой версии! -ForegroundColor Red
		$d + ' ' + $comp + ' - компьютер не дл€ установки новой версии!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
		$comp | Out-File $PSScriptRoot\comps_down.txt -Encoding Default -Append
	}
}


#If(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Domain Admins")) {
if (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
	write-host ” пользователь запустившего скрипт есть права Administrator

	if (Test-Path "$PSScriptRoot\comps_down.txt") {

		Rename-Item -Path "$PSScriptRoot\comps_down.txt" -NewName "$PSScriptRoot\comps_down_tmp.txt"

		Get-Content "$PSScriptRoot\comps_down_tmp.txt" | ForEach-Object{
			$comp = $_.trim()

			1C_update
		}

		Remove-Item "$PSScriptRoot\comps_down_tmp.txt"

	} else {

		# ѕолучение имен компьютеров
		#$computers = (Get-ADComputer -Filter {Enabled -eq $True}).Name

		Get-ADComputer -Filter {Name -like "pc-*" -or Name -like "pce*" -or Name -like "pck*" -or Name -like "pcs*" -and Enabled -eq $True} | Sort Name | FT Name | Out-File $listFilePath -Enc default

		Get-Content $listFilePath | ForEach-Object{
			$comp = $_.trim()

			1C_update
		}
	}

}
Else {
	write-host 
	write-host Ќет прав Administrator
	write-host 
	write-host «апустите командный файл от имени јдминистратора.
	write-host 
	write-host ƒл€ выхода нажмите Enter ...
	Read-Host
}
