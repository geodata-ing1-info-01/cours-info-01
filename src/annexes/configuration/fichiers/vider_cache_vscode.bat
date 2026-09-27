@echo off
rem Vide les caches de VS Code, sous Windows, dans l'invite de commandes.
rem   vider_cache_vscode.bat         caches de l'application
rem   vider_cache_vscode.bat --tout  et aussi l'etat des dossiers ouverts et
rem                                  les donnees des extensions Python et Jupyter
rem Ne touche ni a settings.json ni aux extensions installees.

tasklist /FI "IMAGENAME eq Code.exe" 2>nul | find /I "Code.exe" >nul
if not errorlevel 1 (
  echo VS Code est ouvert : le fermer, puis relancer ce script.
  exit /b 1
)

set "CODE=%APPDATA%\Code"
if not exist "%CODE%" (
  echo Dossier introuvable : %CODE%
  exit /b 1
)

for %%D in ("Cache" "CachedData" "CachedExtensionVSIXs" "Code Cache" "GPUCache") do call :supprimer "%%~D"

if /I "%~1"=="--tout" (
  for %%D in ("User\workspaceStorage" "User\globalStorage\ms-python.python" "User\globalStorage\ms-python.vscode-python-envs" "User\globalStorage\ms-toolsai.jupyter") do call :supprimer "%%~D"
)

echo Termine. Relancer VS Code.
exit /b 0

:supprimer
if exist "%CODE%\%~1" (
  rmdir /s /q "%CODE%\%~1"
  echo supprime : %CODE%\%~1
)
exit /b 0
