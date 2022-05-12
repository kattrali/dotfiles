@echo off
%HOMEDRIVE%
cd %HOMEPATH%
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
"C:\Program Files\Git\usr\bin\bash.exe" --login -i
