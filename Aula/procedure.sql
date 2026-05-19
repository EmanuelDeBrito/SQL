-- PROCEDURES
 
-- Criar uma procedure chamada prc_emp que informe o id do empregado e exiba seu nome e o nome do depto. que ele trabalha
 
CREATE OR REPLACE PROCEDURE prc_emp(p_id IN INTEGER) IS
    v_nome VARCHAR(30);
    v_depto VARCHAR(50);
BEGIN
    SELECT e.first_name, d.department_name
    INTO v_nome, v_depto 
    FROM employees e, departments d
    WHERE e.employee_id = p_id
    AND e.department_id = d.department_id;
    DBMS_OUTPUT.PUT_LINE('Nome do empregado: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Número do departamento: ' || v_depto);
END;
 
-- Consultar a procedure prc_emp criada:
 
-- USER_OBJECTS
SELECT OBJECT_NAME, OBJECT_TYPE 
FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'PROCEDURE'
 
-- SCRIPT DA PROCEDURE:
SELECT TEXT
FROM USER_SOURCE
WHERE NAME = 'PRC_EMP'
 
-- OBJECT BROWSER:
-- Abrir na aba de OBJECT BROWSER
 
-- Executar a procedure prc_emp criada. TESTE: 100, 101, 102, 103,...)
 
-- No APEX
BEGIN
    PRC_EMP(100);
END;
 
-- Alterar para colocar um tratamento de exceção quando for informado um id inexistente
CREATE OR REPLACE PROCEDURE prc_emp(p_id IN INTEGER) IS
    v_nome VARCHAR(30);
    v_depto VARCHAR(50);
BEGIN
    SELECT e.first_name, d.department_name
    INTO v_nome, v_depto 
    FROM employees e, departments d
    WHERE e.employee_id = p_id
    AND e.department_id = d.department_id;
    DBMS_OUTPUT.PUT_LINE('Nome do empregado: ' || v_nome);
    DBMS_OUTPUT.PUT_LINE('Número do departamento: ' || v_depto);
    EXCEPTION WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('Empregado não existe');
END;
 
-- Alterar a procedure prc_emp para que o parâmetro seja o id do depto e exiba o nome do empregado, o título do cargo e o seu salário
CREATE OR REPLACE PROCEDURE prc_emp (p_depto IN INTEGER) IS
    v_nome VARCHAR(40);
    v_sal employees.salary%TYPE;
    v_cargo jobs.job_title%TYPE;
    CURSOR cursor1 IS
    SELECT e.first_name, e.salary, j.job_title
    FROM employees e, jobs j
    WHERE e.department_id = p_depto
    AND e.job_id = j.job_id;
BEGIN
    OPEN cursor1;
    LOOP
    FETCH cursor1 INTO v_nome, v_sal, v_cargo;
    EXIT WHEN cursor1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_nome || ' - ' || v_sal || ' - ' || v_cargo);
    END LOOP;
    CLOSE cursor1;
END;
 
-- É necessário habilitar o pacote DBMS:
SET SERVEROUTPUT ON
 
-- Para executar na LINHA DE COMANDO SQL:
 
-- EXECUTE:
EXECUTE prc_emp(80);
 
-- CALL:
CALL prc_emp(50);
 
-- Exibir os erros: 
SHOW ERRORS
 
-- Excluir a procedure prc_emp:
DROP PROCEDURE prc_emp;

/* 
    Criar uma procedure chamada prc_depto que de acordo com o depto informado exiba a quantidade de empregados 
    e a soma salarial POR cidade em que o departamento está localizado.
*/
CREATE OR REPLACE PROCEDURE prc_depto(p_depto IN INTEGER) IS
    v_cidade VARCHAR(50);
    v_quantidade_empregados INTEGER;
    v_soma_salarial NUMERIC(8, 2);
BEGIN
    SELECT l.city, COUNT(e.employee_id), SUM(e.salary)
    INTO v_cidade, v_quantidade_empregados, v_soma_salarial
    FROM employees e
    JOIN departments d ON(e.department_id = d.department_id)
    JOIN locations l ON(d.location_id = l.location_id)
    WHERE e.department_id = p_depto
    GROUP BY l.city;
    DBMS_OUTPUT.PUT_LINE('Número do departamento: ' || p_depto);
    DBMS_OUTPUT.PUT_LINE('Cidade: ' || v_cidade);
    DBMS_OUTPUT.PUT_LINE('Quantidade de empregados: ' || v_quantidade_empregados);
    DBMS_OUTPUT.PUT_LINE('Soma salarial: R$' || v_soma_salarial);
END;
 
-- Executar com id’s: 50, 80, 90
BEGIN
    prc_depto(50);
    prc_depto(80);
    prc_depto(90);
END;
 
-- Criar a tabela FOLHA
 CREATE TABLE FOLHA
(
    ID INTEGER,
    DATA DATE,
    SALBRUTO NUMBER(8,2),
    VALE NUMBER(8,2),
    INSS NUMBER(8,2),
    COMISSAO NUMBER(8,2),
    SALLIQ NUMBER(8,2),
    CONSTRAINT folha_pk PRIMARY KEY (id, data),
    CONSTRAINT folha_fk FOREIGN KEY (id) 
    REFERENCES employees(employee_id)
)
 
-- Criar uma procedure chamada prc_folha que insira na tabela FOLHA o id do empregado, a data atual e o salário bruto (Não tem parâmetro de entrada)
CREATE OR REPLACE PROCEDURE prc_folha IS
    v_id INTEGER;
    v_salario_bruto NUMBER(10, 2);
    CURSOR cursor1 IS
    SELECT employee_id, salary FROM employees;
BEGIN
    OPEN cursor1;
    LOOP
    FETCH cursor1 INTO v_id, v_salario_bruto;
    EXIT WHEN cursor1%NOTFOUND;
    INSERT INTO folha(id, salbruto, data)
    VALUES (v_id, v_salario_bruto, SYSDATE);
    END LOOP;
    COMMIT;
    CLOSE cursor1;
END;
 
-- Executar a procedure (ela não tem parâmetro)
BEGIN
    prc_folha;
END;
 
-- Exibir os dados da tabela FOLHA
SELECT * FROM folha