@echo off
echo OS Details: > spy.txt
echo. >>spy.txt



systeminfo | findstr /c:"OS Name" >> spy.txt
systeminfo | findstr /b /c:"OS Version" >> spy.txt
systeminfo | findstr /c:"Time Zone" >> spy.txt
systeminfo | findstr /c:"System Type" >> spy.txt

echo. >>spy.txt
echo _____________________________________________________________________________________________ >>spy.txt
echo Hardware Details: >>spy.txt


wmic baseboard get product,Manufacturer /format:list >> spy.txt
systeminfo | findstr /b /c:"BIOS Version"  >> spy.txt
wmic diskdrive get name,size,serialnumber /format:list >> spy.txt
wmic nic get Name,Speed /format:list >> spy.txt
wmic cdrom where mediatype!='unknown' get description,serialnumber /format:list >> spy.txt
wmic cpu get name, numberofcores /format:list >> spy.txt
wmic MEMORYCHIP get BankLabel, capacity,typeDetail /format:list >> spy.txt
wmic path win32_VideoController get name,VideoMemoryType,AdapterRam /format:list >> spy.txt


echo. >>spy.txt
echo ______________________________________________________________________________________________ >>spy.txt
echo Users Details: >>spy.txt


echo Hostname: >> spy.txt
hostname >> spy.txt
echo Username: >> spy.txt
echo %username% >> spy.txt
echo UserProfile: >> spy.txt
echo %UserProfile% >> spy.txt

echo Browser: >> spy.txt
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Clients\StartMenuInternet" >> spy.txt

echo App: >> spy.txt
wmic /output:appspy.txt product get name,version






echo. >>spy.txt
echo ______________________________________________________________________________________________ >>spy.txt
echo Security Details: >>spy.txt

echo Antivirus: >> spy.txt
wmic /node:localhost /namespace:\\root\SecurityCenter2 path AntiVirusProduct Get DisplayName | findstr /V /B /C:displayName  >> spy.txt

echo Enable of Antivirus: >> spy.txt
net start | findstr /c:"Antivirus"  >> spy.txt



echo Firewall: >> spy.txt
wmic /node:localhost /namespace:\\root\SecurityCenter2 path FirewallProduct Get DisplayName | findstr /V /B /C:displayName >> spy.txt

echo Enable of Firewall: >> spy.txt
net start | findstr /c:"Firewall"  >> spy.txt

echo Administrator : >>spy.txt
IF %ERRORLEVEL% EQU 0 (
    ECHO YES >> spy.txt
) else (
    echo No >> spy.txt
)


echo Windows Update: >> spy.txt
net start | findstr /c:"Windows Update"  >> spy.txt

setlocal
echo UAC Status: >> spy.txt
REG QUERY HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ /v EnableLUA | findstr /c:"0x1" > temp.txt
set /p var=< temp.txt
if "%var%"=="    EnableLUA    REG_DWORD    0x1" (
    echo UAC is Enable >> spy.txt
) else (
    echo UAC is not Enable >> spy.txt
)
del temp.txt
endlocal



