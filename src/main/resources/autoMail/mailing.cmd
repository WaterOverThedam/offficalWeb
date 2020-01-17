
:::::::::::::: 参数设置::::::::::::::


set from=website@thelittlegym.com.cn
set user=website@thelittlegym.com.cn
set pass=2hMAGiPifRsQdGvZ

::set to=wu.yong@thelittlegym.com.cn,57581600@qq.com
set to=%1
set bcc=website@thelittlegym.com.cn
set replyto=website@thelittlegym.com.cn
 
::if %2==1 (
::  set subj=老师选课申请确认
::) else if %2==2 (
::  set subj=OTS帐号开通与选课通知
::) else (
::  set subj=OTS帐号开通与选课通知
::)
set subj=%2
set mail=%3
 

set server=smtp.exmail.qq.com
set port=25
set debug=-debug -log blat.log -timestamp

::::::::::::::::: 运行blat :::::::::::::::::
echo sending....
%EXECUTE_HOME%\blat\blat %MAIL_FOLDER%\%mail% -to %to% -bcc %bcc% -base64 -charset Gb2312 -subject %subj%  -server %server% -port %port% -f %from% -replyto %replyto% -u %user% -pw %pass%  %debug% -unicode

echo %1 send success



