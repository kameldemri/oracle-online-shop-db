@echo off
REM === CONFIGURATION ===
set ORACLE_SID=XE
set SYS_CONN=/ as sysdba
set BASE_COLD_BACKUP_DIR=C:\oracle_backups\cold
set ORACLE_BASE=C:\app\kamel\product\21c
set DATA_DIR=%ORACLE_BASE%\oradata\%ORACLE_SID%
set CONFIG_DIR=%ORACLE_BASE%\database

REM === TIMESTAMP ===
for /f %%a in ('powershell -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss"') do set DATE_TAG=%%a
set BACKUP_DIR=%BASE_COLD_BACKUP_DIR%\%DATE_TAG%

mkdir "%BASE_COLD_BACKUP_DIR%"
mkdir "%BACKUP_DIR%\datafiles"
mkdir "%BACKUP_DIR%\controlfiles"
mkdir "%BACKUP_DIR%\logfiles"
mkdir "%BACKUP_DIR%\oracle_database_folder"

REM === SHUTDOWN ===
echo Shutting down database...
(
  echo SHUTDOWN IMMEDIATE;
  echo EXIT;
) | sqlplus -s "%SYS_CONN%"

REM === COPY FILES ===
echo Copying datafiles (.DBF)...
copy /Y "%DATA_DIR%\*.DBF" "%BACKUP_DIR%\datafiles\"

echo Copying controlfiles (.CTL)...
copy /Y "%DATA_DIR%\*.CTL" "%BACKUP_DIR%\controlfiles\"

echo Copying redologs (.LOG)...
copy /Y "%DATA_DIR%\*.LOG" "%BACKUP_DIR%\logfiles\"

echo Copying Oracle config folder...
xcopy /E /I /Y "%CONFIG_DIR%" "%BACKUP_DIR%\oracle_database_folder\database"

REM === STARTUP ===
echo Starting database...
(
  echo STARTUP;
  echo EXIT;
) | sqlplus -s "%SYS_CONN%"

echo [SUCCESS] Cold backup complete at: %BACKUP_DIR%
