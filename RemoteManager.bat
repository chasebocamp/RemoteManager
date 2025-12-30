
@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
title Remote Management Program

:: -----------------------------
:: Admin privilege check
:: -----------------------------
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
    echo ERROR: This script must be run as Administrator.
    echo.
    pause
    exit /b 1
)

:: -----------------------------
:: Check PsExec availability
:: -----------------------------
where psexec >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
    echo ERROR: PsExec not found in PATH.
    echo Download it from Microsoft Sysinternals.
    echo.
    pause
    exit /b 1
)

:: -----------------------------
:: Main menu
:: -----------------------------
:menu
cls
echo Remote Management Program
echo =========================
echo 1. View Remote System Info
echo 2. Remote Process List
echo 3. Remote Services Status
echo 4. Remote Command Prompt (PsExec)
echo 5. Exit
echo.

set /p choice=Enter your choice (1-5): 

if "%choice%"=="5" exit /b 0

set /p computer=Enter remote computer name or IP: 
if "%computer%"=="" (
    echo Invalid computer name.
    timeout /t 2 >nul
    goto menu
)

:: -----------------------------
:: Menu actions
:: -----------------------------
if "%choice%"=="1" (
    systeminfo /s "%computer%"
    pause
    goto menu
)

if "%choice%"=="2" (
    tasklist /s "%computer%"
    pause
    goto menu
)

if "%choice%"=="3" (
    sc "\\%computer%" query
    pause
    goto menu
)

if "%choice%"=="4" (
    psexec "\\%computer%" cmd
    pause
    goto menu
)

echo Invalid selection.
timeout /t 2 >nul
goto menu
