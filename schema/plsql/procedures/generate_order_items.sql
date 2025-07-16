CREATE OR REPLACE PROCEDURE generate_order_items (
    order_id_in     IN orders.order_id%TYPE,
    total_items_in  IN PLS_INTEGER,
    customer_id_in  IN customers.customer_id%TYPE
) IS
    TYPE products_nt IS TABLE OF products.product_id%TYPE;
    l_products products_nt; 

    TYPE order_items_nt IS TABLE OF order_items%ROWTYPE;
    l_order_items order_items_nt := order_items_nt();

    l_product_count PLS_INTEGER;
BEGIN
    -- BULK fetch all product ids
    SELECT product_id BULK COLLECT INTO l_products
    FROM products WHERE deleted = 'N';

    l_product_count := l_products.COUNT;

    FOR i IN 1 .. total_items_in LOOP
        l_order_items.EXTEND;
        l_order_items(i).order_id   := order_id_in;
        l_order_items(i).item_no    := i;
        l_order_items(i).product_id := l_products(TRUNC(DBMS_RANDOM.VALUE(1, l_product_count + 1)));
        l_order_items(i).quantity   := TRUNC(DBMS_RANDOM.VALUE(1, 4));
        l_order_items(i).created_on := SYSDATE;
        l_order_items(i).created_by := customer_id_in;
    END LOOP;

    -- Perform bulk insert
    FORALL i IN 1 .. l_order_items.COUNT
        INSERT INTO order_items VALUES l_order_items(i);

EXCEPTION
    WHEN OTHERS THEN
            record_error();
            RAISE;
END;
/
