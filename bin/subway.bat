@echo off

:: Config
set window_gap=30
set split_ratio=0.5
set ignored_patterns=
set subway_dir="C:\Program Files (x86)\kattrali\subway"

set command_path="%subway_dir%\subwayc.exe"
set daemon_path="%subway_dir%\subwayd.exe"

:: Start subwayd
start "subway daemon" "%daemon_path%"
:: brief delay to allow it to boot before firing config commands
timeout 2

:: Set preferred spacing between windows
"%command_path%" config window_gap %window_gap%"
"%command_path%" config split_ratio %split_ratio%"

:: Prevent particular windows from being tiled based on title
(for %%p in (%ignored_patterns%) do (
    "%command_path%" rule_add ignore_title_match "%%p"
))
