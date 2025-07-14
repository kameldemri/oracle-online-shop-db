BEGIN generate_users(1,1,NULL); END;
/
COMMIT;

BEGIN generate_users(100,2,1); END;
/
COMMIT;

BEGIN generate_products(100,1); END;
/
COMMIT;

BEGIN generate_shipments(20,1); END;
/
COMMIT;

BEGIN generate_orders(2, 10); END;
/
COMMIT;

BEGIN
    generate_cities(16, 5);
    generate_cities(35, 5);
END;
/

BEGIN
    generate_addresses(2, 2, 2);
    generate_addresses(3, 10, 1);
END;
/
COMMIT;
