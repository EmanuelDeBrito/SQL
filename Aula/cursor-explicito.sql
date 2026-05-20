-- CURSORES EXPLÍCITOS
 
-- Criar um bloco anônimo que informe o id do depto e exiba o nome do empregado e o título do seu cargo dos funcionários que trabalham neste depto. TESTE: 10, 20, 30, 40, 50, 60, 70
DECLARE
v_depto INTEGER := :departamento; -- Variável de entrada
v_nome VARCHAR(30); -- Variável de saída
v_cargo jobs.job_title%TYPE; -- Variável de saída
CURSOR exemplo1 IS
  SELECT e.first_name, j.job_title 
  FROM employees e JOIN jobs j
  ON (e.job_id = j.job_id)
  WHERE e.department_id = v_depto;
BEGIN
OPEN exemplo1;
LOOP
  FETCH exemplo1 INTO v_nome, v_cargo;
  EXIT WHEN exemplo1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(v_nome || ' trabalha como ' || v_cargo);
END LOOP;
CLOSE exemplo1;
END;
 
-- Criar uma tabela chamada FUNC
CREATE TABLE FUNC
(id INTEGER PRIMARY KEY,
nome VARCHAR(60) NOT NULL,
vale_compra NUMBER(8,2))
 
/*
    Criar um bloco anônimo que informe o id do gerente (manager_id) e busque o id, o nome completo dos 
    funcionários (first_name e last_name) e o salário do funcionário gerenciado pelo gerente informado.
    O vale_compra será 5% sobre o salário do empregado. Inserir os dados na tabela FUNC.
*/
DECLARE
v_id employees.manager_id%TYPE := :gerente; -- Variável de entrada
v_emp INTEGER;
v_nome VARCHAR(100);
v_salario NUMBER(10, 2);
CURSOR exemplo1 IS
  SELECT employee_id, first_name || '' || last_name, salary * 0.5
  FROM employees
  WHERE manager_id = v_id;
BEGIN
OPEN exemplo1;
LOOP
  FETCH exemplo1 INTO v_emp, v_nome, v_salario;
  EXIT WHEN exemplo1%NOTFOUND;
  INSERT INTO func (id, nome, vale_compra)
  VALUES (v_emp, v_nome, v_salario);
END LOOP;
COMMIT;
CLOSE exemplo1;
END;

