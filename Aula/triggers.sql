-- PACKAGES E TRIGGERS
 
-- Recriar o exemplo do pacote no APEX: Primeiro a especificação e depois o corpo.
 
CREATE OR REPLACE PACKAGE pk_emp IS
    PROCEDURE prc_emp(v_id IN INTEGER);
    PROCEDURE prc_dept(v_depto IN INTEGER);
END;
 
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
 
-- Executar a package no APEX:
 
-- Procedure prc_emp:
BEGIN
    pk_emp.prc_emp(100);
END;
 
-- Procedure prc_dept:
BEGIN
    pk_emp.prc_dept(50);
END;
 
-- TRIGGERS
 
/*
    Criar um gatilho (TRIGGER) chamado tg_seguranca para restringir as inserções 
    na tabela EMPLOYEES de segunda a sexta-feira das 8h às 12h. Se um usuário tentar 
    inserir no sábado, domingo ou fora do horário, o gatilho falhará e a instrução sofrerá rollback.
*/
CREATE OR REPLACE TRIGGER tg_seguranca
BEFORE INSERT ON employees
BEGIN
    IF (TO_CHAR(sysdate, 'DY') IN ('SAT', 'SUN')) OR (TO_CHAR(sysdate, 'HH24') NOT BETWEEN '08' AND '12') THEN 
	RAISE_APPLICATION_ERROR(-20500, 'Somente poderá cadastrar empregados no horário comercial.');
    END IF;
END;
 
-- Para testar vamos fazer um insert explícito na tabela EMPLOYEES:
INSERT INTO employees (employee_id, last_name, email, hire_date, job_id) VALUES (777, 'Brito', 'brito@gmail.com', SYSDATE, 'IT_PROG')
 
-- Desabilitar a trigger
ALTER TRIGGER tg_seguranca DISABLE
 
-- Inserir o registro
INSERT INTO employees (employee_id, last_name, email, hire_date, job_id) VALUES (777, 'Brito', 'brito@gmail.com', SYSDATE, 'IT_PROG')
 
-- Habilitando novamente a TRIGGER
ALTER TRIGGER tg_seguranca ENABLE
 
-- Consultar as triggers no dicionário de dados
SELECT TRIGGER_NAME, TRIGGER_TYPE, TABLE_NAME, COLUMN_NAME
FROM USER_TRIGGERS
 
-- Selecionando código da TRIGGER
SELECT TEXT
FROM USER_SOURCE
WHERE NAME = 'TG_SEGURANCA'
 
-- Excluir a TRIGGER tg_seguranca
DROP TRIGGER tg_seguranca
 
/*
  Criar um gatilho TG_VERIFICA_SALARIO para permitir que somente determinados funcionários, 
  com cargos como IT_PROG ou ST_CLERK, possam receber salários abaixo de 10000. 
  Se um usuário tentar fazer isto, o gatilho gera um erro.
*/
CREATE OR REPLACE TRIGGER tg_verifica_salario
BEFORE INSERT OR UPDATE OF salary ON employees
FOR EACH ROW
BEGIN
    IF NOT(:NEW.JOB_ID IN ('ST_CLERK', 'IT_PROG')) AND :NEW.SALARY < 1000 THEN
        RAISE_APPLICATION_ERROR(-20202, 'Este empregado não pode ter esse salário.');
    END IF;
END;
 
-- Atualizar o salario do empregado com id 201 para 500.00:
UPDATE employees
SET salary = 500.00
WHERE employee_id = 201
 
-- Excluir a trigger
DROP TRIGGER tg_verifica_salario
 
-- Criar a tabela a seguir:
CREATE TABLE auditoria
(
usuario varchar2(50),
data      date,
nome_antigo varchar2(50),
nome_novo varchar2(50),
cargo_antigo varchar2(30),
cargo_novo varchar2(30),
salario_antigo number(7,2),
salario_novo number(7,2)
);
 
/*
    Criar um gatilho tg_auditoria na tabela EMPLOYEES para adicionar linhas a uma tabela de usuário AUDITORIA, 
    fazendo log da atividade com a tabela EMPLOYEES. O gatilho registra os valores de diversas colunas antes 
    e depois das alterações de dados, usando os qualificadores :OLD e :NEW com o respectivo nome de coluna.
*/
CREATE OR REPLACE TRIGGER tg_auditoria
AFTER DELETE OR INSERT OR UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO auditoria 
    VALUES(USER, SYSDATE, :OLD.first_name, :NEW.first_name, :OLD.job_id, :NEW.job_id, :OLD.salary, :NEW.salary);
END;
 
-- Atualizar o salario do empregado com id 123 com aumento de 50%
UPDATE employees
SET salary = salary * 1.5
WHERE employee_id = 123
 
 
-- Atualizar o salario dos empregados com id entre 100 e 150 com aumento de 10%
UPDATE employees
SET salary = salary * 1.5
WHERE employee_id = 123
 
-- Consultar a tabela AUDITORIA
SELECT * FROM auditoria
 
-- Atualizar o salario dos empregados com id entre 100 e 150 com aumento de 10%
UPDATE employees
SET salary = salary * 1.10
WHERE employee_id BETWEEN 100 AND 150
 
-- Consultar a tabela AUDITORIA
SELECT * FROM auditoria