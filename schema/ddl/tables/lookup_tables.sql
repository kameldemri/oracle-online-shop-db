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

-- SHIPMENT_TYPES
CREATE TABLE shipment_types (
    shipment_type_id  NUMBER PRIMARY KEY,
    name              VARCHAR2(100),
    max_weight        NUMBER(6,2),
    max_volume        NUMBER(7,5)
);
