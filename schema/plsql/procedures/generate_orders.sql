CREATE OR REPLACE PROCEDURE generate_orders (
    user_id_in      IN users.user_id%TYPE,
    total_items_in  IN PLS_INTEGER
)IS
    l_order_id orders.order_id%TYPE;
BEGIN
    INSERT INTO orders (customer_id, status, created_by) VALUES 
        (user_id_in, 'pending', user_id_in) RETURNING order_id INTO l_order_id;
    generate_order_items(l_order_id, total_items_in, user_id_in);
EXCEPTION
    WHEN OTHERS THEN
            record_error();
            RAISE;
END;
/
