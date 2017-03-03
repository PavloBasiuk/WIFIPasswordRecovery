@echo off
setlocal EnableDelayedExpansion

:main
    title WiFi Password recovery
   
    echo Harvesting all known passwords

    :: List Profiles
	
    call :get-profiles r

    echo.
    pause

    goto :eof

	

::
:: Get all network profiles (comma separated) into the result result-variable
:get-profiles <1=result-variable>
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
	
