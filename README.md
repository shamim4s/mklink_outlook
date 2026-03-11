# Outlook OST Backup & Symlink Script

This repository contains a **Windows batch script** to move your Outlook `.ost` files from the default C: drive location to a backup location on another drive (e.g., D: or F:) and create symbolic links so that Outlook still detects them at the original path.  

This helps free up space on your system drive while keeping Outlook fully functional.

---

## Script Overview

The script:

1. Defines the **Outlook folder** (`outlookLocation`) where Outlook normally stores `.ost` files.
2. Defines the **backup location** (`storeLocation`) where the `.ost` files will actually reside.
3. Lists the `.ost` files (emails) to process.
4. Loops through each file:
   - Asks **Yes/No confirmation** before processing.
   - Moves the `.ost` file to the backup location.
   - Creates a **symbolic link** in the original Outlook folder pointing to the new backup location.
5. Keeps Outlook working as if the files were still in the original folder.

---

## Configuration

At the top of the `.bat` file, configure the following variables:

``` bat
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
        echo !target!  ->  !sourcefile!

        mklink "!outlookLocation!" "!storelocation!"
    )

)

echo.
echo All done.
pause
``` 
