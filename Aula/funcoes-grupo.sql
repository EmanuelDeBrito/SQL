SELECT COUNT(*) AS "Quantidade de Funcionários", COUNT(employee_id) AS "Quantidade de Funcionários", SUM(salary) AS "Soma dos salários", AVG(salary) AS "Média dos salários", MIN(salary) AS "Menor salário", MAX(salary) AS "Maior salário" 
FROM employees
 
SELECT 691416 / 107 FROM dual
 
SELECT ROUND(691416, 2) FROM dual
 
SELECT ROUND(AVG(salary, 2)) AS "Média dos salários" FROM employees
 
SELECT COUNT(employee_id) AS "Quantidade de Funcionários", 
ROUND(SUM(salary), 2) AS "Soma dos salários", 
ROUND(AVG(salary), 2) AS "Média dos salários", 
MIN(salary) AS "Menor salário", 
MAX(salary) AS "Maior salário" 
FROM employees WHERE department_id = 50
 
-- Errado
SELECT department_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários", ROUND(AVG(salary), 2) AS "Média dos salários", MIN(salary) AS "Menor salário", MAX(salary) AS "Maior salário" 
FROM employees
 
-- Funciona mas você não sabe a qual departamento pertence
SELECT COUNT(employee_id) AS "Quantidade de Funcionários", ROUND(SUM(salary), 2) AS "Soma dos salários", ROUND(AVG(salary), 2) AS "Média dos salários", MIN(salary) AS "Menor salário", MAX(salary) AS "Maior salário" 
FROM employees 
GROUP BY department_id
 
-- Funciona e aparece a qual departamento pertence
SELECT department_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees 
GROUP BY department_id 
ORDER BY department_id
 
SELECT department_id, job_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees 
GROUP BY department_id, job_id
ORDER BY department_id
 
-- Só funciona na Oracle
SELECT department_id, job_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees 
GROUP BY ROLLUP (department_id, job_id)
ORDER BY department_id
 
-- Errado
SELECT department_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees
WHERE SUM(salary) > 20000
GROUP BY department_id
ORDER BY department_id
 
-- Having é só para restrição de grupo
SELECT department_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 20000
ORDER BY department_id
 
SELECT department_id, COUNT(employee_id) AS "Quantidade de Funcionários",  ROUND(SUM(salary), 2) AS "Soma dos salários",  ROUND(AVG(salary), 2) AS "Média dos salários",  MIN(salary) AS "Menor salário",  MAX(salary) AS "Maior salário" 
FROM employees
WHERE department_id IN (50, 60)
GROUP BY department_id
HAVING SUM(salary) > 20000
ORDER BY department_id
 
DESC employees