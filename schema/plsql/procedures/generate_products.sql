-- PRODUCTS
CREATE OR REPLACE PROCEDURE generate_products (
    count_in       IN PLS_INTEGER,
    created_by_in  IN users.user_id%TYPE
) IS
    -- Define a record type for a product row
    TYPE product_rec IS RECORD (
        name         products.name%TYPE,
        price        products.price%TYPE,
        category_id  products.category_id%TYPE,
        weight       products.weight%TYPE,
        volume       products.volume%TYPE
    );
    l_product_num  NUMBER;
    -- Define a table of records type
    TYPE product_tab IS TABLE OF product_rec;
    l_products product_tab := product_tab();  -- init
BEGIN
    FOR i IN 1 .. count_in LOOP
        l_products.EXTEND;
        l_product_num := seq_product_num.NEXTVAL;

        l_products(i).name := 'product' || l_product_num;
        l_products(i).price := TRUNC(DBMS_RANDOM.VALUE(100, 1200));
        l_products(i).category_id := TRUNC(DBMS_RANDOM.VALUE(1, 3));
        l_products(i).weight := TRUNC(DBMS_RANDOM.VALUE(0.10, 10), 2);
        l_products(i).volume := TRUNC(DBMS_RANDOM.VALUE(0.001, 0.3), 4);
    END LOOP;
    -- Bulk insert
    FORALL i IN 1 .. l_products.COUNT
        INSERT INTO products (name, price, category_id, created_on, 
            created_by, weight, volume)
        VALUES (
            l_products(i).name,
            l_products(i).price,
            l_products(i).category_id,
            SYSDATE,
            created_by_in,
            l_products(i).weight,
            l_products(i).volume
        );
END;
/
