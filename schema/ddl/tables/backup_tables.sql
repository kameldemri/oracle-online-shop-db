---
-- BACKUP TABLES
---


-- PRODUCTS

-- Copy tables structure and add cols
CREATE TABLE products_deleted AS SELECT * FROM products WHERE 1=0;
ALTER TABLE products_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE products_deleted ADD deleted_by NUMBER;

CREATE OR REPLACE TRIGGER trg_backup_product
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO products_deleted 
    SELECT :OLD.*, SYSDATE, NULL;
END;


-- SHIPMENTS

-- Copy tables structure and add cols
CREATE TABLE shipments_deleted AS SELECT * FROM shipments WHERE 1=0;
ALTER TABLE shipments_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE shipments_deleted ADD deleted_by NUMBER;

CREATE OR REPLACE TRIGGER trg_backup_shipment
BEFORE DELETE ON shipments 
FOR EACH ROW
BEGIN
    INSERT INTO shipments_deleted
    SELECT :OLD.*, SYSDATE, NULL;
END;
