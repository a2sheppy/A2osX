@echo off
title Kernel DOC generator
COLOR 2A
prompt ]
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

for /f %%a in ('copy /Z "%~f0" nul') do set "CR=%%a"

mode con:cols=80 lines=24

cls
echo                                 Apple //e

set /a c=0

if not exist "%~dp0..\.Docs" md "%~dp0..\.Docs"

set DOCFILE=%~dp0..\.Docs\KERNEL.md
set SRCDIR=%~dp0..\SYS
set FILTER=KERNEL.S*.txt
Call :SCAN

set DOCFILE=%~dp0..\.Docs\LIBTCPIP.md
set SRCDIR=%~dp0..\LIB
set FILTER=LIBTCPIP.S*.txt
Call :SCAN

set DOCFILE=%~dp0..\.Docs\LIBBLKDEV.md
set SRCDIR=%~dp0..\LIB
set FILTER=LIBBLKDEV.S*.txt
Call :SCAN

echo.
echo All done : !c! Files scanned.
echo.
echo (I know, this batch is stupid ;-)
echo.
pause
exit 0


:SCAN
(echo *** Auto generated by docgen.cmd ***  )>!DOCFILE!

echo.
echo Scanning %FILTER% Files...
echo.

for /f %%F in ('dir /b /ogn "%SRCDIR%\%FILTER%"') do (
 set FN=%%F
 set /a c+=1
 set /p "=!c! - !FN!             !CR!" <NUL
 set bInDoc=0
 for /F "tokens=*" %%L in ('type "%SRCDIR%\!FN!"') do (
  set LINE=%%L
  if defined LINE (
   set bOut=1
   if "!LINE:~0,2!" EQU "*/" (
    set bInDoc=1
    set bOut=0
    )
   if "!LINE:~0,2!" EQU "*\" (
    set bInDoc=0
    set bOut=0
    )
   if !bInDoc! EQU 1 (
    if !bOut! EQU 1 (
     if "!line:~0,4!" EQU "*   " set LINE= + !LINE:~4!
     if "!line:~0,3!" EQU "*  " set LINE=+ !LINE:~3!
     if "!line:~0,2!" EQU "* " set LINE=!LINE:~2!
	 if "!line:~0,1!" EQU "#" echo.>>!DOCFILE!
     (echo !LINE!)>>!DOCFILE!
     )
    )
   )
  )
 )