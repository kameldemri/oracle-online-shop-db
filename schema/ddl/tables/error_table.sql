CREATE TABLE error_log
(
    ERROR_CODE      INTEGER,
    error_message   VARCHAR2 (4000),
    backtrace       CLOB,
    callstack       CLOB,
    created_on      DATE,
    created_by      VARCHAR2 (30)
);
