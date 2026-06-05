-- Serve para você criar objetos
 
-- Criar um objeto tipo PESSOA com codigo e nome que possa ser herdado por outros objetos (SUPER CLASSE)
CREATE OR REPLACE TYPE pessoa AS OBJECT
(cd_pessoa INTEGER, nm_pessoa VARCHAR(60))
NOT FINAL;
 
-- Excluir o tipo PESSOAS:
DROP TYPE pessoas
 
-- Exibir a estrutura do tipo PESSOA
DESC pessoa
 
-- Criar uma subclasse chamada FISICA que herde as características da superclasse PESSOAS (Obs. não tem NOT FINAL)
CREATE TYPE fisica UNDER pessoa
(cpf CHAR(11), sexo CHAR(1))
 
-- Consultar os objetos criados (Obs. ainda que se chama objeto foi criado uma classe)
SELECT OBJECT_TYPE, OBJECT_NAME FROM USER_OBJECTS
WHERE OBJECT_TYPE = 'OBJECT'
 
-- Exibir a estrutura do tipo FISICA
DESC fisica
 
-- Criar a tabela PESSOA_FISICA com base no tipo FISICA
CREATE TABLE pessoa_fisica OF fisica
 
-- Descrevendo a tabela
DESC pessoa_fisica
 
-- Acrescentar chave primária na tabela na coluna cdpessoa:
ALTER TABLE pessoa_fisica
ADD CONSTRAINT PESSOAFISICA_PK PRIMARY KEY (cd_pessoa)
 
-- Inserir registro na tabela PES_FISICA
INSERT INTO pessoa_fisica
VALUES (1, 'Emanuel', 123458762, 'M')
 
-- Exibir os registros da tabela PESSOA_FISICA
SELECT * FROM pessoa_fisica
 
-- Criar o tipo JURIDICA com inscricao estadual varchar(30) e cnpj char(14) que herda as características de PESSOA
CREATE TYPE juridica UNDER pessoa
(inscricao_estadual VARCHAR(30), cnpj CHAR(14))
 
-- Criar a tabela PESSOA_JURIDICA com base no tipo JURIDICA
CREATE TABLE pessoa_juridica OF juridica
 
-- Inserir registro na tabela PESSOA_JURIDICA
INSERT INTO pessoa_juridica
VALUES (1, 'Google', '321412312', '1234512')
 
-- Exibir os registros da tabela PESSOA_JURIDICA
SELECT * FROM pessoa_juridica
 
-- Tabelas com colunas cujo tipo de dado de domínio é outra tabela.
Criar uma tabela aninhada (coluna) chamada t_ende com a estrutura abaixo:
CREATE OR REPLACE TYPE T_ende AS OBJECT
(
  logradouro VARCHAR(60),
  numero INTEGER,
  bairro VARCHAR(50),
  cidade VARCHAR(50),
  uf CHAR(2),
  cep CHAR(9)
)
 
-- Criar um tipo de dado coluna chamado lista_ende com base na tabela aninhada t_ende:
CREATE TYPE lista_ende AS TABLE OF t_ende
 
-- Criar um tipo de dados array chamado TELE varchar(14) com 5 posições
CREATE TYPE tele AS VARRAY(5) OF VARCHAR(14)
 
-- Criar a tabela CLIENTE_LOJA com os tipos de dados COMPOSTO e ARRAY:
CREATE TABLE cliente_loja
(
  cpf CHAR(11),
  nome VARCHAR(50),
  tel_cliente tele,
  ende_cliente lista_ende
)
NESTED TABLE ende_cliente STORE AS end_clientes_tab
 
-- Inserir registro na tabela CLIENTE_LOJA
INSERT INTO cliente_loja
VALUES 
(
  '123456789', 
  'Emanuel',
  tele('123456', '78901'),
  lista_ende(t_ende('Rua principal', 320, 'Boqueirão', 'Praia Grande', 'SP', '11740-000'))
)
 
-- Selecionar os registros:
SELECT C.cpf, C.nome, E.logradouro
FROM cliente_loja C,
TABLE (C.ende_cliente) E