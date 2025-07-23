@echo off
setlocal

sqlplus / as sysdba @"C:\oracle-online-shop-db\clone_pdb.sql"
