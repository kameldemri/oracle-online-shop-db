-- CDB
CREATE OR REPLACE DIRECTORY full_cdb_exp_dir    AS 'C:\oracle_backups\data_pump\full_cdb';
CREATE OR REPLACE DIRECTORY full_pdb_exp_dir    AS 'C:\oracle_backups\data_pump\full_pdb';

ALTER SESSION SET CONTAINER=ONLINE_SHOP_PDB;

CREATE OR REPLACE DIRECTORY schema_exp_dir      AS 'C:\oracle_backups\data_pump\schema_exports';
CREATE OR REPLACE DIRECTORY ts_exp_dir          AS 'C:\oracle_backups\data_pump\tablespaces';
CREATE OR REPLACE DIRECTORY table_exp_dir       AS 'C:\oracle_backups\data_pump\tables';
