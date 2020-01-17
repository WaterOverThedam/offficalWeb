dim WSHshellA
set WSHshellA = wscript.createobject("wscript.shell")
gym=Wscript.Arguments(0)
path=Wscript.Arguments(1)
iReturn=WSHshellA.run ("cmd /c "+path+"Google.bat "+gym+" "+path,0,TRUE) 


 
