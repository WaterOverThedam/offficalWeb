
'CMD��ǰ·��

test = createobject("Scripting.FileSystemObject").GetFolder(".").Path
Wscript.echo test

wscript.echo createobject("wscript.shell").currentdirectory

 

'��ǰVBS·��
test = createobject("Scripting.FileSystemObject").GetFile(Wscript.ScriptFullName).ParentFolder.Path+"\"
Wscript.echo test

strPath = Wscript.ScriptFullName
Wscript.echo strPath






