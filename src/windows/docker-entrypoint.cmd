@echo off

setlocal
call C:\zookeeper\bin\zkEnv.cmd

if not exist %ZOOCFG% (
    echo clientPort=%ZOO_PORT% >> %ZOOCFG%
    echo dataDir=%ZOO_DATA_DIR% >> %ZOOCFG%
    echo dataLogDir=%ZOO_DATA_LOG_DIR% >> %ZOOCFG%
    echo tickTime=%ZOO_TICK_TIME% >> %ZOOCFG%
    echo initLimit=%ZOO_INIT_LIMIT% >> %ZOOCFG%
    echo syncLimit=%ZOO_SYNC_LIMIT% >> %ZOOCFG%

    echo dataDir=%ZOO_DATA_DIR% >> %ZOOCFG%
    echo dataLogDir=%ZOO_DATA_LOG_DIR% >> %ZOOCFG%

    call :addserver "%ZOO_SERVERS%"
)

if not exist %ZOO_DATA_DIR%\myid ( 
    echo %ZOO_MY_ID% > %ZOO_DATA_DIR%\myid
)

call %*
goto eof

rem http://stackoverflow.com/questions/2524928/dos-batch-iterate-through-a-delimited-string
:addserver
for /F "tokens=1*" %%a in (%1) do (
	if not "%%a" == "" echo %%a >> %ZOOCFG% 
	if not "%%b" == "" call :addserver "%%b"
)
goto eof

:eof