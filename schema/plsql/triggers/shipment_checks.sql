CREATE OR REPLACE TRIGGER trg_check_shipment_capacity
BEFORE INSERT ON orders
FOR EACH ROW
WHEN (NEW.shipment_id IS NOT NULL)
DECLARE
    l_current_orders NUMBER;
    l_max_orders     NUMBER;
BEGIN
    SELECT current_orders, max_orders
    INTO l_current_orders, l_max_orders
    FROM shipments
    WHERE shipment_id = :NEW.shipment_id;

    IF l_current_orders >= l_max_orders THEN
        RAISE_APPLICATION_ERROR(-20901, 'Shipment is full. Cannot assign more orders.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_update_shipment_order_count
AFTER INSERT ON orders
FOR EACH ROW
WHEN (NEW.shipment_id IS NOT NULL)
BEGIN
    UPDATE shipments
    SET current_orders = current_orders + 1
    WHERE shipment_id = :NEW.shipment_id;
END;
/
