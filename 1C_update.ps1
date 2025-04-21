Import-Module activedirectory

$old_ver = '8.3.24.1586'
$new_ver = '8.3.25.1546'
$new_ver_64 = '8.3.25.1546_64'
$listFilePath = "$PSScriptRoot\list.txt"

function 1C_update {
	if ($comp.StartsWith("PC")) {
		if (Test-Connection -count 1 $comp -Quiet) {
			if (Test-Path "\\$comp\c$\Program Files (x86)") {
				if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$old_ver") {
					Write-Host $comp - есть старая x86 версия! -ForegroundColor Green
					$comp + ' - есть старая x86 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
					if (Test-Path "\\$comp\c$\Program Files (x86)\1cv8\$new_ver") {
						Write-Host $comp - есть новая x86 версия! -ForegroundColor Green
						$comp + ' - есть новая x86 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
					}
					else {
						Write-Host $comp - Устанавливаю новую x86 версию! -ForegroundColor Green
						$comp + ' - устанавливаю новую x86 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						#& "$PSScriptRoot\PsExec.exe" '-s' '-d' '-n' '60' "\\$comp" "\\srvv-02\NETLOGON\$new_ver\setup.exe" '/S' '/NOW' 2>> "$PSScriptRoot\psexec.log"
						& $PSScriptRoot\PsExec.exe \\$comp -d -n 60 -s \\srvv-02\NETLOGON\$new_ver\setup.exe /S /NOW 2>> $PSScriptRoot\psexec.log
						"`n`n===========`n===========" | Out-File "$PSScriptRoot\psexec.log" -Append
					}
				}
				else {
					if (Test-Path "\\$comp\c$\Program Files\1cv8\$old_ver") {
						Write-Host $comp - есть старая x64 версия! -ForegroundColor Green
						$comp + ' - есть старая x64 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						if (Test-Path "\\$comp\c$\Program Files\1cv8\$new_ver") {
							Write-Host $comp - есть новая x64 версия! -ForegroundColor Green
							$comp + ' - есть новая x64 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
						}
						else {
							Write-Host $comp - устанавливаю новую x64 версию! -ForegroundColor Green
							$comp + ' - устанавливаю новую x64 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
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
					Write-Host $comp - есть старая x86 версия! -ForegroundColor Green
					$comp + ' - есть старая x86 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
					if (Test-Path "\\$comp\c$\Program Files\1cv8\$new_ver") {
						Write-Host $comp - есть новая x86 версия! -ForegroundColor Green
						$comp + ' - есть новая x86 версия!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
					}
					else {
						Write-Host $comp - устанавливаю новую x86 версию! -ForegroundColor Green
						$comp + ' - устанавливаю новую x86 версию!' | Out-File "$PSScriptRoot\temp.log" -Enc default -Append
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


if (Test-Path "$PSScriptRoot\comps_down.txt") {

	Rename-Item -Path "$PSScriptRoot\comps_down.txt" -NewName "$PSScriptRoot\comps_down_tmp.txt"

	Get-Content "$PSScriptRoot\comps_down_tmp.txt" | ForEach-Object{
		$comp = $_.trim()

		1C_update
	}

	Remove-Item "$PSScriptRoot\comps_down_tmp.txt"

}
else {

	Get-ADComputer -Filter {Name -like "pc-*" -or Name -like "pce*" -or Name -like "pck*" -or Name -like "pcs*"} | Sort Name | FT Name | Out-File $listFilePath -Enc default

	Get-Content $listFilePath | ForEach-Object{
		$comp = $_.trim()

		1C_update
	}
}
























