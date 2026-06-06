-- EXERCÍCIO
 
-- Criando uma VIEW
CREATE VIEW vw_cidade (id, cidade)
AS 
SELECT location_id, city
FROM locations
 
-- Inserindo valores
INSERT INTO VW_CIDADE VALUES (1, 'Praia Grande')
INSERT INTO VW_CIDADE VALUES (2, 'Santos')
INSERT INTO VW_CIDADE VALUES (3, 'São Vicente')
 
-- Selecionando valores que foram inseridos só na tabela locations
SELECT * FROM VW_CIDADE WHERE id NOT BETWEEN 1 AND 3
 
-- Deletando um registro específico
DELETE FROM VW_DEPTO WHERE id = 1
 
-- Dropando a VIEW
DROP VIEW VW_CIDADE
 
CREATE VIEW vw_dept_emp
AS
SELECT d.department_name depto, COUNT(*) qtde, SUM(e.salary) soma
FROM employees e, departments d
WHERE d.department_id = e.department_id 
GROUP BY d.department_name
 
SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME = 'VW_DEPT_EMP'
 
SELECT * FROM VW_DEPT_EMP ORDER BY depto
 
SELECT depto AS "Nome do departamento", qtde AS "Quantidade de Funcionários", soma AS "Soma dos Salários"
FROM VW_DEPT_EMP 
ORDER BY depto
 
SELECT * FROM VW_DEPT_EMP WHERE qtde > 20
 
SELECT ROWNUM, first_name, salary FROM employees
WHERE salary < 5000
 
desc employees
 
SELECT ROWNUM, first_name, salary FROM employees ORDER BY salary
 
SELECT ROWNUM, first_name, salary 
FROM (SELECT first_name, salary FROM employees ORDER BY salary DESC) 
WHERE ROWNUM <= 5
 
SELECT ROWNUM, first_name, salary 
FROM (SELECT first_name, salary FROM employees ORDER BY salary ASC) 
WHERE ROWNUM <= 3
 
CREATE OR REPLACE VIEW vw_ranking (nome, salario)
AS 
SELECT first_name, salary
FROM (SELECT first_name, salary FROM employees ORDER BY salary ASC)
WHERE ROWNUM <= 10
 
CREATE OR REPLACE VIEW empvu30
AS
SELECT * FROM employees
WHERE department_id = 30
WITH CHECK OPTION Constraint empvu30_ck
 
SELECT * FROM empvu30
 
UPDATE empvu30 SET department_id = 50 WHERE employee_id = 114