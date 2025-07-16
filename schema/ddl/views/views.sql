---
-- VIEWS
---

-- Customer Orders View
CREATE OR REPLACE VIEW vw_customer_orders AS
SELECT
    o.order_id,
    u.user_id,
    u.first_name || ' ' || u.last_name AS customer_name,
    o.status AS order_status,
    o.total_price,
    s.carrier,
    ss.label AS shipment_status,
    o.created_on
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN users u ON c.customer_id = u.user_id
LEFT JOIN shipments s ON o.shipment_id = s.shipment_id
LEFT JOIN shipment_statuses ss ON s.status = ss.status_id;

-- Active Users (not deleted)
CREATE OR REPLACE VIEW vw_active_users AS
SELECT
    u.user_id,
    u.username,
    u.email,
    r.code AS role,
    u.created_on
FROM users u
JOIN roles r ON u.role = r.role_id
WHERE u.deleted = 'N';

-- Top Products by Total Ordered Quantity
CREATE OR REPLACE VIEW vw_top_products AS
SELECT
    p.product_id,
    p.name,
    SUM(oi.quantity) AS total_quantity_ordered,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.name
ORDER BY total_quantity_ordered DESC;

-- Orders Summary By Day
CREATE OR REPLACE VIEW vw_orders_by_day AS
SELECT
    TRUNC(created_on) AS order_date,
    COUNT(*) AS total_orders,
    SUM(total_price) AS total_revenue
FROM orders
GROUP BY TRUNC(created_on)
ORDER BY order_date DESC;

-- Full Address Details
CREATE OR REPLACE VIEW vw_user_addresses AS
SELECT
    a.address_id,
    u.username,
    u.email,
    a.street_name,
    a.postal_code,
    c.name AS city,
    w.name AS wilaya,
    co.name AS country
FROM addresses a
JOIN users u ON a.user_id = u.user_id
JOIN cities c ON a.city_id = c.city_id
JOIN wilayas w ON c.wilaya_id = w.wilaya_id
JOIN countries co ON w.country_id = co.country_id;