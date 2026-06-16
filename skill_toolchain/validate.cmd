@echo off
powershell.exe -NoLogo -NoProfile -File "%~dp0validate.ps1" %*
exit /b %ERRORLEVEL%
