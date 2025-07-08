---
-- BACKUP TABLES
---

-- PRODUCTS

-- Copy tables structure and add cols
CREATE TABLE products_deleted AS SELECT * FROM products WHERE 1=0;
ALTER TABLE products_deleted ADD deleted_on DATE DEFAULT SYSDATE;
ALTER TABLE products_deleted ADD deleted_by NUMBER;

CREATE OR REPLACE TRIGGER trg_backup_product_delete 
BEFORE DELETE ON products
FOR EACH ROW
BEGIN
    INSERT INTO products_deleted (
        product_id name, price, category_id, created_on,
        updated_on, created_by, updated_by, deleted_on, deleted_by
    )
    VALUES (
        :OLD.product_id,
        :OLD.name,
        :OLD.price,
        :OLD.category_id,
        :OLD.created_on,
        :OLD.updated_on,
        :OLD.created_by,
        :OLD.updated_by,
        SYSDATE,
        :OLD.updated_by
    );
END;
