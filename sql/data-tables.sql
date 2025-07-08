-- USERS
CREATE TABLE users (
    user_id    NUMBER PRIMARY KEY,
    username   VARCHAR2(50) UNIQUE NOT NULL,
    email      VARCHAR2(100) UNIQUE NOT NULL,
    password   VARCHAR2(256) NOT NULL,    -- hashed
    last_name  VARCHAR2(100) NOT NULL,
    first_name VARCHAR2(100) NOT NULL,
    role       NUMBER NOT NULL,

    deleted    CHAR(1) DEFAULT 'N' CHECK (deleted IN ('Y', 'N'));

    -- audit columns
    created_on DATE DEFAULT SYSDATE,
    updated_on DATE,
    created_by NUMBER,

    CONSTRAINT fk_role FOREIGN KEY (role) REFERENCES roles(role_id),
    CONSTRAINT fk_user_created_by FOREIGN KEY (created_by) REFERENCES users(user_id)
);

-- CUSTOMERS
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY REFERENCES users(user_id),

    -- audit columns
    created_on  DATE DEFAULT SYSDATE,
    updated_on  DATE,
    updated_by  NUMBER,

    CONSTRAINT fk_customer_updated_by FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- PRODUCTS
CREATE TABLE products (
    product_id  NUMBER PRIMARY KEY,
    name        VARCHAR2(100) NOT NULL,
    price       NUMBER CHECK (price > 0),
    category_id NUMBER REFERENCES product_categories(category_id),

    -- audit columns
    created_on DATE DEFAULT SYSDATE,
    updated_on DATE,
    created_by NUMBER,
    updated_by NUMBER,

    CONSTRAINT fk_product_created_by FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT fk_product_updated_by FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- SHIPMENTS
CREATE TABLE shipments (
    shipment_id    NUMBER PRIMARY KEY,
    shipping_date  DATE,
    carrier        VARCHAR2(100),
    max_orders     NUMBER DEFAULT 10,
    current_orders NUMBER DEFAULT 0 CHECK (current_orders >= 0),
    status         NUMBER,

    -- audit columns
    created_on DATE DEFAULT SYSDATE,
    updated_on DATE,
    created_by NUMBER,
    updated_by NUMBER,
    
    CONSTRAINT chk_orders CHECK (current_orders <= max_orders),
    CONSTRAINT fk_status FOREIGN KEY (status) REFERENCES shipment_statuses(status_id),

    CONSTRAINT fk_shipment_created_by FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT fk_shipment_updated_by FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- ORDER_ITEMS
CREATE TABLE order_items (
    order_id     NUMBER,
    item_no      NUMBER,
    product_id   NUMBER,
    quantity     NUMBER CHECK (quantity > 0),
    unit_price   NUMBER CHECK (unit_price > 0),

    -- audit columns
    created_on DATE DEFAULT SYSDATE,
    updated_on DATE,
    created_by NUMBER,
    updated_by NUMBER,

    -- composite primary key
    CONSTRAINT pk_order_item PRIMARY KEY (order_id, item_no),

    CONSTRAINT fk_order FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
        ON DELETE CASCADE,  -- auto-delete items when order is deleted

    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_order_item_created_by FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT fk_order_item_updated_by FOREIGN KEY (updated_by) REFERENCES users(user_id)
);

-- COUNTRIES 
CREATE TABLE countries (
    country_id   NUMBER PRIMARY KEY,
    name         VARCHAR2(100) UNIQUE NOT NULL
    phone_code   NUMBER(3),
    country_code VARCHAR2(5)
);
INSERT INTO countries (1, 'Algeria', 213, 'DZ');

-- WILAYAS
CREATE TABLE wilayas (
    wilaya_id  NUMBER PRIMARY KEY,
    name       VARCHAR2(100) UNIQUE NOT NULL,
    country_id NUMBER NOT NULL,

    CONSTRAINT fk_country FOREIGN KEY (country_id)
        REFERENCES countries(country_id)
);
INSERT INTO wilayas (16, 'Algeirs', 1);
INSERT INTO wilayas (35, 'Boumerdes', 1);

-- CITIES
CREATE TABLE cities (
    city_id   NUMBER PRIMARY KEY,
    name      VARCHAR2(100) NOT NULL,
    wilaya_id NUMBER NOT NULL,

    CONSTRAINT fk_wilaya FOREIGN KEY (wilaya_id)
        REFERENCES wilayas(wilaya_id)
);

-- ADDRESSES
CREATE TABLE addresses (
    address_id  NUMBER PRIMARY KEY,
    user_id     NUMBER NOT NULL,
    city_id     NUMBER NOT NULL,
    street_name VARCHAR2(200),
    postal_code VARCHAR2(20),

    CONSTRAINT fk_user FOREIGN KEY (user_id)
        REFERENCES users(user_id),
    CONSTRAINT fk_city FOREIGN KEY (city_id)
        REFERENCES cities(city_id)
);

-- ORDERS
CREATE TABLE orders (
    order_id     NUMBER PRIMARY KEY,
    customer_id  NUMBER NOT NULL,
    shipment_id  NUMBER,
    address_id   NUMBER,
    status       VARCHAR2(20) DEFAULT 'pending' NOT NULL,
    total_price NUMBER DEFAULT 0,

    -- audit columns
    created_on DATE DEFAULT SYSDATE,
    updated_on DATE,
    created_by NUMBER,
    updated_by NUMBER,

    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_shipment FOREIGN KEY (shipment_id) REFERENCES shipments(shipment_id),
    CONSTRAINT fk_address FOREIGN KEY (address_id) REFERENCES addresses(address_id),

    CONSTRAINT fk_order_created_by FOREIGN KEY (created_by) REFERENCES users(user_id),
    CONSTRAINT fk_order_updated_by FOREIGN KEY (updated_by) REFERENCES users(user_id)
);
