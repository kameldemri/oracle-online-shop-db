
-- USERS
CREATE OR REPLACE PROCEDURE generate_users (
    count_in        IN PLS_INTEGER,
    role_in         IN NUMBER,
    created_by_in   IN NUMBER   -- Must check this one in the backend
) IS
    TYPE user_rec IS RECORD (
        username    users.username%TYPE,
        email       users.email%TYPE,
        password    users.password%TYPE,
        last_name   users.last_name%TYPE,
        first_name  users.first_name%TYPE,
        role        users.role%TYPE
    );

    l_user_num  NUMBER;

    TYPE user_tab IS TABLE OF user_rec;
    l_users user_tab := user_tab();

BEGIN
    FOR i IN 1 .. count_in LOOP
        l_users.EXTEND;
        l_user_num := seq_user_num.NEXTVAL;

        l_users(i).username   := 'user' || l_user_num;
        l_users(i).email      := 'user' || l_user_num || '@mail.com';

        -- NOTE: Password comes already hashed from backend
        l_users(i).password   := 'hashed_pass_' || l_user_num;

        l_users(i).last_name  := 'Last' || l_user_num;
        l_users(i).first_name := 'First' || l_user_num;
        l_users(i).role       := role_in;
    END LOOP;
    
    -- BULK INSERT
    FORALL i IN 1 .. l_users.COUNT
        INSERT INTO users (
            username, email, password, last_name, first_name, role, created_on, created_by
        ) VALUES (
            l_users(i).username,
            l_users(i).email,
            l_users(i).password,
            l_users(i).last_name,
            l_users(i).first_name,
            l_users(i).role,
            SYSDATE,
            created_by_in
        );
EXCEPTION
    WHEN OTHERS THEN
            record_error();
            RAISE;
END;
/
