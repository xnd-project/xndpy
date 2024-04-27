@ECHO OFF

if "%~1" == "" goto usage
if "%~2" == "" goto usage
if not "%~3" == "" goto usage

set arch=%1 || goto out
set install_prefix=%2 || goto out

if exist xnd_build rd /q /s xnd_build || goto out
mkdir xnd_build || goto out
cd xnd_build || goto out

"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath > vcpath.txt || goto out
set /p vcpath=<vcpath.txt || goto out
del vcpath.txt || goto out
call "%vcpath%\VC\Auxiliary\Build\vcvarsall.bat" %arch% || goto out

cmake -S ..\source\xnd -DCMAKE_BUILD_TYPE=Release ^
                       -DCMAKE_INSTALL_PREFIX=%install_prefix% ^
                       -DLIB_XNDLIB_WITH_MOD_HEADERS=ON || goto out

cmake --build . --config Release --target install --parallel || goto out

cd ..

:out
exit /b 0

:usage
echo "build.bat: usage: build.bat ^<install_prefix^>"
exit /b 1
