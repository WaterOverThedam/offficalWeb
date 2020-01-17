@echo off
cd /d %~dp0 
:main


set MAIL_FOLDER=E:\Data\autoMail\maillist
set EXECUTE_HOME=E:\Data\autoMail
set TIMEOUT=30
 
:::下载
::echo %~dp0



:::执行
set flag=0
dir /b  %MAIL_FOLDER%|findstr .* >nul && set flag=1
if %flag%==0  (echo "没有可发邮件！"&goto :end)
 

:::::::::::::发邮件:::::::::::::::
setlocal enabledelayedexpansion
echo "扫描邮件..."
for /f "tokens=1,2,3,4* delims=#" %%a in ('dir/a-d /b /oe %MAIL_FOLDER%') do (
 call mailing %%a %%b %%a#%%b#%%c#%%d
 del /f /a/q  %MAIL_FOLDER%\%%a#%%b#%%c#%%d
)

:end

