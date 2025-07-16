---
-- BACKUP TABLES
---


-- PRODUCTS

-- Copy tables structure and add cols
CREATE TABLE products_deleted AS SELECT * FROM products WHERE 1=0;
ALTER TABLE products_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE products_deleted ADD deleted_by NUMBER;


-- SHIPMENTS

-- Copy tables structure and add cols
CREATE TABLE shipments_deleted AS SELECT * FROM shipments WHERE 1=0;
ALTER TABLE shipments_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE shipments_deleted ADD deleted_by NUMBER;
