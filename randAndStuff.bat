@echo off
rem Made by Ethan Lebowitz
title Ethan's Awesome Randomizer
:setup
cls
color a
setlocal enabledelayedexpansion
set vidx=0
for /F "tokens=*" %%a in (lists/names.txt) do (
    SET /A vidx=!vidx! + 1
    set group!vidx!=%%a
)
echo 1. %group1%
echo 2. %group2%
echo 3. %group3%
echo 4. %group4%
echo 5. %group5%
echo 6. %group6%
echo 7. %group7%
echo 8. %group8%
:select
set /p switch="select group: "
if "%switch%"=="rename" goto 4
if "%switch%"=="mix" goto 5
if not %switch% LEQ 8 (
echo "%switch%" is not a valid number.
goto select
)
if not %switch% GEQ 1 (
echo "%switch%" is not a valid number.
goto select
)
set vidx=0
set snum=0
for /F "tokens=*" %%A in (lists/slist%switch%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%A
	set lstudent!vidx!=0
	set /a snum+=1
)
:1
set /p lims="limits: "
if "%lims%"=="i" goto 3
if "%lims%"=="pair" (
	set /a pairnum = 0
	set /a lims=1
	goto pair
)
if not %lims% GEQ 1 (
echo "%lims%" is not a valid limit.
goto 1
)
goto 2 
:2
set infalstop=1
set /a rs = %random% %% snum + 1
set lstudent=!lstudent%rs%!
if "%lstudent%" LEQ "%lims%" set /a lstudent%rs%+=1
if not !lstudent%rs%! LEQ %lims% ( goto 2 ) else ( echo !student%rs%! ) 
pause
for /l %%x in (1, 1, %snum%) do if !lstudent%%x! GEQ %lims% set /a infalstop+=1
if %infalstop%==%snum% goto 6
goto 2
:3
set /a rs = %random% %% snum + 1
setlocal enabledelayedexpansion
echo !student%rs%!
endlocal
pause
goto 3
:4
echo Just press enter if you want to keep it the same.
set /p ra="rename group 1: "
set /p rb="rename group 2: "
set /p rc="rename group 3: "
set /p rd="rename group 4: "
set /p re="rename group 5: "
set /p rf="rename group 6: "
set /p rg="rename group 7: "
set /p rh="rename group 8: "
if "%ra%"=="" ( echo %group1%>lists/names.txt ) else ( echo %ra%>lists/names.txt) 
if "%rb%"=="" ( echo %group2%>>lists/names.txt ) else ( echo %rb%>>lists/names.txt) 
if "%rc%"=="" ( echo %group3%>>lists/names.txt ) else ( echo %rc%>>lists/names.txt) 
if "%rd%"=="" ( echo %group4%>>lists/names.txt ) else ( echo %rd%>>lists/names.txt) 
if "%re%"=="" ( echo %group5%>>lists/names.txt ) else ( echo %re%>>lists/names.txt) 
if "%rf%"=="" ( echo %group6%>>lists/names.txt ) else ( echo %rf%>>lists/names.txt) 
if "%rg%"=="" ( echo %group7%>>lists/names.txt ) else ( echo %rg%>>lists/names.txt) 
if "%rh%"=="" ( echo %group8%>>lists/names.txt ) else ( echo %rh%>>lists/names.txt) 
goto setup
:5
set /p mixamm="how many will you mix together?(up to 6) "
set /p mix1="first group: "
set /p mix2="second group: "
if not %mixamm% GEQ 3 ( goto 5a ) else ( set /p mix3="third group: " )
if not %mixamm% GEQ 4 ( goto 5a ) else ( set /p mix4="fourth group: " )
if not %mixamm% GEQ 5 ( goto 5a ) else ( set /p mix5="fourth group: " )
if not %mixamm% GEQ 6 ( goto 5a ) else ( set /p mix6="fourth group: " )
:5a
setlocal enabledelayedexpansion
set vidx=0
set snum=0
for /F "tokens=*" %%B in (lists/slist%mix1%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%B
	set lstudent!vidx!=0
	set /a snum+=1
)
for /F "tokens=*" %%C in (lists/slist%mix2%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%C
	set lstudent!vidx!=0
	set /a snum+=1
)
if %mixamm% GEQ 3 ( for /F "tokens=*" %%D in (lists/slist%mix3%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%D
	set lstudent!vidx!=0
	set /a snum+=1
)
)
if %mixamm% GEQ 4 ( for /F "tokens=*" %%E in (lists/slist%mix4%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%E
	set lstudent!vidx!=0
	set /a snum+=1
)
)
if %mixamm% GEQ 5 ( for /F "tokens=*" %%F in (lists/slist%mix5%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%F
	set lstudent!vidx!=0
	set /a snum+=1
)
)
if %mixamm%==6 ( for /F "tokens=*" %%G in (lists/slist%mix6%.txt) do (
    SET /A vidx=!vidx! + 1
    set student!vidx!=%%G
	set lstudent!vidx!=0
	set /a snum+=1
)
)
goto 1
:6
set /a rs = %random% %% snum + 1
set lstudent=!lstudent%rs%!
if "%lstudent%" LEQ "%lims%" set /a lstudent%rs%+=1
echo !student%rs%! 
pause
goto setup
:pair
set /p filename="file name: "
break>%filename%.txt
set /a realpairnum=1
goto pairfile
:pairfile
set /a rsa = %random% %% snum + 1
set /a rsb = %random% %% snum + 1
if %rsa%==%rsb% goto pairfile
setlocal enabledelayedexpansion
if !lstudent%rsa%! GEQ 1 ( 
endlocal
goto pairfile
)
if !lstudent%rsb%! GEQ 1 ( 
endlocal
goto pairfile
) 
echo ---------------------  pair %realpairnum%  --------------------->>%filename%.txt
echo !student%rsa%!>>%filename%.txt
echo !student%rsb%!>>%filename%.txt
endlocal
set /a realpairnum+=1
set /a pairnum+=2
set /a lstudent%rsa%+=1
set /a lstudent%rsb%+=1
set /a checkout=pairnum+1
if %checkout%==%snum% goto last
if %pairnum%==%snum% (
echo ----------------------------------------------------->>%filename%.txt
echo complete
pause
goto setup
)
if not %pairnum% GEQ %snum% ( goto pairfile )
:last
setlocal enabledelayedexpansion
set /a rsc=%random% %% snum + 1
set lstudent=!lstudent%rsc%!
set outlier=!student%rsc%!
if not "!lstudent%rsc%!" GEQ "%lims%" (
echo %outlier%>> %filename%.txt
set /a lstudent%rs%+=1
set /a pairnum+=1
)
if "!lstudent%rsc%!" GEQ "%lims%" (
endlocal
goto last
)
endlocal
echo ----------------------------------------------------->>%filename%.txt
echo complete
pause
goto setup