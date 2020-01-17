 

:::::::::::::: 参数设置::::::::::::::

set from=57581600@qq.com

set user=57581600

set pass=Wy466513

set to=wu.yong@thelittlegym.com.cn

set subj=%1_TracetResut

set mail=%1_TracetResut.txt

set attach=%1_TracetResut.txt

set server=smtp.qq.com

set debug=-debug -log blat.log -timestamp

::::::::::::::::: 运行blat :::::::::::::::::

blat %mail% -to %to% -base64 -charset Gb2312 -subject %subj%  -server %server% -f %from% -u %user% -pw %pass% -attach %attach% %debug%
