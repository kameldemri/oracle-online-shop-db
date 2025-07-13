
---
-- TRIGGERS
---

-- USERS
CREATE OR REPLACE TRIGGER trg_user_id
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    :NEW.user_id := seq_user_id.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER trg_soft_delete_user
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
    UPDATE users
    SET deleted = 'Y',
        updated_on = SYSDATE
    WHERE user_id = :OLD.user_id;

    RAISE_APPLICATION_ERROR(-20001, 'Soft delete performed; original delete aborted.');
END;
/

-- CUSTOMERS
CREATE OR REPLACE TRIGGER trg_create_customer
BEFORE INSERT ON orders
FOR EACH ROW
DECLARE
    dummy NUMBER;
BEGIN
    SELECT COUNT(*) INTO dummy
    FROM customers
    WHERE customer_id = :NEW.customer_id;

    IF dummy = 0 THEN
        INSERT INTO customers (customer_id)
        VALUES (:NEW.customer_id);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_soft_delete_customer
BEFORE DELETE ON customers
FOR EACH ROW
BEGIN
    UPDATE customers
    SET deleted = 'Y',
        updated_on = SYSDATE
    WHERE customer_id = :OLD.customer_id;

    RAISE_APPLICATION_ERROR(-20002, 'Soft delete performed; original delete aborted.');
END;
/

-- PRODUCTS
CREATE OR REPLACE TRIGGER trg_product_id
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    :NEW.product_id := seq_product_id.NEXTVAL;
END;
/

-- ORDERS
CREATE OR REPLACE TRIGGER trg_order_id
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    :NEW.order_id := seq_order_id.NEXTVAL;
END;
/

-- SHIPMENTS
CREATE OR REPLACE TRIGGER trg_shipment_id
BEFORE INSERT ON shipments
FOR EACH ROW
BEGIN
    :NEW.shipment_id := seq_shipment_id.NEXTVAL;
END;
/
