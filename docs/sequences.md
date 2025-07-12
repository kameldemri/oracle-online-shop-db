# Sequences

## Auto Increment Primary Keys

Each major table has a dedicated sequence used to generate primary keys.

| Table     | Sequence         |
| --------- | ---------------- |
| users     | `seq_user_id`    |
| products  | `seq_product_id` |
| shipments | `seq_ship_id`    |
| orders    | `seq_order_id`   |

> All sequences are pre-created in `ddl/sequences/sequences.sql`
