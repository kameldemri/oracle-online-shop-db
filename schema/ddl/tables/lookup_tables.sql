---
-- LOOKUP TABLES (ENUM LIKE)
---

--- ROLES
CREATE TABLE roles (
    role_id     NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);

-- PRODUCT_CATEGORIES
CREATE TABLE product_categories (
    category_id NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);

-- SHIPMENT_STATUSES
CREATE TABLE shipment_statuses (
    status_id   NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);

-- ORDER_STATUSES
CREATE TABLE order_statuses (
    status_id   NUMBER PRIMARY KEY,
    code        VARCHAR2(20) UNIQUE NOT NULL,
    label       VARCHAR2(256) UNIQUE NOT NULL
);
