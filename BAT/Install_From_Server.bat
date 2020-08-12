@echo off
::set INSTALL_FILE={{filename}}
::set DEPLOY_LOCATION={{deploy_folder}}
set INSTALL_FILE=%1
set DEPLOY_LOCATION=%2

echo %INSTALL_FILE%
echo %DEPLOY_LOCATION%


for %%A in ("%INSTALL_FILE%") do (
	set Folder=%%~dpA
	set Name=%%~nxA
	set Ext=%%~xA
)
echo Filename is: %Name%
set NEW_FILE_PATH=%DEPLOY_LOCATION%\%Name%
echo New file path will be: %NEW_FILE_PATH%




:check_file_type
echo Checking for proper file type
if "%Ext%"==".EXE" (
	echo file type is EXE
) else if "%Ext%"==".exe" (
	echo file type is exe
) else if "%Ext%"==".MSI" (
	echo file type is MSI
) else if "%Ext%"==".msi" (
	echo file type is msi
) else (
	echo Incorrect filetype to deploy. Must be EXE or MSI. 
	echo Filetype is: "%Ext%"
	set ERRORLEV=5
	goto error_out
)




::Check Pathing
:checkPathing
echo Checking the existence of the paths
if exist %INSTALL_FILE% (
	echo %INSTALL_FILE% exists!
) else (
	echo %INSTALL_FILE% does NOT exist!!
	set ERRORLEV=1
	goto error_out
)

if exist %DEPLOY_LOCATION% (
	echo %DEPLOY_LOCATION% exists!
) else (
	echo %DEPLOY_LOCATION% does NOT exist!!
	set ERRORLEV=2
	goto error_out
)

if exist %NEW_FILE_PATH% (
	echo %NEW_FILE_PATH% already exists. It will be copied over.
) else (
	echo %NEW_FILE_PATH% does not exist. It will be created.
)
goto copy_file




:copy_file
echo copy "%INSTALL_FILE%" "%DEPLOY_LOCATION%\"
copy "%INSTALL_FILE%" "%DEPLOY_LOCATION%\"
if %ERRORLEVEL% neq 0 (
	set ERRORLEV=4
	echo COPY FAILED
	goto error_out
)

if exist %NEW_FILE_PATH% (
	echo %NEW_FILE_PATH% exists after copy!!!
) else (
	echo %NEW_FILE_PATH% does NOT exist after copy. Exiting.
	set ERRORLEV=3
	goto error_out
)




:run_installer
echo Running Installer: %NEW_FILE_PATH%
call %NEW_FILE_PATH%
if %ERRORLEVEL% neq 0 (
	set ERRORLEV=30
	echo COPY FAILED
	goto error_out
) else (
	echo Installation Succeeded!
	goto end
)




:error_out
echo There was a problem in installing %INSTALL_FILE%. Please view log, make corrections, and try again.
echo Script exited with error %ERRORLEV%
exit /B %ERRORLEV%




:end
echo Install completed
exit /B 0