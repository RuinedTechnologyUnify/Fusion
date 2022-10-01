@echo off
taskkill /f /t /im java.exe >> NUL
taskkill /f /t /im git.exe >> NUL
rd /s /q ../Fusion-API >> NUL
rd /s /q ../Fusion-Server >> NUL
rd /s /q ../.gradle >> NUL
echo Complete.