CREATE OR REPLACE PROCEDURE generate_addresses (
    p_user_id  IN users.user_id%TYPE,
    p_city_id  IN cities.city_id%TYPE,
    p_count    IN PLS_INTEGER
) IS
BEGIN
    FOR i IN 1 .. p_count LOOP
        INSERT INTO addresses (
            address_id, user_id, city_id, street_name, postal_code
        ) VALUES (
            seq_address_id.NEXTVAL,
            p_user_id,
            p_city_id,
            'Street ' || i,
            '1600' || TO_CHAR(i)
        );
    END LOOP;
END;
/
