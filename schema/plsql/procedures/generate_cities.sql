CREATE OR REPLACE PROCEDURE generate_cities (
    p_wilaya_id   IN wilayas.wilaya_id%TYPE,
    p_count       IN PLS_INTEGER
) IS
BEGIN
    FOR i IN 1 .. p_count LOOP
        INSERT INTO cities (city_id, name, wilaya_id)
        VALUES (
            seq_city_id.NEXTVAL,
            'City' || i,
            p_wilaya_id
        );
    END LOOP;
END;
/
