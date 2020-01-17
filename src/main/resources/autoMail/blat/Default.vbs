dim WSHshellA
set WSHshellA = wscript.createobject("wscript.shell")
gym=Wscript.Arguments(0)
default=Wscript.Arguments(1)
path=Wscript.Arguments(2)
'wscript.echo default
iReturn=WSHshellA.run ("cmd /c "+path+"Default.bat "+gym+" "+default+" "+path,0,TRUE) 

