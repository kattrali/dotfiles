@echo off
%HOMEDRIVE%
cd %HOMEPATH%
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
