@echo off

echo:
echo:## Finished: RESTORE and BUILD

echo: 
echo:## Starting: TESTS...
echo:
dotnet run -f net8.0 -c Release --project test/FastExpressionCompiler.TestsRunner
if %ERRORLEVEL% neq 0 goto :error

echo:
echo:## Finished: TESTS

echo:# Finished: ALL
echo:
exit /b 0

:error
echo:
echo:## :-( Failed with ERROR: %ERRORLEVEL%
echo:
exit /b %ERRORLEVEL%
