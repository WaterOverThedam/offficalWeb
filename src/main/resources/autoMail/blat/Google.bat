:::::::8.8.4.4::::
echo  ------------8.8.4.4------------>%2%1_TracetResut.txt

netsh interface ip set dns "Local" static 8.8.4.4
tracert littlegym.wmod.llnwd.net>>%2%1_TracetResut.txt
tracert lessonplans.thelittlegym.com>>%2%1_TracetResut.txt
tracert training.thelittlegym.com>>%2%1_TracetResut.txt