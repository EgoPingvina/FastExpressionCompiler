@echo off

echo:
echo:## Starting: RESTORE and BUILD...
echo: 

dotnet clean -v:m -p:DevMode=false
dotnet build -c:Release -v:m -p:DevMode=false
if %ERRORLEVEL% neq 0 goto :error

echo:
echo:## Finished: RESTORE and BUILD

echo: 
echo:## Starting: TESTS...
echo: 

dotnet run --no-build  -f net7.0 -c Release -p:DevMode=false --project test/FastExpressionCompiler.TestsRunner/FastExpressionCompiler.TestsRunner.csproj
if %ERRORLEVEL% neq 0 goto :error

dotnet run --no-build -c Release -p:DevMode=false --project test/FastExpressionCompiler.TestsRunner.Net472/FastExpressionCompiler.TestsRunner.Net472.csproj
if %ERRORLEVEL% neq 0 goto :error
echo:
echo:## Finished: TESTS

echo: 
echo:## Starting: SOURCE PACKAGING...
echo:
call BuildScripts\NugetPack.bat
if %ERRORLEVEL% neq 0 goto :error
echo:
echo:## Finished: SOURCE PACKAGING
echo: 
echo:# Finished: ALL
echo:
exit /b 0

:error
echo:
echo:## :-( Failed with ERROR: %ERRORLEVEL%
echo:
exit /b %ERRORLEVEL%
