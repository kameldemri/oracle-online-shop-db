---
-- SEED DATA
---

SET DEFINE OFF;

--- ROLES
INSERT INTO roles (role_id, code, label) VALUES (1, 'admin', 'Administrator');
INSERT INTO roles (role_id, code, label) VALUES (2, 'user', 'Regular user');

-- PRODUCT_CATEGORIES
INSERT INTO product_categories (category_id, code, label) VALUES (1, 'electronics', 'Electronics');
INSERT INTO product_categories (category_id, code, label) VALUES (2, 'books', 'Books & Stationery');
INSERT INTO product_categories (category_id, code, label) VALUES (3, 'clothing', 'Clothing & Accessories');
INSERT INTO product_categories (category_id, code, label) VALUES (4, 'home', 'Home & Kitchen');

-- SHIPMENT_STATUSES
INSERT INTO shipment_statuses (status_id, code, label) VALUES (1, 'available', 'Available');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (2, 'in_transit', 'In Transit');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (3, 'full', 'Full Capacity');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (4, 'cancelled', 'Cancelled');

-- ORDER_STATUSES
INSERT INTO order_statuses (status_id, code, label) VALUES (1, 'pending', 'Pending');
INSERT INTO order_statuses (status_id, code, label) VALUES (2, 'shipped', 'Shipped');
INSERT INTO order_statuses (status_id, code, label) VALUES (3, 'cancelled', 'Cancelled');

COMMIT;
