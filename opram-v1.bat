@echo off
setlocal enabledelayedexpansion

for /f "tokens=3 delims= " %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v SystemRoot') do (
    set "SystemRootPath=%%a"
)
set "SystemDrive=%SystemRootPath:~0,2%"
set "PageFile=%SystemDrive%\\pagefile.sys"

for /f "tokens=2 delims==" %%A in ('"wmic computersystem get totalphysicalmemory /value"') do (
    set /a RAM_MB=%%A / 1048576
)

set /a Opt1=%RAM_MB%
set /a Opt2=%RAM_MB% + 8192
set /a Opt3=%RAM_MB% + 16384
set /a Opt4=%RAM_MB% + 32768
set /a Opt5=%RAM_MB% * 2

echo RAM: %RAM_MB% MB
echo.
echo 1 - %Opt1% MB
echo 2 - %Opt2% MB
echo 3 - %Opt3% MB
echo 4 - %Opt4% MB
echo 5 - %Opt5% MB
echo 6 - Inserisci manualmente

set /p choice=Scegli un'opzione (1-6): 

if "%choice%"=="1" set CustomSize=%Opt1%
if "%choice%"=="2" set CustomSize=%Opt2%
if "%choice%"=="3" set CustomSize=%Opt3%
if "%choice%"=="4" set CustomSize=%Opt4%
if "%choice%"=="5" set CustomSize=%Opt5%
if "%choice%"=="6" set /p CustomSize=Inserisci la dimensione in MB: 

wmic computersystem where name="%computername%" set AutomaticManagedPagefile=False
wmic pagefileset where name="%PageFile%" set InitialSize=%CustomSize%,MaximumSize=%CustomSize%

echo.
echo Le modifiche sono state applicate.
echo Riavvia il PC per renderle effettive.

pause
endlocal
