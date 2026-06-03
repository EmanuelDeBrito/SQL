-- Criar um bloco que entre com o id do empregado (inicia 100,101, etc) e exiba:
-- Se for entre 100 e 110 exibir o nome do empregado
-- Se for entre 111 e 120  exibir o nome do departamento
-- Caso contrário exibir o nome, o salário e o nome do departamento
-- EMPLOYEES (employee_id, first_name, salary, hire_date, department_id)
-- DEPARTMENTS (department_id, department_name)
 
DECLARE
  v_id PLS_INTEGER := :employee_id;
  v_nome VARCHAR(100);
  v_salario NUMBER(10, 2);
  v_departamento VARCHAR(50);
BEGIN
  SELECT E.first_name, E.salary, D.department_name
  INTO v_nome, v_salario, v_departamento
  FROM employees E 
  JOIN departments D
  ON (E.department_id = D.department_id)
  WHERE E.employee_id = v_id;
  IF v_id BETWEEN 100 AND 110 THEN
    DBMS_OUTPUT.PUT_LINE('Nome do funcionário: ' || v_nome);
  ELSIF v_id BETWEEN 111 AND 120 THEN
    DBMS_OUTPUT.PUT_LINE('Departamento do funcionário: ' || v_departamento);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Nome do funcionário: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Departamento do funcionário: ' || v_departamento);
    DBMS_OUTPUT.PUT_LINE('Salário do funcionário: R$ ' || v_salario);
  END IF;
END;

 
-- Crie um bloco anônimo que informe um número e verifique se o número é par ou ímpar
 DECLARE
  v_numero PLS_INTEGER := :numero;
BEGIN
  IF MOD(v_numero, 2) = 0 THEN
    DBMS_OUTPUT.PUT_LINE('O número ' || v_numero || ' é par');
  ELSE
    DBMS_OUTPUT.PUT_LINE('O número ' || v_numero || ' é ímpar');
  END IF;
END;
 
-- Criar uma tabela chamada números com a coluna número INTEGER. Criar um bloco que insira números de 1 a 10, excluindo os números 6 e 8.
BEGIN
  DELETE FROM numeros;
  COMMIT;
  FOR i IN 1..10 LOOP
    IF i != 6 AND i != 8 THEN
      INSERT INTO numeros VALUES (i);
    END IF;
  END LOOP;
END;
 
-- Criar um bloco anônimo que informe um número de 1 a 10 e exiba a tabuada. Obs. Deve ter uma restrição para aceitar somente números de 1 a 10.
DECLARE
  v_numero PLS_INTEGER := :numero;
BEGIN
  IF v_numero >= 1 AND v_numero <= 10 THEN
    DBMS_OUTPUT.PUT_LINE('Tabuada do ' || v_numero);
    FOR i IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(v_numero || 'x' || i || ' = ' || v_numero * i);
    END LOOP;
  ELSE
    DBMS_OUTPUT.PUT_LINE('O número passado deve ser entre 1 a 10');
  END IF;
END;
 
-- Exibir todas as tabuadas de 1 a 10.
BEGIN
  FOR i IN 1..10 LOOP
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Tabuada do ' || i);
    FOR j IN 1..10 LOOP
      DBMS_OUTPUT.PUT_LINE(i || 'x' || j || ' = ' || i * j);
    END LOOP;  
  END LOOP;
END;