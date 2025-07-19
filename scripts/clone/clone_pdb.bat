@echo off
setlocal

REM Optional: Create dump dir if not exists
if not exist "C:\oracle_backups\clone" (
    mkdir "C:\oracle_backups\clone"
)

REM Call the SQL file directly
sqlplus / as sysdba @"C:\Users\kamel\Desktop\oracle-online-shop-db\clone_pdb.sql"
