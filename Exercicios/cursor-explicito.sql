-- EXERCÍCIOS

-- Criar um bloco que entre com o id do cargo e exiba o sobrenome dos funcionários que possuem este cargo
DECLARE
    v_id employees.job_id%TYPE := :jobId; -- Variável de entrada
    v_last_name employees.last_name%TYPE; -- Variável de saída
CURSOR exemplo1 IS
  SELECT last_name
  FROM employees
  WHERE job_id = v_id;
BEGIN
    OPEN exemplo1;
    LOOP
    FETCH exemplo1 INTO v_last_name;
    EXIT WHEN exemplo1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_last_name);
    END LOOP;
    CLOSE exemplo1;
END;
 
-- Criar uma tabela TEMPORARIA
CREATE TABLE temporaria
(
    id INTEGER PRIMARY KEY,
    nome VARCHAR(60) NOT NULL,
    salanual NUMBER(8,2)
);
 
-- Criar um bloco que insira na tabela TEMPORÁRIA o id, o nome e o salário anual (salario *12) Obs. não há variável de entrada. Buscar todos os registros da tabela EMPLOYEES
DECLARE
    v_id employees.id%TYPE; -- Variável de saída
    v_nome employees.first_name%TYPE; -- Variável de saída
    v_salario_anual employees.salary%TYPE; -- Variável de saída
    CURSOR exemplo1 IS
    SELECT employee_id, first_name, salary * 12 
    FROM employees
BEGIN
    OPEN exemplo1;
    LOOP
    FETCH exemplo1 INTO v_id, v_nome, v_salario_anual;
    EXIT WHEN exemplo1%NOTFOUND;
    INSERT INTO temporaria(id, nome, salanual)
    VALUES (v_id, v_nome, v_salario_anual);
    END LOOP;
    COMMIT;
    CLOSE exemplo1;
END;
 
-- Criar um bloco que exibe o id e o nome de todos os empregados usando o cursor com registro:
DECLARE
    CURSOR cursor1 IS
    SELECT employee_id, last_name 
    FROM employees;
    registro cursor1%ROWTYPE;
BEGIN
    OPEN cursor1;
    LOOP
    FETCH cursor1 INTO registro;
        EXIT WHEN cursor1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(registro.employee_id || ' - ' || registro.last_name);
    END LOOP;
    CLOSE cursor1;
END;
 
EXERCÍCIO
 
-- Criar um bloco (usando cursor como registro) que informe o id do pais (country_id) e exiba a cidade (city) localizadas neste pais informado.
DECLARE
    v_country_id locations.country_id%TYPE := :countryId;
    CURSOR cursor1 IS
    SELECT country_id, city 
    FROM locations
    WHERE country_id = v_country_id;
    registro cursor1%ROWTYPE;
BEGIN
    OPEN cursor1;
    DBMS_OUTPUT.PUT_LINE('ID do País: ' || v_country_id);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
LOOP
  FETCH cursor1 INTO registro;
  EXIT WHEN cursor1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE('Cidade: ' || registro.city);
END LOOP;
CLOSE cursor1;
END;
 
-- Criar um bloco que recupere todos os funcionários que estão trabalhando no depto. com id 80
DECLARE
    CURSOR cursor1 IS
    SELECT first_name, department_id 
    FROM employees;
BEGIN
FOR registro_for IN cursor1 LOOP
  IF registro_for.department_id = 80 THEN
   DBMS_OUTPUT.PUT_LINE(registro_for.first_name || ' trabalha com vendas');
  END IF;
END LOOP;
END;
 
-- Criar um bloco que exiba o nome dos funcionários que trabalham com id do cargo informado (usar o cursor com FOR). 
DECLARE
    v_job_id employees.job_id%TYPE := :jobId;
    CURSOR cursor1 IS
    SELECT first_name, last_name 
    FROM employees
    WHERE job_id = v_job_id;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Empregados do cargo: ' || v_job_id);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    FOR empregado IN cursor1 LOOP
    DBMS_OUTPUT.PUT_LINE(empregado.first_name || ' ' || empregado.last_name);
    END LOOP;
END;
 
USO DE ROWCOUNT
 
-- Criar um bloco que informe o id do país e exiba somente 2 cidades que se encontram no país informado.
 
DECLARE
    v_country_id locations.country_id%TYPE := :countryId;
    CURSOR cursor1 IS
    SELECT city 
    FROM locations
    WHERE country_id = v_country_id;
    registro cursor1%ROWTYPE;
BEGIN
    OPEN cursor1;
    DBMS_OUTPUT.PUT_LINE('ID do País: ' || v_country_id);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
    LOOP
    FETCH cursor1 INTO registro;
    EXIT WHEN cursor1%NOTFOUND OR cursor1%ROWCOUNT > 2;
    DBMS_OUTPUT.PUT_LINE('Cidade: ' || registro.city);
    END LOOP;
    CLOSE cursor1;
END;