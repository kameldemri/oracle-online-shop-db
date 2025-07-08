---
-- DATA GENERATION (DUMMY)
---

-- USERS
CREATE OR REPLACE PROCEDURE generate_users (
    count_in        IN PLS_INTEGER,
    role_in         IN NUMBER,
    created_by_in   IN NUMBER   -- Must check this one in the backend
) IS
    TYPE user_rec IS RECORD (
        username    users.username%TYPE,
        email       users.email%TYPE,
        password    users.password%TYPE,
        last_name   users.last_name%TYPE,
        first_name  users.first_name%TYPE,
        role        users.role%TYPE
    );

    l_user_num  NUMBER;

    TYPE user_tab IS TABLE OF user_rec;
    l_users user_tab := user_tab();

BEGIN
    FOR i IN 1 .. count_in LOOP
        l_users.EXTEND;
        l_user_num := seq_user_num.NEXTVAL;

        l_users(i).username   := 'user' || l_user_num;
        l_users(i).email      := 'user' || l_user_num || '@mail.com';

        -- MD5 Hash
        l_users(i).password   := RAWTOHEX (
            DBMS_CRYPTO.HASH(UTL_I18N.STRING_TO_RAW('pass' || l_user_num, 'AL32UTF8'), DBMS_CRYPTO.HASH_MD5)
        );

        l_users(i).last_name  := 'Last' || l_user_num;
        l_users(i).first_name := 'First' || l_user_num;
        l_users(i).role       := role_in;
    END LOOP;
    
    -- BULK INSERT
    FORALL i IN 1 .. l_users.COUNT
        INSERT INTO users (
            username, email, password, last_name, first_name, role, created_on, created_by
        ) VALUES (
            l_users(i).username,
            l_users(i).email,
            l_users(i).password,
            l_users(i).last_name,
            l_users(i).first_name,
            l_users(i).role,
            SYSDATE,
            created_by_in
        );
END;

-- PRODUCTS
CREATE OR REPLACE PROCEDURE generate_products (
    count_in       IN PLS_INTEGER,
    created_by_in  IN users.user_id%TYPE
) IS
    -- Define a record type for a product row
    TYPE product_rec IS RECORD (
        name         products.name%TYPE,
        price        products.price%TYPE,
        category_id  products.category_id%TYPE
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
    END LOOP;

    -- Bulk insert
    FORALL i IN 1 .. l_products.COUNT
        INSERT INTO products (name, price, category_id, created_on, created_by)
        VALUES (
            l_products(i).name,
            l_products(i).price,
            l_products(i).category_id,
            SYSDATE,
            created_by_in
        );
END;

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
