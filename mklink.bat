@echo off
setlocal enabledelayedexpansion

REM ===== CONFIGURATION =====
set outlookLocation=C:\Users\Admin\AppData\Local\Microsoft\Outlook
set storelocation=F:\outlook-email-backup

REM Emails / OST files
set emails=info@domain.com.ost sales@domain.com.ost

echo Source Folder : %outlookLocation%
echo Target Base   : %storelocation%
echo.

REM Loop through each OST file
for %%E in (%emails%) do (

    echo ---------------------------------
    echo File: %%E
    choice /M "Create mklink for this file?"

    if errorlevel 2 (
        echo Skipped %%E
    ) else (
        set storelocation=%storelocation%\%%E
        set outlookLocation=%outlookLocation%\%%E

        echo Creating link:
        echo !outlookLocation!  ->  !storelocation!

        mklink "!outlookLocation!" "!storelocation!"
    )

)

echo.
echo All done.
pause
