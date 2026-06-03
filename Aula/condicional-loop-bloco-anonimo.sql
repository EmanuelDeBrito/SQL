-- Criar um bloco que de acordo com o id do depto. exiba:
-- se for entre 10 e 30: a soma salarial;
-- se for entre 40 e 60: a média salarial;
-- se for entre 70 e 90: a qtde de empregados;
-- Caso contrário, exibir todas as informações.
-- Obs. testar com todas condições, os deptos tem id com números de 10 em 10. Ex. 10, 20, 30,...
 
DECLARE
  v_id PLS_INTEGER := :depto;
  v_soma NUMBER(10, 2);
  v_media NUMBER(10, 2);
  v_qtde INTEGER;
BEGIN
  SELECT SUM(salary), AVG(salary), COUNT(employee_id)
  INTO v_soma, v_media, v_qtde
  FROM employees
  WHERE department_id = v_id;
  IF v_id BETWEEN 10 AND 30 THEN
    DBMS_OUTPUT.PUT_LINE('Soma salarial: R$ ' || v_soma);
  ELSIF v_id BETWEEN 40 AND 60 THEN
    DBMS_OUTPUT.PUT_LINE('Média salarial: R$ ' || v_media);
  ELSIF v_id BETWEEN 70 AND 90 THEN
    DBMS_OUTPUT.PUT_LINE('Quantidade de empregados: ' || v_qtde);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Soma salarial: R$ ' || v_soma);
    DBMS_OUTPUT.PUT_LINE('Média salarial: R$ ' || v_media);
    DBMS_OUTPUT.PUT_LINE('Quantidade de empregados: ' || v_qtde);
  END IF;
END;
 
-- Criar um bloco que insira na tabela loop 10 números
 
-- LOOP BÁSICO (permite incremento com vários valores, além do 1)
DECLARE
  v_num INTEGER := 1; -- Constante
BEGIN
  LOOP
    INSERT INTO loop VALUES (v_num, 'Loop Básico ' || v_num);
    v_num := v_num + 1; -- Incremento
    EXIT WHEN v_num > 10; -- Condição de saída do loop
  END LOOP;
  COMMIT;
END;
 
-- Transformar a tabela em uma temporária e aumentar a qtde de registros
DECLARE
  v_num INTEGER := 1; -- Constante
BEGIN
  DELETE FROM loop;
  COMMIT;
  LOOP
    INSERT INTO loop VALUES (v_num, 'Loop Básico ' || v_num);
    v_num := v_num + 1; -- Incremento
    EXIT WHEN v_num > 1000; -- Condição de saída do loop
  END LOOP;
  COMMIT;
END;
 
-- WHILE: (condição validada no início do bloco e também incremento com qualquer valor)
DECLARE
  v_num INTEGER := 1; -- Constante
BEGIN
  DELETE FROM loop;
  COMMIT;
  WHILE v_num <= 10 LOOP
    INSERT INTO loop VALUES (v_num, 'While Básico ' || v_num);
    v_num := v_num + 1; -- Incremento
  END LOOP;
  COMMIT;
END;
 
-- Alterar para ser 100 registros com incremento 5
DECLARE
  v_num INTEGER := 1; -- Constante
BEGIN
  DELETE FROM loop;
  COMMIT;
  WHILE v_num <= 100 LOOP
    INSERT INTO loop VALUES (v_num, 'While Básico ' || v_num);
    v_num := v_num + 5; -- Incremento
  END LOOP;
  COMMIT;
END;
 
-- FOR (incremento implícito (variável não precisa ser declarada), somente 1;
BEGIN
  DELETE FROM loop;
  COMMIT;
  FOR i IN 1..10 LOOP
    INSERT INTO loop VALUES (i, 'Incremento implícito: ' || i);
  END LOOP;
END;
 
-- FOR REVERSO (DECRESCENTE)
BEGIN
  DELETE FROM loop;
  COMMIT;
  FOR i IN REVERSE 1..1000 LOOP
    INSERT INTO loop VALUES(i, 'For Reverse: ' || i);
  END LOOP;
END;