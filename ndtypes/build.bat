@ECHO OFF

if "%~1" == "" goto usage
if "%~2" == "" goto usage
if "%~3" == "" goto usage
if not "%~4" == "" goto usage

set executable=%1 || goto out
set arch=%2 || goto out
set install_prefix=%3 || goto out

if exist xnd_build rd /q /s xnd_build || goto out
mkdir xnd_build || goto out
cd xnd_build || goto out

"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath > vcpath.txt || goto out
set /p vcpath=<vcpath.txt || goto out
del vcpath.txt || goto out
call "%vcpath%\VC\Auxiliary\Build\vcvarsall.bat" %arch% || goto out

cmake -S ..\source\xnd -DCMAKE_BUILD_TYPE=Release ^
                       -DCMAKE_INSTALL_PREFIX=%install_prefix% ^
                       -DPython3_EXECUTABLE="%executable%" ^
                       -DMOD_NDTYPES_WITH_XNDLIB=ON || goto out

cmake --build . --config Release --target install --parallel || goto out

cd ..

:out
exit /b 0

:usage
echo "build.bat: usage: build.bat ^<python3 executable^> ^<architecture^> ^<install_prefix^>"
exit /b 1
