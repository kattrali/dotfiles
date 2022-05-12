@echo off

set hotkey_dir=C:\Program Files (x86)\kattrali\hotkeyd
set daemon_path=%hotkey_dir%\hotkeyd.exe
set config_path=%HOMEPATH%\_hotkeydrc

:: Start hotkeyd
start "hotkey daemon" "%daemon_path%" "%config_path%"
