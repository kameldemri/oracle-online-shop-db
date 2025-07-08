---
-- LOOKUP TABLES
---

--- ROLES
CREATE TABLE roles (
    role_id     NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);
INSERT INTO roles (role_id, code, label) VALUES (1, 'admin', 'Administrator');
INSERT INTO roles (role_id, code, label) VALUES (2, 'user', 'Regular user');

-- PRODUCT_CATEGORIES
CREATE TABLE product_categories (
    category_id NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);
INSERT INTO product_categories (category_id, code, label) VALUES (1, 'electronics', 'Electronics');
INSERT INTO product_categories (category_id, code, label) VALUES (2, 'books', 'Books & Stationery');
INSERT INTO product_categories (category_id, code, label) VALUES (3, 'clothing', 'Clothing & Accessories');
INSERT INTO product_categories (category_id, code, label) VALUES (4, 'home', 'Home & Kitchen');

-- SHIPMENT_STATUSES
CREATE TABLE shipment_statuses (
    status_id   NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);
INSERT INTO shipment_statuses (status_id, code, label) VALUES (1, 'available', 'Available');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (2, 'in_transit', 'In Transit');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (3, 'full', 'Full Capacity');
INSERT INTO shipment_statuses (status_id, code, label) VALUES (4, 'cancelled', 'Cancelled');

-- ORDER_STATUSES
CREATE TABLE order_statuses (
    status_id   NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);
INSERT INTO order_statuses (status_id, code, label) VALUES (1, 'pending', 'Pending');
INSERT INTO order_statuses (status_id, code, label) VALUES (2, 'shipped', 'Shipped');
INSERT INTO order_statuses (status_id, code, label) VALUES (3, 'cancelled', 'Cancelled');
