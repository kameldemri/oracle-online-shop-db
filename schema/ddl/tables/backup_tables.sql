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
    INSERT INTO products_deleted (
        product_id, name, price, category_id, deleted,
        created_on, updated_on, created_by, updated_by,
        deleted_on, deleted_by
    ) VALUES (
        :OLD.product_id, :OLD.name, :OLD.price, :OLD.category_id, :OLD.deleted,
        :OLD.created_on, :OLD.updated_on, :OLD.created_by, :OLD.updated_by,
        SYSDATE, NULL
    );
END;
/


-- SHIPMENTS

-- Copy tables structure and add cols
CREATE TABLE shipments_deleted AS SELECT * FROM shipments WHERE 1=0;
ALTER TABLE shipments_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE shipments_deleted ADD deleted_by NUMBER;

CREATE OR REPLACE TRIGGER trg_backup_shipment
BEFORE DELETE ON shipments
FOR EACH ROW
BEGIN
    INSERT INTO shipments_deleted (
        shipment_id, shipping_date, carrier, max_orders, current_orders, status, deleted,
        created_on, updated_on, created_by, updated_by,
        deleted_on, deleted_by
    ) VALUES (
        :OLD.shipment_id, :OLD.shipping_date, :OLD.carrier, :OLD.max_orders, :OLD.current_orders, :OLD.status, :OLD.deleted,
        :OLD.created_on, :OLD.updated_on, :OLD.created_by, :OLD.updated_by,
        SYSDATE, NULL
    );
END;
/
