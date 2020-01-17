dim WSHshellA
set WSHshellA = wscript.createobject("wscript.shell")

path= createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path+"\"
gym="500035"
default="192.168.1.1"
origin="192.168.1.1"
'wscript.echo "cmd /K  "+path+"EmailUs.bat "+gym+" "+default+" "+path
iReturn=WSHshellA.run ("cmd /k   "+path+"EmailUs.bat "+gym+" "+default+" "+path+" "+origin,0,TRUE) 
