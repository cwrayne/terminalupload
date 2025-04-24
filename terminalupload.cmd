@echo off
REM --- terminalupload.cmd ---
REM Wrapper script to execute terminalupload.ps1 with PowerShell

REM Find the directory where this batch file is located
FOR /F "tokens=*" %%i IN ('where terminalupload.cmd') DO SET "CMD_PATH=%%i"
FOR %%i IN ("%CMD_PATH%") DO SET "SCRIPT_DIR=%%~dpi"

REM Execute PowerShell with ExecutionPolicy Bypass and pass all arguments (%*)
powershell.exe -ExecutionPolicy Bypass -File "%SCRIPT_DIR%terminalupload.ps1" %*

REM Exit with the same error level as PowerShell
exit /b %errorlevel%
