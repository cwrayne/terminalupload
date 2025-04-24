@echo off
REM --- terminalupload.cmd ---
REM Wrapper script to execute terminalupload.ps1 with PowerShell

REM Execute PowerShell with ExecutionPolicy Bypass and pass all arguments (%*)
powershell.exe -ExecutionPolicy Bypass -File "terminalupload.ps1" %*

REM Exit with the same error level as PowerShell
exit /b %errorlevel%