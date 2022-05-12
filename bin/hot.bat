@echo off

set hot_dir="C:\Program Files (x86)\kattrali\hot"
set daemon_path="%hot_dir%\hot.exe"

start "hot corners" "%daemon_path%" --bottom-right "Rundll32.exe user32.dll,LockWorkStation"