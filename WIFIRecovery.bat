@echo off
setlocal EnableDelayedExpansion
:main
    title WiFi Password recovery
    echo Harvesting all known passwords
    call :get-Wifi-profiles r
    pause
    goto :eof
:get-Wifi-profiles <1=result-variable>
    setlocal
    FOR /F "usebackq tokens=2 delims=:" %%a in (
        `netsh wlan show profiles ^| findstr /C:"All User Profile"`) DO (
        set val=%%a
        set val=!val:~1!
	
	FOR /F "usebackq tokens=2 delims=':'" %%k in (
		`netsh wlan show profile name^="!val!" key^=clear ^| findstr /C:"Key Content"`) do (
		set keys=%%k
	
		echo WiFi Name: [!val!] Password: [!keys:~1!]
		)
    )
    (
        endlocal
    )
    goto :eof
	
