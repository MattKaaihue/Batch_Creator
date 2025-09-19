@ECHO OFF & TITLE %~N0 & COLOR 0A & CLS
::-------------------------------::
::SETLOCAL EnableDelayedExpansion
::CALL :AdminCheck
::-------------------------------::




:BeginBatch

:CreateDateAndTimeAppend
	:CollectDate
	FOR /F "tokens=2" %%D IN ('DATE /T') DO SET $$Date=%%D
	FOR /F "tokens=1 delims=/" %%D IN ("%$$Date%") DO SET $$Month=%%D
	FOR /F "tokens=2 delims=/" %%D IN ("%$$Date%") DO SET $$Day=%%D
	FOR /F "tokens=3 delims=/" %%D IN ("%$$Date%") DO SET $$Year=%%D
	:CollectTime
	FOR /F "tokens=*" %%D IN ('TIME /T') DO SET $$TIME=%%D
	SET $$TIME=%$$TIME::=-%
	SET $$TIME=%$$TIME: =%
	:FormatAppend
	SET $$TimeStamp=%$$Year%%$$Month%%$$Day%[%$$TIME%]
:CreateFolderAndFile
	MD "%~dp0testing"
	findstr /v "FormatAppend CollectTime CreateFolderAndFile Date TIME findstr START EOF MD" "%~nx0" > "%~dp0testing\test_%$$TimeStamp%.bat"
	START "" "C:\Program Files\Notepad++\notepad++.exe" "%~dp0testing\test_%$$TimeStamp%.bat"
	GOTO EOF
	PAUSE^ >NUL
	EXIT /B




::------------------------------------------------------------::
::- * * * * * * * * * * *   ~TRUNC~  * * * * * * * * * * * * -::
::------------------------------------------------------------::

:AdminCheck
::--------------------------------------------------------------------::
IF EXIST "%temp%\PromptForAdmin.vbs" (DEL "%temp%\PromptForAdmin.vbs")
OPENFILES 1>NUL 2>NUL
IF %ErrorLevel%==0 (GOTO :BeginBatch)
ECHO This batch file needs to be run as an administrator.
ECHO (Please login to continue...)

ECHO:Set UAC = CreateObject^("Shell.Application"^) > "%temp%\PromptForAdmin.vbs"
ECHO:UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\PromptForAdmin.vbs"
"%TEMP%\PromptForAdmin.vbs"
EXIT
::--------------------------------------------------------------------::

:VariableTable
::----------::

::----------::

:LabelTable
::-------::

::-------::