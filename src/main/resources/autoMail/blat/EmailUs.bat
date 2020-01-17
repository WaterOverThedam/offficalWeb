@echo off

set dir=%3
cscript.exe /e:vbscript  %dir%Google.vbs  %1 %3
cscript.exe /e:vbscript  %dir%Default.vbs %1 %2 %3
:::»¹Ô­
netsh interface ip set dns "Local" static %4