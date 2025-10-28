-- Exercícios 22/10/25
 
-- Exibir todos os nomes de departamentos com apelido em ordem alfabética:
SELECT department_name AS "Nome do Departamento" FROM hr.departments ORDER BY department_name
 
-- Exibir o id e o título do cargo com apelido nas colunas
SELECT job_id AS "Código do trabalho", job_title AS "Título do trabalho" FROM hr.jobs
 
-- Exibir o id do empregado, o id do cargo e o sobrenome de quem tem o sobrenome iniciado com a letra M
SELECT employee_id, job_id, last_name FROM hr.employees WHERE last_name LIKE 'M%'
 
-- Exibir o id do empregado, o id do cargo e o sobrenome de quem tem o sobrenome terminado com a letra e.
SELECT employee_id, job_id, last_name FROM hr.employees WHERE last_name LIKE '%e'
 
-- Exibir o sobrenome, o id do departamento, o id do cargo dos empregados que trabalham como ST_CLERK
SELECT last_name, department_id, job_id FROM hr.employees WHERE job_id = 'ST_CLERK'
 
-- Exibir o sobrenome, o id do departamento, o id do cargo dos empregados que trabalham como ST_CLERK ou como IT_PROG
SELECT last_name, department_id, job_id FROM hr.employees WHERE job_id = 'ST_CLERK' OR job_id = 'IT_PROG'
 
-- Exibir uma lista exclusiva dos departamentos que possuem empregados.
SELECT DISTINCT department_id AS "Código do departamento" FROM hr.employees WHERE department_id IS NOT NULL
 
-- Exibir o id do empregado, o id do cargo e o id do departamento concatenado com o apelido chamado INFORMACOES DO EMPREGADO
SELECT employee_id || ' - ' || job_id || ' - ' || department_id AS "Informações do empregado" FROM hr.employees
 
-- Exibir o id do empregado, o id do cargo e o sobrenome de quem tem o id do cargo MAN em qualquer posição
SELECT employee_id, job_id, last_name FROM hr.employees WHERE job_id LIKE '%MAN%'
 
-- Exibir o id do departamento, o id da localização e o id dos gerentes que não trabalham nos departamentos com id entre 80 e 150
SELECT department_id, location_id, manager_id FROM hr.departments WHERE department_id NOT BETWEEN 80 AND 150

-- Exibir o nome e o sobrenome dos empregados que trabalham nos departamentos entre 40 e 80
SELECT first_name, last_name FROM hr.employees WHERE department_id BETWEEN 40 AND 80

-- Exibir o nome das cidades com apelido que terminam com a letra n
SELECT city as "Cidades" FROM hr.locations WHERE city LIKE '%n'

-- Exibir o id e o nome do continente em ordem alfabética pelo nome
SELECT region_id, region_name FROM hr.regions ORDER BY region_name

-- Exibir todos os departamentos que estão localizados no id = 1700 ordenados pelo id em ordem decrescente
SELECT * FROM hr.departments WHERE location_id = 1700 ORDER BY department_id DESC

-- Exibir o id, a data de admissão de quem foi admitido no dia 10 ou no dia 15 ordenado pela data
SELECT employee_id, hire_date FROM hr.employees WHERE hire_date LIKE '10%' OR hire_date LIKE '15%' ORDER BY hire_date

-- Exibir o nome dos empregados, a data de admissao, e o salario e uma coluna de valor de INSS que será 6% sobre o salario colocar apelido VALE TRANSPORTE, ordenado pelo salario.
SELECT first_name || ' ' || last_name AS "Nome Completo", hire_date, salary, salary * 0.06 AS "Vale Transporte" FROM hr.employees ORDER BY salary

-- Exibir todas as informações da tabela JOB_HISTORY concatenadas com , com um apelido chamado HISTORICO
SELECT employee_id || ', ' || start_date || ', ' || end_date || ', ' || job_id || ', ' || department_id AS "Histórico" FROM hr.job_history

-- Exibir id do empregado e o id do departamento dos empregados que trabalham com id entre 100 e 150
SELECT employee_id, department_id FROM hr.employees WHERE employee_id BETWEEN 100 AND 150

-- Exibir id do empregado e o sobrenome dos empregados que trabalham com id maior que 160 ordenados pelo id do empregado e pelo sobrenome (usar a posição do select)
SELECT employee_id, last_name FROM hr.employees WHERE employee_id > 160 ORDER BY 1, 2

-- Exibir id do empregado e o id do job dos empregados que não trabalham como ST_CLERK
SELECT employee_id, job_id FROM hr.employees WHERE job_id != 'ST_CLERK'

-- Exibir o id do departamento, o id da localizacao e o id dos gerentes que trabalham nos departamentos com id entre 80 e 150
SELECT department_id, location_id, manager_id FROM hr.departments WHERE department_id BETWEEN 80 AND 150

-- Exibir o nome das cidades com apelido que iniciam com a letra B
SELECT city AS "Cidades" FROM hr.locations WHERE city LIKE 'B%'

-- Exibir o id e o nome do continente em ordem alfabética pelo nome com apelido nas colunas.
SELECT region_id AS "ID do continente", region_name AS "Nome do continente" FROM hr.regions ORDER BY region_name

-- Exibir uma lista exclusiva dos id’s de gerentes que possuem empregados subordinados a ele.
SELECT DISTINCT manager_id FROM hr.employees WHERE manager_id IS NOT NULL

-- Exibir o id do empregado, o id do cargo e o sobrenome de quem tem o id do cargo terminado com CLERK
SELECT employee_id, job_id, last_name FROM hr.employees WHERE job_id LIKE '%CLERK'

-- Exibir o nome dos empregados, a data de admissao, e o salario de quem foi admitido em outubro de 2000
SELECT first_name || ' ' || last_name AS "Nome Completo", hire_date, salary FROM hr.employees WHERE hire_date LIKE '%OCT-00'

-- Exibir o nome dos empregados, a data de admissao, e o salario e uma coluna de valor de INSS que será 8% sobre o salario colocar apelido INSS
SELECT first_name || ' ' || last_name AS "Nome Completo", hire_date, salary, salary * 0.08 AS "INSS" FROM hr.employees

-- Exibir o nome dos empregados, a data de admissao, e o salario e uma coluna de valor de INSS que será 8% sobre o salario colocar apelido INSS e o vale transporte com 6% sobre o salario com apelido VALE na coluna
SELECT first_name || ' ' || last_name AS "Nome Completo", hire_date, salary, salary * 0.08 AS "INSS", salary * 0.06 AS "Vale Transporte" FROM hr.employees
 
-- Describes    
DESC hr.departments
DESC hr.jobs
DESC hr.employees
DESC hr.locations
DESC hr.regions
DESC hr.job_history
 
-- Selects
SELECT * FROM hr.departments
SELECT * FROM hr.jobs
SELECT * FROM hr.employees
SELECT * FROM hr.locations
SELECT * FROM hr.regions
SELECT * FROM hr.job_history