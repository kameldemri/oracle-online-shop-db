---
-- VIEWS
---

-- NON-ACTIVE USERS
CREATE OR REPLACE VIEW deleted_users AS
    SELECT * FROM users WHERE deleted = 'Y';

-- ACTIVE USERS
CREATE OR REPLACE VIEW active_users AS
    SELECT * FROM users WHERE deleted = 'N';
