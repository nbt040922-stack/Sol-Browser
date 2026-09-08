@echo off
setlocal

set CHROMIUM_SRC=D:\ChromiumDev\src
set PATCH_DIR=%~dp0patches

echo ==========================================
echo Applying Sol Browser patches to Chromium
echo ==========================================

cd /d "%CHROMIUM_SRC%" || (
    echo ERROR: Chromium source directory not found.
    exit /b 1
)

git status --short

for %%F in ("%PATCH_DIR%\*.patch") do (
    echo.
    echo Applying %%~nxF
    git am "%%F"

    if errorlevel 1 (
        echo.
        echo ERROR: Failed to apply %%~nxF
        echo Resolve conflicts, then run:
        echo     git am --continue
        echo Or cancel with:
        echo     git am --abort
        exit /b 1
    )
)

echo.
echo ==========================================
echo All Sol Browser patches applied.
echo ==========================================

endlocal