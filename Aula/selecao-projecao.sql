SELECT * FROM hr.employees;
 
DESC hr.employees;

CREATE TABLE empregado AS SELECT * FROM hr.employees;
 
SELECT * FROM empregado;
DESC empregado;
 
ALTER TABLE empregado ADD CONSTRAINT emp_pk PRIMARY KEY (employee_id);
 
CREATE TABLE hollerith (
    dt_pagamento DATE DEFAULT SYSDATE,
    id INTEGER,
    salBruto NUMBER(10, 2),
    vale_transp NUMBER(10, 2),
    salliq NUMBER(10, 2),
    CONSTRAINT hollerith_pk PRIMARY KEY (dt_pagamento, id),
    CONSTRAINT hollerith_fk FOREIGN KEY (id) REFERENCES empregado (employee_id)
)
 
DESC empregado
DESC hollerith
 
SELECT * FROM empregado
SELECT * FROM hollerith
 
INSERT INTO hollerith (id, salbruto, vale_transp) (SELECT employee_id, salary, salary * 0.06 FROM empregado)
 
UPDATE hollerith SET salliq = salbruto - vale_transp
 
-- PROJEÇÃO
SELECT * FROM empregado ORDER BY first_name
 
SELECT * FROM empregado ORDER BY salary DESC
 
SELECT * FROM empregado ORDER BY first_name, salary DESC
 
SELECT employee_id, first_name, hire_date, salary FROM empregado
 
SELECT employee_id id, first_name "Nome", hire_date as "data admissao", salary FROM empregado
 
SELECT employee_id id, first_name "Nome", hire_date as "data admissao", salary FROM empregado ORDER BY hire_date
 
SELECT employee_id id, first_name "Nome", hire_date as "data admissao", salary FROM empregado ORDER BY 3 DESC
 
SELECT employee_id id, first_name "Nome", hire_date as "data admissao", salary, department_id as "ID do Departamento" FROM empregado ORDER BY 3 DESC
 
SELECT job_id FROM empregado
 
SELECT DISTINCT job_id FROM empregado
 
SELECT employee_id, salary, salary * 1.05 as "Salário aumentado 5%" FROM empregado
 
-- SELEÇÃO 
SELECT * FROM empregado WHERE department_id = 50
 
SELECT * FROM empregado WHERE department_id = 50 OR department_id = 80
 
SELECT * FROM empregado WHERE department_id IN (50, 80)
 
SELECT * FROM empregado WHERE department_id != 50 OR department_id <> 80
 
SELECT * FROM empregado WHERE department_id NOT IN (50, 80)
 
SELECT * FROM empregado WHERE salary > 5000 ORDER BY salary
 
SELECT * FROM empregado WHERE department_id IS NULL
 
SELECT * FROM empregado WHERE department_id IS NOT NULL
 
SELECT * FROM empregado WHERE salary BETWEEN 10000 AND 15000
 
SELECT * FROM empregado WHERE salary >= 10000 AND salary <= 15000 ORDER BY salary
 
SELECT * FROM empregado WHERE salary NOT BETWEEN 10000 AND 15000
 
SELECT first_name FROM empregado WHERE first_name LIKE 'A%'
 
SELECT first_name FROM empregado WHERE first_name LIKE '_a%'
 
SELECT first_name FROM empregado WHERE first_name LIKE '%a'
 
SELECT first_name FROM empregado WHERE first_name LIKE '%a%'
 
SELECT first_name FROM empregado WHERE first_name LIKE 'A%' OR first_name LIKE '%a'
 
SELECT first_name, hire_date FROM empregado WHERE hire_date LIKE '%OCT%'
 
SELECT first_name, hire_date FROM empregado WHERE hire_date LIKE '16%'
 
SELECT first_name, hire_date FROM empregado WHERE hire_date LIKE '%00'

SELECT first_name, hire_date FROM empregado WHERE hire_date NOT LIKE '%00'
 
SELECT * FROM empregado WHERE department_id = 60 AND salary > 5000
 
SELECT first_name || ' ' || last_name AS "Nome Completo" FROM empregado WHERE first_name LIKE 'B%' OR first_name LIKE 'D%' ORDER BY first_name