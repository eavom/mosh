@echo off

:: Setting up title and running the moShell
:setup
cls
title moSH
echo.
call :runmoSH
goto :eof

:: To run moShell
:runmoSH
set input=
echo.
set current_dir=%cd%
call colorecho a "(" & call colorecho b "%USERNAME%" & call colorecho a "@" &
call colorecho f "%COMPUTERNAME%" & call colorecho a ")" & echo. &
call colorecho a "%current_dir%" & call colorecho b " > "

set /p user_input=
cmd /c %user_input%
if "%user_input%" equ "" (
    goto :runmoSH
) else (
    %user_input% > nul 2>&1
    goto :runmoSH
)
goto :eof