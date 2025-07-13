-- PUBLIC SYNONYMS for all core tables

CREATE OR REPLACE PUBLIC SYNONYM users              FOR SHOP_DEV.users;
CREATE OR REPLACE PUBLIC SYNONYM customers          FOR SHOP_DEV.customers;
CREATE OR REPLACE PUBLIC SYNONYM products           FOR SHOP_DEV.prodcuts;
CREATE OR REPLACE PUBLIC SYNONYM orders             FOR SHOP_DEV.orders;
CREATE OR REPLACE PUBLIC SYNONYM order_items        FOR SHOP_DEV.order_items;
CREATE OR REPLACE PUBLIC SYNONYM shipments          FOR SHOP_DEV.shipments;
CREATE OR REPLACE PUBLIC SYNONYM addresses          FOR SHOP_DEV.addresses;
CREATE OR REPLACE PUBLIC SYNONYM countries          FOR SHOP_DEV.countries;
CREATE OR REPLACE PUBLIC SYNONYM wilayas            FOR SHOP_DEV.wilayas;
CREATE OR REPLACE PUBLIC SYNONYM cities             FOR SHOP_DEV.cities;

-- Lookup tables
CREATE OR REPLACE PUBLIC SYNONYM shipment_statuses  FOR SHOP_DEV.shipment_statuses;
CREATE OR REPLACE PUBLIC SYNONYM order_statuses     FOR SHOP_DEV.order_statuses;
CREATE OR REPLACE PUBLIC SYNONYM product_categories FOR SHOP_DEV.product_categories;
CREATE OR REPLACE PUBLIC SYNONYM roles              FOR SHOP_DEV.roles;

-- Backup tables
CREATE OR REPLACE PUBLIC SYNONYM products_deleted   FOR SHOP_DEV.products_deleted;
CREATE OR REPLACE PUBLIC SYNONYM shipments_deleted  FOR SHOP_DEV.shipments_deleted;

-- Views

CREATE OR REPLACE PUBLIC SYNONYM deleted_users FOR SHOP_DEV.deleted_users ;
CREATE OR REPLACE PUBLIC SYNONYM active_users FOR SHOP_DEV.active_users ;
