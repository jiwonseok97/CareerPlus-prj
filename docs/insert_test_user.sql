INSERT INTO person_mem (p_no, name, pid, pwd, phone, email, field_code, is_job, nickname, addr, sex, jumin_num, reg_date) VALUES ((SELECT NVL(MAX(p_no), 0) + 1 FROM person_mem), 'TestUser', 'person', '12341234', '010-1234-5678', 'person@test.com', 1, 'Y', 'TestNick', 'Seoul', 'M', '9901011234567', SYSDATE);
COMMIT;
SELECT p_no, pid, pwd, nickname FROM person_mem WHERE pid='person';
EXIT;
