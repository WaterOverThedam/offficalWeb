@echo off
cd /d %~dp0 
:main


set MAIL_FOLDER=D:\website\sharePoint\autoMail\maillist
set EXECUTE_HOME=D:\website\sharePoint\autoMail
set TIMEOUT=30
 
:::下载
::echo %~dp0
::call getInfo


:::执行
set flag=0
dir /b  %MAIL_FOLDER%|findstr .* >nul && set flag=1
if %flag%==0  (echo "没有可发邮件！"&goto :end)
 

:::::::::::::发邮件:::::::::::::::
setlocal enabledelayedexpansion
echo "扫描邮件..."
for /f "tokens=1,2,3,4* delims=#" %%a in ('dir/a-d /b /oe %MAIL_FOLDER%') do (
 echo mailing %%a %%b %%a#%%b#%%c#%%d
 if %%d==1.html ( 
osql  -S"localhost" -U "sq_xxlj2013" -P "chinaxxlj!!@@##" -d"TLGDB" -Q"update dbo.TLG_FreeAppointment set MailStatus=1 where id='%%c'"
 )else ( 
osql  -S"localhost" -U "sq_xxlj2013" -P "chinaxxlj!!@@##" -d"TLGDB" -Q"update TLG_AffiliateInfo set MailStatus=1 where id='%%c'"
 )
del /f /a/q %MAIL_FOLDER%\%%a#%%b#%%c#%%d
)

:end

timeout /t %TIMEOUT% 
goto :main