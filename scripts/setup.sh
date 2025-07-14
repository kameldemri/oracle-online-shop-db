#!/bin/bash

SYS_CONN="sys/kamel@localhost:1521/xe as sysdba"
DEV_USER="SHOP_DEV"
DEV_PASS="kamel"
PDB_NAME="ONLINE_SHOP_PDB"
DEV_CONN="$DEV_USER/$DEV_PASS@localhost:1521/$PDB_NAME"

echo "Starting DB setup..."

echo "Connecting as SYSDBA to perform actions..."
sqlplus "$SYS_CONN" <<EOF
@../dba/create_pdb.sql
@../dba/roles_users.sql
@../dba/grants.sql
EXIT;
EOF

echo "Connecting as $DEV_USER..."

sqlplus -s "$DEV_CONN" <<EOF
@../schema/ddl/tables/lookup_tables.sql
@../schema/dml/lookup_data.sql
@../schema/ddl/tables/core_tables.sql
@../schema/ddl/tables/backup_tables.sql
@../schema/ddl/sequences/sequences.sql
@../schema/ddl/views/views.sql
@../schema/plsql/triggers/triggers.sql
@../schema/plsql/procedures/generate_users.sql
@../schema/plsql/procedures/generate_products.sql
@../schema/plsql/procedures/generate_shipments.sql
@../schema/plsql/procedures/generate_order_items.sql
@../schema/plsql/procedures/generate_orders.sql
@../schema/plsql/procedures/generate_cities.sql
@../schema/plsql/procedures/generate_addresses.sql
@../schema/ddl/views/views.sql
@../schema/ddl/public_synonyms/public_synonyms.sql
@../schema/ddl/indexes/indexes.sql
@../schema/plsql/procedures/seed.sql
EXIT;
EOF

echo "script executed successfully!"
