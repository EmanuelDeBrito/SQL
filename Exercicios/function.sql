-- EXERCÍCIOS
-- EXERCISE
 
-- Criar uma function chamada fnc_transporte que informe o salario e calcule 6% sobre o salário.
CREATE OR REPLACE FUNCTION fnc_transporte(p_salario IN NUMBER)
    RETURN NUMBER
IS
    v_vale_transporte NUMBER(10, 2);
BEGIN
    v_vale_transporte := p_salario * 0.06;
    RETURN (v_vale_transporte);
END;
 
-- Criar uma function chamada fnc_inss que informe o salario e retorne o valor a ser descontado de INSS de acordo com a tabela do governo
CREATE OR REPLACE FUNCTION fnc_inss(p_salario IN NUMBER)
    RETURN NUMBER
IS
    v_desconto_inss NUMBER(10, 2);
BEGIN
    IF p_salario > 0 AND p_salario <= 1621 THEN
    v_desconto_inss := p_salario * 0.075;
    ELSIF p_salario > 1621 AND p_salario <= 2902.84 THEN
    v_desconto_inss := p_salario * 0.09;
    ELSIF p_salario > 2902.84 AND p_salario <= 4354.27 THEN
    v_desconto_inss := p_salario * 0.12;
    ELSE
    v_desconto_inss := p_salario * 0.14;
    END IF;
    RETURN (v_desconto_inss);
END;

/* 
    Criar a procedure PRC_FOLHA para que ela insira na tabela FOLHA, o id do empregado (employee_id), o salario bruto (salary), 
    a comissão (chamar a funcao fnc_comissao) e o salário líquido (salário + o valor de comissão) com a data atual.
*/
 
-- Observações
-- A TABELA FOLHA SERÁ UMA TEMPORÁRIA
-- A FUNÇÃO DEVERÁ EXISTIR ANTES PARA QUE POSSA SER CHAMADA PELA PROCEDURE.
 
CREATE OR REPLACE PROCEDURE prc_folha IS
    v_id INTEGER;
    v_salario_bruto NUMBER(10, 2);
    v_percentual NUMBER(10, 2);
    v_comissao NUMBER(10, 2);
    v_salario_liquido NUMBER(10, 2);
CURSOR cursor1 IS
  SELECT employee_id, salary, commission_pct FROM employees;
BEGIN
    DELETE FROM folha;
    COMMIT;
    OPEN cursor1;
    LOOP
        FETCH cursor1 INTO v_id, v_salario_bruto, v_percentual;
        EXIT WHEN cursor1%NOTFOUND;
        v_comissao := fnc_comissao(v_salario_bruto, v_percentual);
        v_salario_liquido := v_salario_bruto + v_comissao;
        INSERT INTO folha(id, salbruto, comissao, salliq, data)
        VALUES (v_id, v_salario_bruto, v_comissao, v_salario_liquido, SYSDATE);
    END LOOP;
    COMMIT;
    CLOSE cursor1;
END;
 
-- Executar a procedure PRC_FOLHA
BEGIN
    prc_folha;
END;
 
-- Exibir todos os registros da tabela FOLHA
SELECT * FROM folha