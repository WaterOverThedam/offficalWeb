@echo off
cd /d %~dp0 
:main


set MAIL_FOLDER=E:\Data\autoMail\maillist
set EXECUTE_HOME=E:\Data\autoMail
set TIMEOUT=30
 
:::����
::echo %~dp0



:::ִ��
set flag=0
dir /b  %MAIL_FOLDER%|findstr .* >nul && set flag=1
if %flag%==0  (echo "û�пɷ��ʼ���"&goto :end)
 

:::::::::::::���ʼ�:::::::::::::::
setlocal enabledelayedexpansion
echo "ɨ���ʼ�..."
for /f "tokens=1,2,3,4* delims=#" %%a in ('dir/a-d /b /oe %MAIL_FOLDER%') do (
 call mailing %%a %%b %%a#%%b#%%c#%%d
 del /f /a/q  %MAIL_FOLDER%\%%a#%%b#%%c#%%d
)

:end

