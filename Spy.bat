@echo off
echo OS Details: > spy.txt
echo. >>spy.txt

systeminfo | findstr /c:"OS Name" >> spy.txt
systeminfo | findstr /b /c:"OS Version" >> spy.txt
systeminfo | findstr /c:"Time Zone" >> spy.txt
systeminfo | findstr /c:"System Type" >> spy.txt

echo. >>spy.txt
echo. >>spy.txt
echo. >>spy.txt
echo Hardware Details: >>spy.txt
echo. >>spy.txt

wmic baseboard get product,Manufacturer >> spy.txt
systeminfo | findstr /b /c:"BIOS Version" >> spy.txt
wmic diskdrive get name,size,serialnumber >> spy.txt
wmic nic get Name,Speed >> spy.txt
wmic cdrom where mediatype!='unknown' get description,serialnumber >> spy.txt
wmic cpu get name, numberofcores >> spy.txt
wmic MEMORYCHIP get BankLabel, capacity,typeDetail >> spy.txt
wmic path win32_VideoController get name,VideoMemoryType,AdapterRam >> spy.txt

