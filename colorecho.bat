@echo off
setlocal disableDelayedExpansion
set q=^"
call :printit %1 %2
goto :eof


:printit
setlocal enableDelayedExpansion


:colorprint
setlocal
set "s=%~2"
call :colorprintvar %1 s %3
goto :eof


:colorprintvar
if not defined DEL call :initcolorprint
setlocal enableDelayedExpansion
pushd .
':
cd \
set "s=!%~2!"
:: The single blank line within the following IN() clause is critical - DO NOT REMOVE
for %%n in (^"^

^") do (
  set "s=!s:\=%%~n\%%~n!"
  set "s=!s:/=%%~n/%%~n!"
  set "s=!s::=%%~n:%%~n!"
)
for /f delims^=^ eol^= %%s in ("!s!") do (
  if "!" equ "" setlocal disableDelayedExpansion
  if %%s==\ (
    findstr /a:%~1 "." "\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%"
  ) else if %%s==/ (
    findstr /a:%~1 "." "/.\'" nul
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%"
  ) else (
    >colorprint.txt (echo %%s\..\')
    findstr /a:%~1 /f:colorprint.txt "."
    <nul set /p "=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
  )
)
if /i "%~3"=="/n" echo(
popd
goto :eof


:initcolorprint
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "DEL=%%A %%A"
<nul >"%temp%\'" set /p "=."
subst ': "%temp%" >nul
goto :eof


:cleanupcolorprint
2>nul del "%temp%\'"
2>nul del "%temp%\colorprint.txt"
>nul subst ': /d
goto :eof