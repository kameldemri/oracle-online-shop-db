GRANT READ, WRITE ON DIRECTORY full_cdb_exp_dir TO SYSTEM;

ALTER SESSION SET CONTAINER=ONLINE_SHOP_PDB;

-- DEVELOPER roles grants
GRANT CONNECT TO "DEVELOPER";
GRANT RESOURCE TO "DEVELOPER";
GRANT CREATE TABLE TO "DEVELOPER";
GRANT CREATE VIEW TO "DEVELOPER";
GRANT CREATE TYPE TO "DEVELOPER";
GRANT CREATE SEQUENCE TO "DEVELOPER";
GRANT CREATE PROCEDURE TO "DEVELOPER";
GRANT CREATE TRIGGER TO "DEVELOPER";
GRANT CREATE SYNONYM TO "DEVELOPER";
GRANT CREATE PUBLIC SYNONYM TO "DEVELOPER";

-- Directories grants
GRANT READ, WRITE ON DIRECTORY full_pdb_exp_dir TO SYSTEM;
GRANT READ, WRITE ON DIRECTORY schema_exp_dir   TO SUPER_ADMIN;
GRANT READ, WRITE ON DIRECTORY schema_exp_dir   TO SHOP_DEV;
GRANT READ, WRITE ON DIRECTORY ts_exp_dir       TO SUPER_ADMIN;
GRANT READ, WRITE ON DIRECTORY ts_exp_dir       TO SHOP_DEV;
GRANT READ, WRITE ON DIRECTORY table_exp_dir    TO SUPER_ADMIN;
GRANT READ, WRITE ON DIRECTORY table_exp_dir    TO SHOP_DEV;

-- Data Pump
GRANT DATAPUMP_EXP_FULL_DATABASE TO SUPER_ADMIN;

-- Grant DEVELOPER Role to SHOP_DEV
GRANT "DEVELOPER" TO "SHOP_DEV";
