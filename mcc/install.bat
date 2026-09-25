@echo off
setlocal enabledelayedexpansion

set "INSTALL_DIR=%USERPROFILE%\.mcc"
set "EXE_PATH=%INSTALL_DIR%\mcc.exe"

echo ==================================================
echo         MCC CLI LAUNCHER INSTALLER
echo ==================================================

:: Check if already installed
if exist "%EXE_PATH%" (
    echo.
    echo [!] MCC is already installed on your system at:
    echo     %EXE_PATH%
    echo.
    set /p "REINSTALL=Do you want to reinstall/update it? [y/N]: "
    if /i not "!REINSTALL!"=="y" (
        echo.
        echo Installation skipped. You can launch MCC by typing 'mcc' in CMD.
        pause
        exit /b 0
    )
)

echo.
echo Installing MCC CLI Launcher...
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Copy mcc.exe to install directory
copy /Y "%~dp0mcc.exe" "%EXE_PATH%" >nul
if %errorlevel% neq 0 (
    echo [ERROR] Failed to copy mcc.exe. Please close any running MCC instances and try again.
    pause
    exit /b 1
)

:: Add to User PATH if not already present
powershell -Command "$oldPath = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($oldPath -notlike '*%INSTALL_DIR%*') { [Environment]::SetEnvironmentVariable('Path', $oldPath + ';%INSTALL_DIR%', 'User') }"

echo.
echo [SUCCESS] MCC has been installed successfully!
echo Restart any open CMD windows, then type 'mcc' from anywhere to launch.
echo.
pause