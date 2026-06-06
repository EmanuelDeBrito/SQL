-- Selecionando os Tipos e Nomes dos Objetos do usuário específico
SELECT OBJECT_TYPE, OBJECT_NAME FROM USER_OBJECTS ORDER BY 1
 
-- Selecionando todos os Tipos e Nomes dos Objetos do usuário
SELECT OBJECT_TYPE, OBJECT_NAME FROM ALL_OBJECTS ORDER BY 1
 
-- Criar uma view chamada vw_depto que tenha o id e nome do depto 
CREATE VIEW vw_depto (id, nome)
AS
SELECT department_id, department_name
  FROM departments
 
-- Verificando existência da VIEW
SELECT OBJECT_NAME FROM USER_OBJECTS
WHERE OBJECT_NAME = 'VW_DEPTO'
 
-- Descrevendo a VIEW
DESC VW_DEPTO
 
-- Exibindo os dados da VIEW
SELECT * FROM VW_DEPTO
 
-- Selecionando dados da VIEW com uma condição
SELECT * FROM VW_DEPTO WHERE nome LIKE 'A%' ORDER BY 1
 
-- Inserindo valor na VIEW
INSERT INTO VW_DEPTO VALUES (45, 'Estágio')
 
-- Verificando inserção na VIEW
SELECT * FROM VW_DEPTO WHERE id = 45
 
-- Verificando mudança na tabela departments
SELECT * FROM departments WHERE department_id = 45
 
-- Atualizando departamento pela VIEW
UPDATE VW_DEPTO SET nome = 'Emprego' WHERE id = 45
 
-- Excluindo departamento pela VIEW
DELETE FROM VW_DEPTO WHERE id = 45
 
-- Criando uma VIEW simples somente de leitura
CREATE OR REPLACE VIEW vw_depto AS SELECT department_id id, department_name nome
FROM departments
WITH READ ONLY
 
-- Tentando inserir valores em uma VIEW de somente leitura (vai retornar um erro)
INSERT INTO VW_DEPTO VALUES (45, 'Estágio')
 
-- Verificando se o registro foi inserido (não foi)
SELECT * FROM VW_DEPTO WHERE id BETWEEN 10 AND 50
 
-- Verificando comando de criação da VIEW
SELECT TEXT FROM USER_VIEWS WHERE VIEW_NAME = 'VW_DEPTO'
 
-- Dropando a VIEW
DROP VIEW VW_DEPTO
 
