@echo off

IF "%1"=="" GOTO noparam
IF "%1"=="-help" GOTO help
IF NOT EXIST %1 GOTO :notexist

set "d=\.git\"
pushd "%1"
For /D %%G in (*) do (
	pushd %%~G
	echo About to pull project: %%~G & echo.
	call git pull
	echo. & echo ... done &echo.
	popd
)
popd
GOTO end

:noparam
	echo No directory supplied!
:help
	echo Usage: pull ^<directory^>
	echo Pulls all git repositories in ^<directory^>
	GOTO end

:notexist
	echo Directory "%1" does not exist!
	
	
:end