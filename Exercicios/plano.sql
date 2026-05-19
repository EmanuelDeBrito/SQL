-- Tabela assinante
CREATE TABLE assinante(
    cd_cpf_assinante INTEGER,
    nm_assinante VARCHAR(60),
    cd_telefone_assinante VARCHAR(13),
    nm_endereco_assinante VARCHAR(50),
    nm_email_assinante VARCHAR(50),
    CONSTRAINT assinante_pk PRIMARY KEY (cd_cpf_assinante)
)

-- Tabela assinatura
CREATE TABLE assinatura(
    dt_assinatura DATE,
    cd_cpf_assinante INTEGER,
    vl_total_assinatura NUMERIC(6, 2),
    CONSTRAINT assinatura_pk PRIMARY KEY (dt_assinatura),
    CONSTRAINT assinatura_assinante_cpf_fk FOREIGN KEY (cd_cpf_assinante) REFERENCES assinante(cd_cpf_assinante)
)

-- Inserções na tabela assinante
INSERT INTO assinante VALUES (11122233354, 'Emanuel de Brito', '13981776655', 'Rua Flauta Mágica', 'emanuel@gmail.com')
INSERT INTO assinante (cd_cpf_assinante, nm_assinante, cd_telefone_assinante, nm_endereco_assinante, nm_email_assinante) VALUES (22233344455, 'Viviane Brito', '1298765432', 'Avenida Monteiro Lobato', 'viviane@gmail.com')
INSERT INTO assinante VALUES (:cpf, :nome, :telefone, :endereco, :email)

-- Inserções na tabela assinatura
INSERT INTO assinatura VALUES ('13-NOV-2021', 11122233354, 100)
INSERT INTO assinatura (dt_assinatura, cd_cpf_assinante, vl_total_assinatura) VALUES ('11-JUL-2023', 22233344455, 190)
INSERT INTO assinatura VALUES (:data, :cpf_assinante, :valor)

-- Letras maiúsculas e quantidade de caracteres do campo nome
SELECT UPPER(nm_assinante), LENGTH(nm_assinante) FROM assinante

-- Selecione os planos de R$100 ordenando de forma ASC
SELECT dt_assinatura AS "Data da assinatura", cd_cpf_assinante AS "CPF assinante", vl_total_assinatura AS "Valor Total" FROM assinatura WHERE vl_total_assinatura = 100 ORDER BY dt_assinatura ASC

-- Ordene os assinantes pelo nome
SELECT cd_cpf_assinante AS "CPF", nm_assinante AS "Nome", cd_telefone_assinante AS "Telefone", nm_endereco_assinante AS "Endereço", nm_email_assinante AS "Email" FROM assinante ORDER BY nm_assinante DESC

-- Seleção das tabelas
SELECT * FROM assinante
SELECT * FROM assinatura

-- Descrição das tabelas
DESC assinante
DESC assinatura