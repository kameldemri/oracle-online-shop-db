BEGIN
    generate_users(1,1,NULL);
    generate_users(100,2,1);
    generate_products(100,1);
    generate_shipments(20,1);
    generate_orders(2, 10);
    generate_cities(16, 5);
    generate_cities(35, 5);
    generate_addresses(2, 2, 2);
    generate_addresses(3, 10, 1);
    COMMIT;
END;
/
