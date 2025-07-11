#!/bin/bash

SYS_CONN="sys/kamel@localhost:1521/xe as sysdba"
DEV_USER="SHOP_DEV"
DEV_PASS="kamel"
PDB_NAME="ONLINE_SHOP_PDB"
DEV_CONN="$DEV_USER/$DEV_PASS@localhost:1521/$PDB_NAME"

echo "Starting DB setup..."

echo "Connecting as SYSDBA to perform actions..."
sqlplus "$SYS_CONN" @"../setup/create_pdb.sql"
../setup/create_pdb.sql


echo "Connecting as $DEV_USER..."

run_sql_as_dev() {
    echo "Running $1"
    sqlplus -s "$DEV_CONN" @"$1"
}

run_sql_as_dev "../ddl/tables/lookup_tables.sql"
run_sql_as_dev "../dml/lookup_data.sql"
run_sql_as_dev "../ddl/tables/core_tables.sql"
run_sql_as_dev "../ddl/tables/backup_tables.sql"
run_sql_as_dev "../ddl/sequences/sequences.sql"
run_sql_as_dev "../ddl/views/views.sql"
run_sql_as_dev "../plsql/triggers/triggers.sql"
run_sql_as_dev "../plsql/procedures/generate_users.sql"
run_sql_as_dev "../plsql/procedures/generate_products.sql"
run_sql_as_dev "../plsql/procedures/generate_shipments.sql"
