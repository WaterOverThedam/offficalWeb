@echo off
cd /d %~dp0 
:main


set MAIL_FOLDER=E:\Data\autoMail(MsSql)\maillist
set EXECUTE_HOME=E:\Data\autoMail(MsSql)
set TIMEOUT=30
 
:::����
::echo %~dp0

call getInfo


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
if  exist content.txt del /f /a/q content.txt 
if  exist update.sql del /f /a/q update.sql
:end

timeout /t %TIMEOUT% 
goto :main