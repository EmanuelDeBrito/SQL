SELECT COUNT(*), department_id FROM employees GROUP BY department_id
 
SELECT SUM(salary), manager_id FROM employees GROUP BY manager_id HAVING SUM(salary) > 15000
 
SELECT ROUND(45.789,2), TRUNC(45.789,2) FROM dual
 
SELECT ROUND(45.789), TRUNC(45.789) FROM dual
 
SELECT MOD(1453, 2), POWER(6,2), SQRT(6) FROM dual
 
-- Exercício
SELECT MOD(1453, 2), POWER(6,2), TRUNC(SQRT(6)) FROM dual
 
-- O maior poder de um banco de dados são as datas
SELECT SYSDATE AS "ORACLE", CURRENT_DATE AS "ANSI" FROM dual
 
SELECT hire_date, LAST_DAY(hire_date), TRUNC(hire_date, 'month') FROM employees WHERE manager_id IS NULL
 
-- Todo calculo de datas em um banco é feito em dias
SELECT SYSDATE + 7, CURRENT_DATE - 10, SYSDATE + 365.25 FROM dual
 
SELECT ADD_MONTHS(SYSDATE, 2), ADD_MONTHS(SYSDATE, -5) FROM dual
 
-- Data da próxima terça feira
SELECT NEXT_DAY(SYSDATE, 'tue') FROM dual
 
SELECT MONTHS_BETWEEN(SYSDATE, hire_date) FROM employees WHERE department_id NOT BETWEEN 10 AND 20
 
SELECT ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) FROM employees WHERE department_id NOT BETWEEN 10 AND 20
 
-- ROUND - Manda para o mais próximo
-- TRUNC - Mântem do atual
 
SELECT TRUNC(SYSDATE, 'month'), ROUND(SYSDATE, 'month') FROM dual
 
SELECT TRUNC(SYSDATE, 'year'), ROUND(SYSDATE, 'year') FROM dual
 
SELECT TRUNC(SYSDATE - 750, 'month'), ROUND(SYSDATE - 750, 'month') FROM dual
 
SELECT CURRENT_TIMESTAMP FROM dual
 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'Month') FROM dual
 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD'), TO_CHAR(SYSDATE, 'DY'), TO_CHAR(SYSDATE, 'Day') FROM dual
 
-- Ano sempre em inglês independente da língua
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YEAR'), TO_CHAR(SYSDATE, 'RRRR') FROM dual
 
-- Exibindo no formato de até 12 e formato de 24
SELECT TO_CHAR(SYSDATE, 'HH12:MI:SS'), TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM dual
 
SELECT first_name, TO_CHAR(salary, '999,999.99'), TO_CHAR(salary, '000,000.00') FROM employees ORDER BY first_name
 
SELECT employee_id, salary, commission_pct, salary * commission_pct AS "Comissão", salary + (salary * comMission_pct) AS "Salário Líquido" FROM employees ORDER BY salary DESC
 
-- Substituindo valores nulos com a função NVL(coluna, valorNovo)
SELECT employee_id, salary, NVL(commission_pct, 0), salary * NVL(commission_pct, 0) AS "Comissão", salary + (salary * NVL(commission_pct, 0)) AS "Salário Líquido" FROM employees ORDER BY salary DESC
 
-- DECODE(somente no Oracle)
SELECT employee_id, salary, job_id, DECODE(job_id, 'IT_PROG', salary * 1.10, 'ST_CLERK', salary * 1.05, salary) AS "Projeção" FROM employees
 
-- CASE(padrão ANSI todos os bancos)
SELECT employee_id, salary, job_id, CASE job_id WHEN 'IT_PROG' THEN salary * 1.10 WHEN 'ST_CLERK' THEN salary * 1.05 ELSE salary END AS "Projeção" FROM employees
 
SELECT first_name, TO_CHAR(ADD_MONTHS(hire_date, 6), 'Day, DD, Month, YYYY') FROM employees
 
SELECT * FROM employees