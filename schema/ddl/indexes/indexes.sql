--
--- Indexes
--

-- ORDERS
-- WEHRE customer_id = ? AND status = ?
CREATE INDEX idx_orders_customer_status ON orders(customer_id, status);


-- ORDER_ITEMS
CREATE INDEX idx_order_items_product_id ON order_items(product_id);


-- SHIPMENTS
CREATE INDEX idx_shipments_status ON shipments(status);


-- ADDRESSES
CREATE INDEX idx_addresses_user_id ON addresses(user_id);
CREATE INDEX idx_addresses_city_id ON addresses(city_id);
