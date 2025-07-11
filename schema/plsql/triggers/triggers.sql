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

CREATE OR REPLACE TRIGGER trg_soft_delete_user
BEFORE DELETE ON users
FOR EACH ROW
DECLARE
    -- Perform soft delete instead
    UPDATE users SET deleted = 'Y',
        updated_on = SYSDATE
    -- other cols should be handled using the backend programming lang
    WHERE user_id = :OLD.user_id;
END;

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

CREATE OR REPLACE TRIGGER trg_soft_delete_customer
BEFORE DELETE ON customers
FOR EACH ROW
DECLARE
    -- Perform soft delete instead
    UPDATE customers SET deleted = 'Y',
        updated_on = SYSDATE
    -- other cols should be handled using the backend programming lang
    WHERE customer_id = :OLD.customer_id;
END;

-- PRODUCTS
CREATE OR REPLACE TRIGGER trg_product_id
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    :NEW.product_id := seq_product_id.NEXTVAL;
END;

-- ORDERS
CREATE OR REPLACE TRIGGER trg_order_id
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    :NEW.order_id := seq_order_id.NEXTVAL;
END;

-- SHIPMENTS
CREATE OR REPLACE TRIGGER trg_shipment_id
BEFORE INSERT ON shipments
FOR EACH ROW
BEGIN
    :NEW.shipment_id := seq_shipment_id.NEXTVAL;
END;

-- CUSTOMERS
CREATE OR REPLACE TRIGGER trg_create_customer
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    -- check if user is already a customer
    IF NOT EXISTS (
        SELECT 1 FROM customers WHERE customer_id = :NEW.customer_id
    ) THEN
        INSERT INTO customers (customer_id)
        VALUES (:NEW.customer_id);
    END IF;
END;
