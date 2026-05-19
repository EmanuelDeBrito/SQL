-- EXERCÍCIO
-- EXERCISE

/* 
  Criar um pacote chamada pk_exercicio que tenha uma procedure chamada
  prc_resumo que informe o id do depto e exiba a soma salarial e a quantidade de empregados.
*/
 
-- A) Criar a especificação;

-- ESPECIFICAÇÃO 
CREATE OR REPLACE PACKAGE pk_exercicio IS
PROCEDURE prc_resumo(v_departamento IN INTEGER);
END;
 
-- B) Criar o corpo;

-- CORPO
CREATE OR REPLACE PACKAGE BODY pk_exercicio IS
PROCEDURE prc_resumo(v_departamento IN INTEGER) IS
  v_soma NUMBER(10, 2);
  v_quantidade INTEGER;
BEGIN
  SELECT SUM(salary), COUNT(employee_id)
  INTO v_soma, v_quantidade
  FROM employees
  WHERE department_id = v_departamento;
  DBMS_OUTPUT.PUT_LINE('Departamento - ' || v_departamento);
  DBMS_OUTPUT.PUT_LINE('Soma salarial: R$' || v_soma);
  DBMS_OUTPUT.PUT_LINE('Quantidade de funcionários: ' || v_quantidade);
END prc_resumo;
END;
 
-- C) Executar a package
EXECUTE pk_exercicio.prc_resumo(40);