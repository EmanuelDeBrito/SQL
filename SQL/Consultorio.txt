CREATE TABLE paciente 
( 
    cd_cpf_paciente INTEGER PRIMARY KEY, 
    nm_paciente VARCHAR(50) NOT NULL, 
    cd_telefone VARCHAR(15) 
);

DESCRIBE paciente

INSERT INTO paciente VALUES (1, 'Emanuel', '(11) 99008-8765');
INSERT INTO paciente VALUES (2, 'Viviane', NULL);

INSERT INTO paciente (cd_cpf_paciente, nm_paciente) VALUES (3, 'Danilo');
INSERT INTO paciente (cd_cpf_paciente, nm_paciente) VALUES (4, 'julia');

UPDATE paciente SET nm_paciente = 'Julia' WHERE cd_cpf_paciente = 4;

DELETE FROM paciente WHERE cd_cpf_paciente = 1;

SELECT * FROM paciente;