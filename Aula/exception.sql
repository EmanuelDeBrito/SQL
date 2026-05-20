-- EXCEPTIONS

DELETE FROM departments WHERE department_id = 80
 
DECLARE 
    v_depto INTEGER := :departamento;
    erro_integridade EXCEPTION;
    PRAGMA EXCEPTION_INIT (erro_integridade, -2292);
BEGIN
    DELETE FROM departments WHERE department_id = v_depto;
    COMMIT;
    EXCEPTION
    WHEN erro_integridade THEN
        DBMS_OUTPUT.PUT_LINE('Há registros vinculados a este departamento, impossível exclui-los');
END;
 
INSERT INTO departments (department_id, department_name)
VALUES (999, 'Teste')
 
SELECT * FROM departments WHERE department_id = 999
 
-- Tentativa de armazenar valores duplicados em uma coluna restrita. Obs. EXECUTAR 2 VEZES:
BEGIN
    INSERT INTO departments (department_id, department_name)
    VALUES (999, 'Teste');
    COMMIT;
    EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Este registro já existe!');
END;
 
SELECT * FROM departments WHERE department_id = 999
 
-- Tentativa de dividir um número por zero
BEGIN
    DBMS_OUTPUT.PUT_LINE(1 / 0);
    EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Divisão por Zero!!!');
END;
 
-- Criar um bloco que informa o id do cargo e retorna o empregado que tem este ID. Tratar quando houver mais de um empregado com este (TOO_MANY_ROWS)
DECLARE
    v_job_id employees.job_id%TYPE := :jobId;
    v_name employees.first_name%TYPE;
BEGIN
    SELECT first_name 
    INTO v_name 
    FROM employees
    WHERE job_id = v_job_id;
    EXCEPTION
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Mais de um empregado nesse trabalho');
END;
 
/*
    Criar um bloco que atualize o salário do empregado em 50% a menos,
    Tratar o erro quando for informado um empregado que não existe.
    TESTE: Qualquer numero menor que 100
*/
DECLARE
    v_id INTEGER := :empregado;
    excecao EXCEPTION;
BEGIN
    UPDATE employees SET salary = salary * 0.5
    WHERE employee_id = v_id;
    IF SQL%NOTFOUND THEN
        RAISE excecao;
    END IF;
    EXCEPTION WHEN excecao THEN
        DBMS_OUTPUT.PUT_LINE('Empregado não existe');
END;

-- Criar um bloco que exclua todos os empregados subordinados ao gerente informado. Tratar a exception quando o gerente for inválido. 
DECLARE
    v_gerente PLS_INTEGER := :gerente;
BEGIN
    DELETE FROM employees
    WHERE manager_id = v_gerente;
    IF SQL%NOTFOUND THEN
    RAISE_APPLICATION_ERROR(-20202, 'Gerente Inválido');
    END IF;
END;