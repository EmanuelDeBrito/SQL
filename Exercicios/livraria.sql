CREATE TABLE editora(
    cd_cnpj_editora VARCHAR(14),
    nm_editora VARCHAR(40),
    CONSTRAINT editora_pk PRIMARY KEY (cd_cnpj_editora)
)

CREATE TABLE autor(
    cd_cpf_autor INTEGER,
    nm_autor VARCHAR(60),
    CONSTRAINT autor_pk PRIMARY KEY (cd_cpf_autor)
)
 
CREATE TABLE livro(
    cd_isbn_livro INTEGER,
    cd_cnpj_editora VARCHAR(14),
    nm_livro VARCHAR(50),
    vl_livro NUMBER(6, 2),
    CONSTRAINT livro_pk PRIMARY KEY (cd_isbn_livro),
    CONSTRAINT livro_editora_cnpj_fk FOREIGN KEY (cd_cnpj_editora) REFERENCES editora(cd_cnpj_editora)
)
 
CREATE TABLE genero(
    sg_genero CHAR(3),
    nm_genero VARCHAR(30),
    CONSTRAINT genero_pk PRIMARY KEY (sg_genero)
)

CREATE TABLE autor_livro(
    cd_cpf_autor INTEGER,
    cd_isbn_livro INTEGER,
    CONSTRAINT autor_livro_pk PRIMARY KEY (cd_cpf_autor, cd_isbn_livro),
    CONSTRAINT autor_livro_cd_cpf_autor_fk FOREIGN KEY (cd_cpf_autor) REFERENCES autor(cd_cpf_autor),
    CONSTRAINT autor_livro_cd_isbn_livro_fk FOREIGN KEY (cd_isbn_livro) REFERENCES livro(cd_isbn_livro)
)

CREATE TABLE livro_genero(
    cd_isbn_livro INTEGER,
    sg_genero CHAR(3),
    CONSTRAINT livro_genero_pk PRIMARY KEY (cd_isbn_livro, sg_genero),
    CONSTRAINT livro_genero_cd_isbn_livro_fk FOREIGN KEY (cd_isbn_livro) REFERENCES livro(cd_isbn_livro),
    CONSTRAINT livro_genero_sg_genero_fk FOREIGN KEY (sg_genero) REFERENCES genero(sg_genero)
)