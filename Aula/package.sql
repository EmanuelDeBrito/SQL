-- APRENDENDO SOBRE PACKAGES
-- LEARNING ABOUT PACKAGES
 
-- Exibir o conteúdo da PACKAGE DBMS_OUTPUT: DESC
DESC DBMS_OUTPUT
 
-- Criar um pacote chamado pk_emp que tenha:
 
-- Procedure prc_emp que entre com o id do empregado e exiba o nome e o  título do cargo
PROCEDURE prc_emp(v_id IN INTEGER) IS
    v_nome VARCHAR(50);
    v_cargo VARCHAR(30);
BEGIN
    SELECT e.first_name, j.job_title
    INTO v_nome, v_cargo
    FROM employees e
    JOIN jobs j ON (e.job_id = j.job_id)
    WHERE e.employee_id = v_id;
    DBMS_OUTPUT.PUT_LINE(v_nome || ' trabalha como ' || v_cargo);
END prc_emp;
 
-- Procedure prc_dept que informe o id do depto e traga o sobrenome, salário e o valor de comissão.
PROCEDURE prc_dept(v_depto IN INTEGER) IS
    v_sobrenome VARCHAR(30);
    v_salario NUMBER(10, 2);
    v_percentual NUMBER(10, 2);
    v_com NUMBER(10, 2);
    CURSOR cursor1 IS
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE department_id = v_depto;
BEGIN
    OPEN cursor1;
    LOOP
        FETCH cursor1 INTO v_sobrenome, v_salario, v_percentual;
        EXIT WHEN cursor1%NOTFOUND;
        v_com := fnc_com(v_salario, v_percentual);
        DBMS_OUTPUT.PUT_LINE('Sobrenome: ' || v_sobrenome);
        DBMS_OUTPUT.PUT_LINE('Salário: R$' || v_salario);
        DBMS_OUTPUT.PUT_LINE('Comissão: R$' || v_com);
        DBMS_OUTPUT.PUT_LINE('Valor total: R$' || v_salario + v_com);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    CLOSE cursor1;
END prc_dept;
 
-- Function fnc_com que de acordo com o salário e o percentual de comissão retorne o valor de comissão a receber:
FUNCTION fnc_com(v_sal IN NUMBER, v_perc IN NUMBER)
RETURN NUMBER
IS
    v_comissao NUMBER(10, 2);
BEGIN
    v_comissao := (v_sal * NVL(v_perc, 0));
    RETURN (v_comissao);
END fnc_com;
 
-- ESPECIFICAÇÃO - (Na especificação não tem function, somente procedure)
CREATE OR REPLACE PACKAGE pk_emp IS
    PROCEDURE prc_emp(v_id IN INTEGER);
    PROCEDURE prc_dept(v_depto IN INTEGER);
END;
 
-- CORPO
CREATE OR REPLACE PACKAGE BODY pk_emp IS
FUNCTION fnc_com(v_sal IN NUMBER, v_perc IN NUMBER)
RETURN NUMBER
IS
  v_comissao NUMBER(10, 2);
BEGIN
  v_comissao := (v_sal * NVL(v_perc, 0));
  RETURN (v_comissao);
END fnc_com;
PROCEDURE prc_emp(v_id IN INTEGER) IS
  v_nome VARCHAR(50);
  v_cargo VARCHAR(30);
BEGIN
  SELECT e.first_name, j.job_title
  INTO v_nome, v_cargo
  FROM employees e
  JOIN jobs j ON (e.job_id = j.job_id)
  WHERE e.employee_id = v_id;
  DBMS_OUTPUT.PUT_LINE(v_nome || ' trabalha como ' || v_cargo);
END prc_emp;
PROCEDURE prc_dept(v_depto IN INTEGER) IS
  v_sobrenome VARCHAR(30);
  v_salario NUMBER(10, 2);
  v_percentual NUMBER(10, 2);
  v_com NUMBER(10, 2);
  CURSOR cursor1 IS
  SELECT last_name, salary, NVL(commission_pct, 0)
  FROM employees
  WHERE department_id = v_depto;
BEGIN
  OPEN cursor1;
  LOOP
   FETCH cursor1 INTO v_sobrenome, v_salario, v_percentual;
   EXIT WHEN cursor1%NOTFOUND;
   v_com := fnc_com(v_salario, v_percentual);
   DBMS_OUTPUT.PUT_LINE('Sobrenome: ' || v_sobrenome);
   DBMS_OUTPUT.PUT_LINE('Salário: R$' || v_salario);
   DBMS_OUTPUT.PUT_LINE('Comissão: R$' || v_com);
   DBMS_OUTPUT.PUT_LINE('Valor total: R$' || (v_salario + v_com));
   DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  END LOOP;
  CLOSE cursor1;
END prc_dept;
END;
 
-- Descrever o pacote
DESC pk_emp;
 
-- Executando o pacote (Erro por causa da função NVL)
EXECUTE pk_emp.prc_dept(40);
 
-- Habilitando o pacote DBMS
SET SERVEROUTPUT ON;
 
-- Executando o pacote
EXECUTE pk_emp.prc_emp(101);
 
-- Consultar todos os objetos do tipo PACKAGE
SELECT OBJECT_TYPE, OBJECT_NAME 
FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'PACKAGE';
 
-- Excluir PACKAGE
 
-- CORPO
DROP PACKAGE BODY pk_emp;
 
-- CABEÇA
DROP PACKAGE pk_emp;