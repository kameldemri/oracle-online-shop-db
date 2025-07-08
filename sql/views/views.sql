---
-- VIEWS
---

-- NON-ACTIVE CUSTOMERS (SOFT DELETED)
CREATE OR REPLACE VIEW deleted_users AS
    SELECT * FROM users WHERE deleted = 'Y';
