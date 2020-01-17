:begin
@echo off 



set user=sq_xxlj2013
set pwd=chinaxxlj!!@@##

bcp  "select top 14 * from TLGDB.dbo.Fun_genenate_mailText()" queryout E:\Data\autoMail(MsSql)\content.txt -c -t"||" -U "sa" -P "tlg10m$"  

if not exist content.txt (timeout /t 10 & goto :begin)
for /f "usebackq eol=m tokens=1,2,3,4,5* delims=||" %%a in (content.txt) do (
 echo %%e  > D:\website\sharePoint\autoMail\maillist\%%c#%%d#%%b#%%f.html

 if %%f==1 ( 
@echo off
echo update dbo.TLG_FreeAppointment set MailStatus=1 where id='%%b' >> E:\Data\autoMail(MsSql)\update.sql
 )else ( 
echo update TLG_AffiliateInfo set MailStatus=1 where id='%%b' >> E:\Data\autoMail(MsSql)\update.sql
 )

)

if  exist update.sql (
osql  -S"localhost" -U "sa" -P "tlg10m$" -d"TLGDB" -i update.sql
)



 