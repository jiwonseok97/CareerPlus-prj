-- Test user for login (only inserts if not exists)
MERGE INTO person_mem pm
USING (SELECT 1 AS p_no FROM dual) src
ON (pm.pid = 'person')
WHEN NOT MATCHED THEN
INSERT (p_no, name, pid, pwd, phone, email, field_code, is_job, nickname, addr, sex, jumin_num, reg_date)
VALUES ((SELECT NVL(MAX(p_no), 0) + 1 FROM person_mem), 'TestUser', 'person', '12341234', '010-1234-5678', 'person@test.com', 1, 'Y', 'TestNick', 'Seoul', 'M', '9901011234567', SYSDATE);
