-- SUBQUERY

-- 1) Exibir o sobrenome e o salário de quem ganha mais que o Abel
 
-- Quanto Abel ganha?
SELECT salary FROM employees WHERE last_name = 'Abel';
 
-- Exibir quem ganha mais que ele?
SELECT last_name, salary FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');
 
-- Alterar o salario dele em 10%
UPDATE employees SET salary = salary * 1.10 WHERE last_name = 'Abel';
 
-- Executar novamente a subquerie
SELECT last_name, salary FROM employees WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');
 
-- 2) Exibir o sobrenome e o id do cargo dos empregados que possuem o MESMO CARGO (=) que o empregado com id 141?
 
-- Qual é o cargo do id 141?
SELECT job_id FROM employees WHERE employee_id = 141
 
-- Exibir quem tem o mesmo cargo dele:
SELECT last_name, job_id FROM employees WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141);
 
-- 3) Exibir o sobrenome, o id do cargo, salario, o id do departamento
de quem tem o mesmo cargo do empregado do id 141 e que tem o salario maior que o do empregado com sobrenome Tobias
 
-- Qual é o salario do Tobias?
SELECT salary FROM employees WHERE last_name = 'Tobias';
 
-- Query com subqueries:
SELECT last_name, job_id, salary, department_id FROM employees WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141) AND salary > (SELECT salary FROM employees WHERE last_name = 'Tobias');
 
-- 3) Subquery com Funções de Grupo e Join

-- Exibir o sobrenome e o título do cargo (join)
SELECT last_name, job_title FROM employees e, jobs j WHERE e.job_id = j.job_id;
 
-- Exibir o menor salário da empresa (FUNCAO MIN):
SELECT MIN(salary) FROM employees;
 
-- 5) Exibir o id do cargo e a média salarial somente de quem ganha igual ao menor salario médio da empresa 

-- Qual o menor salário médio da empresa?
SELECT job_id, MIN(AVG(salary)) FROM employees GROUP BY job_id ORDER BY 2;
 
-- Subquery usando a Clausula HAVING
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id HAVING AVG(salary) = (SELECT MIN(AVG(salary)) FROM employees GROUP BY job_id)
 
-- 6) Exibir o nome, o salário e o id do depto. dos empregados que ganham salário mínimo, independente do depto.

-- Qual o salário mínimo de cada depto. (tem group by)
SELECT MIN(salary) FROM employees GROUP BY department_id;
 
-- Subquery
SELECT first_name, salary, department_id FROM employees WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id) ORDER BY salary;
 
-- 7)Exibir todos os funcionarios que nao tenha NENHUM SUBORDINADO

-- Com Subquery
SELECT e.last_name FROM employees e WHERE e.employee_id NOT IN (SELECT g.manager_id FROM employees g WHERE g.manager_id IS NOT NULL);
 
SELECT e.last_name FROM employees e WHERE e.employee_id NOT IN (SELECT g.manager_id FROM employees g WHERE g.manager_id IS NULL);