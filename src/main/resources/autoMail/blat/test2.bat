

:::::::::::::: 参数设置::::::::::::::
set from=website@thelittlegym.com.cn

set user=website

set pass=1qazxsw2

set to=wu.yong@thelittlegym.com.cn

set subj=%1_TracetResut

set mail=%1_TracetResut.txt

set attach=%1_TracetResut.txt

set server=smtp.qiye.163.com
set port=25
set debug=-debug -log blat.log -timestamp

::::::::::::::::: 运行blat :::::::::::::::::

blat %mail% -to %to% -base64 -charset Gb2312 -subject %subj%  -server %server% -port %port% -f %from% -u %user% -pw %pass% -attach %attach% %debug% -unicode
