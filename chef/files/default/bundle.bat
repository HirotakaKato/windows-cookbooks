@ECHO OFF
IF NOT "%~f0" == "~f0" GOTO :WinNT
@"%~dp0..\embedded\bin\ruby.exe" "c:/opscode/chef/embedded/bin/bundle" %1 %2 %3 %4 %5 %6 %7 %8 %9
GOTO :EOF
:WinNT
@"%~dp0..\embedded\bin\ruby.exe" "%~dpn0" %*
