-- FUNCTIONS
 
-- Diferem das procedures por sempre retornarem um valor para o ambiente que a chamou. Pega "carona" em outra instrução. Sintaxe:

/*
CREATE OR REPLACE FUNCTION nome 
(parâmetro MODO TIPO-DE-DADOS)
RETURN TIPO DE DADOS SEM O TAMANHO    
IS
VARIÁVEIS DE SAÍDA, RETORNO;
BEGIN
-– INSTRUÇÕES;
RETURN(valor a retornar);
END;
*/
 
-- Criar uma function chamada fnc_emp que entre com o id do funcionário e exiba o salário anual
CREATE OR REPLACE FUNCTION fnc_emp(v_id IN INTEGER)
    RETURN NUMBER
IS
    v_anual NUMBER(10, 2);
BEGIN
    SELECT salary * 12
    INTO v_anual
    FROM employees
    WHERE employee_id = v_id;
    RETURN (v_anual);
END;
 
-- Consultar a function criada:
 
-- Objetos do tipo função
SELECT OBJECT_NAME, OBJECT_TYPE 
FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'FUNCTION'
 
-- Codigo/script da funcao:
SELECT TEXT FROM USER_SOURCE WHERE NAME = 'FNC_EMP'
 
-- Object Browser:
-- Selecionar em FUNCTIONS na aba de Object Browser
 
-- Executar function criada:
SELECT fnc_emp(123) FROM DUAL
 
SELECT employee_id, salary, FNC_EMP(employee_id) "Salário Anual"
FROM employees
WHERE department_id < 80
 
-- Excluir a function fnc_emp:
DROP FUNCTION fnc_emp

/*
Criar uma function chamada fnc_comissao que tenha dois parâmetros
salário e percentual de comissão e retorne o valor de comissão a receber
OBS. a tabela EMPLOYEES possui 2 colunas salary e commission_pct
*/
 
CREATE OR REPLACE FUNCTION fnc_comissao(p_salario IN NUMBER, p_percentual IN NUMBER)
    RETURN NUMBER
IS
    v_comissao NUMBER(10, 2);
BEGIN
    v_comissao := p_salario * NVL(p_percentual, 0);
    RETURN (v_comissao);
END;
 
-- Testar a function fnc_comissao:
 
-- Constante:
SELECT fnc_comissao(9000, 0.7) FROM DUAL
 
-- Tabela:
SELECT employee_id, salary, commission_pct, fnc_comissao(salary, commission_pct) "Valor de Comissão" 
FROM employees
 
-- Calculando sob o valor da função:
SELECT employee_id, salary, commission_pct, fnc_comissao(salary, commission_pct) "Valor de Comissão", salary + fnc_comissao(salary, commission_pct) "Salário Líquido"
FROM employees