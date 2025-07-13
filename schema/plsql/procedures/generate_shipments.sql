-- SHIPMENTS
CREATE OR REPLACE PROCEDURE generate_shipments (
    count_in        IN PLS_INTEGER,
    created_by_in   IN shipments.created_by%TYPE
) IS
    TYPE shipment_tab IS TABLE OF shipments%ROWTYPE;
    l_shipments shipment_tab := shipment_tab();
BEGIN
    FOR i IN 1 .. count_in LOOP
        -- Extend the nested table
        l_shipments.EXTEND;

        -- Fill values
        l_shipments(i).shipping_date   := SYSDATE + TRUNC(DBMS_RANDOM.VALUE(0, 15));
        l_shipments(i).carrier         := 'Carrier ' || TRUNC(DBMS_RANDOM.VALUE(1, 5));
        l_shipments(i).max_orders      := TRUNC(DBMS_RANDOM.VALUE(5, 10));
        l_shipments(i).current_orders  := 0;
        l_shipments(i).status          := 1;
        l_shipments(i).created_on      := SYSDATE;
        l_shipments(i).created_by      := created_by_in;
    END LOOP;

    -- Insert all rows at once
    FORALL i IN 1 .. l_shipments.COUNT
        INSERT INTO shipments VALUES l_shipments(i);
END;
/
