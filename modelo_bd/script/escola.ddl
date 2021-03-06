-- Gerado por Oracle SQL Developer Data Modeler 17.3.0.261.1529
--   em:        2017-12-01 02:04:04 BRST
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE aluno (
    matricula_numero   NUMBER NOT NULL,
    nome               VARCHAR2(100 CHAR) NOT NULL,
    curso_id           NUMBER NOT NULL,
    genero             CHAR(1) DEFAULT 'M' NOT NULL,
    data_nasc          DATE NOT NULL,
    endereco           VARCHAR2(250),
    cidade_id          NUMBER NOT NULL,
    email              VARCHAR2(200)
);

ALTER TABLE aluno
    ADD CONSTRAINT ck_aluno_genero CHECK ( genero IN (
        'F',
        'M'
    ) );

ALTER TABLE aluno ADD CONSTRAINT aluno_pk PRIMARY KEY ( matricula_numero );

ALTER TABLE aluno ADD CONSTRAINT aluno__un UNIQUE ( email );

CREATE TABLE avaliacao (
    id              NUMBER NOT NULL,
    tipo            CHAR(1) DEFAULT 'P' NOT NULL,
    disciplina_id   NUMBER NOT NULL,
    semestre_id     NUMBER NOT NULL,
    nome            VARCHAR2(100 CHAR) NOT NULL,
    nota            NUMBER DEFAULT 0 NOT NULL
);

ALTER TABLE avaliacao
    ADD CONSTRAINT cx_avaliacao_tipo CHECK ( tipo IN (
        'P',
        'T'
    ) );

ALTER TABLE avaliacao
    ADD CONSTRAINT cx_avaliacao_nota CHECK ( nota BETWEEN 0 AND 10 );

ALTER TABLE avaliacao ADD CONSTRAINT avaliacao_pk PRIMARY KEY ( id );

CREATE TABLE cidade (
    id          NUMBER NOT NULL,
    nome        VARCHAR2(100) NOT NULL,
    estado_uf   CHAR(2) NOT NULL
);

ALTER TABLE cidade ADD CONSTRAINT cidade_pk PRIMARY KEY ( id );

CREATE TABLE curso (
    id          NUMBER NOT NULL,
    nome        VARCHAR2(100 CHAR) NOT NULL,
    escola_id   NUMBER NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( id );

ALTER TABLE curso ADD CONSTRAINT curso__un UNIQUE ( nome );

CREATE TABLE curso_disciplina (
    nivel           NUMBER NOT NULL,
    disciplina_id   NUMBER NOT NULL,
    curso_id        NUMBER NOT NULL
);

ALTER TABLE curso_disciplina ADD CONSTRAINT curso_disciplina_pk PRIMARY KEY ( disciplina_id,
curso_id );

CREATE TABLE disciplina (
    id              NUMBER NOT NULL,
    nome            VARCHAR2(100 CHAR) NOT NULL,
    creditos        NUMBER NOT NULL,
    carga_horaria   NUMBER NOT NULL
);

ALTER TABLE disciplina ADD CONSTRAINT disciplina_pk PRIMARY KEY ( id );

ALTER TABLE disciplina ADD CONSTRAINT disciplina__un UNIQUE ( nome );

CREATE TABLE disciplina_professor (
    disciplina_id                NUMBER NOT NULL,
    professor_matricula_numero   NUMBER NOT NULL
);

ALTER TABLE disciplina_professor ADD CONSTRAINT disciplina_professor_pk PRIMARY KEY ( disciplina_id,
professor_matricula_numero );

CREATE TABLE disciplina_turma (
    disciplina_id   NUMBER NOT NULL,
    turma_numero    NUMBER NOT NULL
);

ALTER TABLE disciplina_turma ADD CONSTRAINT disciplina_turma_pk PRIMARY KEY ( disciplina_id,
turma_numero );

CREATE TABLE escola (
    id          NUMBER
        CONSTRAINT nnc_escola_id NOT NULL,
    nome        VARCHAR2(200)
        CONSTRAINT nnc_escola_nome NOT NULL,
    endereco    VARCHAR2(250),
    cidade_id   NUMBER
        CONSTRAINT nnc_escola_cidade_id NOT NULL
);

ALTER TABLE escola ADD CONSTRAINT escola_pk PRIMARY KEY ( id );

CREATE TABLE estado (
    uf     CHAR(2) NOT NULL,
    nome   VARCHAR2(20) NOT NULL
);

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( uf );

ALTER TABLE estado ADD CONSTRAINT estado__un UNIQUE ( nome );

CREATE TABLE matricula (
    numero   NUMBER NOT NULL
);

ALTER TABLE matricula ADD CONSTRAINT matricula_pk PRIMARY KEY ( numero );

CREATE TABLE professor (
    matricula_numero   NUMBER NOT NULL,
    nome               VARCHAR2(100) NOT NULL,
    genero             CHAR(1 CHAR) DEFAULT 'M' NOT NULL,
    data_nasc          DATE NOT NULL,
    endereco           VARCHAR2(250),
    cidade_id          NUMBER NOT NULL,
    email              VARCHAR2(200)
);

ALTER TABLE professor
    ADD CONSTRAINT ck_professor_genero CHECK ( genero IN (
        'F',
        'M'
    ) );

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY ( matricula_numero );

ALTER TABLE professor ADD CONSTRAINT professor__un UNIQUE ( email );

CREATE TABLE semestre (
    id                       NUMBER NOT NULL,
    periodo                  CHAR(6 CHAR) NOT NULL,
    aluno_matricula_numero   NUMBER NOT NULL,
    atual                    CHAR(1) DEFAULT '1' NOT NULL,
    trancado                 NUMBER DEFAULT 0 NOT NULL
);

ALTER TABLE semestre
    ADD CONSTRAINT ck_semestre_atual CHECK ( atual IN (
        '0',
        '1'
    ) );

ALTER TABLE semestre
    ADD CHECK ( trancado IN (
        0,
        1
    ) );
--  Previne que haja mais de um semestre ativo por aluno

CREATE UNIQUE INDEX semestre__idx_ativo ON
    semestre (
        CASE
            WHEN atual = '1' THEN id
            || aluno_matricula_numero
            ELSE NULL
        END
    );

ALTER TABLE semestre ADD CONSTRAINT semestre_pk PRIMARY KEY ( id );

CREATE TABLE semestre_turma (
    semestre_id    NUMBER NOT NULL,
    turma_numero   NUMBER NOT NULL
);

ALTER TABLE semestre_turma ADD CONSTRAINT semestre_turma_pk PRIMARY KEY ( semestre_id,
turma_numero );

CREATE TABLE turma (
    numero   NUMBER NOT NULL
);

ALTER TABLE turma ADD CONSTRAINT turma_pk PRIMARY KEY ( numero );

ALTER TABLE aluno
    ADD CONSTRAINT aluno_cidade_fk FOREIGN KEY ( cidade_id )
        REFERENCES cidade ( id );

ALTER TABLE aluno
    ADD CONSTRAINT aluno_curso_fk FOREIGN KEY ( curso_id )
        REFERENCES curso ( id );

ALTER TABLE aluno
    ADD CONSTRAINT aluno_matricula_fk FOREIGN KEY ( matricula_numero )
        REFERENCES matricula ( numero );

ALTER TABLE avaliacao
    ADD CONSTRAINT avaliacao_disciplina_fk FOREIGN KEY ( disciplina_id )
        REFERENCES disciplina ( id );

ALTER TABLE avaliacao
    ADD CONSTRAINT avaliacao_semestre_fk FOREIGN KEY ( semestre_id )
        REFERENCES semestre ( id );

ALTER TABLE cidade
    ADD CONSTRAINT cidade_estado_fk FOREIGN KEY ( estado_uf )
        REFERENCES estado ( uf );

ALTER TABLE curso_disciplina
    ADD CONSTRAINT curso_disciplina_curso_fk FOREIGN KEY ( curso_id )
        REFERENCES curso ( id );

ALTER TABLE curso_disciplina
    ADD CONSTRAINT curso_disciplina_disciplina_fk FOREIGN KEY ( disciplina_id )
        REFERENCES disciplina ( id );

ALTER TABLE curso
    ADD CONSTRAINT curso_escola_fk FOREIGN KEY ( escola_id )
        REFERENCES escola ( id );

ALTER TABLE disciplina_professor
    ADD CONSTRAINT dp_disciplina_fk FOREIGN KEY ( disciplina_id )
        REFERENCES disciplina ( id );

ALTER TABLE disciplina_professor
    ADD CONSTRAINT dp_professor_fk FOREIGN KEY ( professor_matricula_numero )
        REFERENCES professor ( matricula_numero );

ALTER TABLE disciplina_turma
    ADD CONSTRAINT dt_disciplina_fk FOREIGN KEY ( disciplina_id )
        REFERENCES disciplina ( id );

ALTER TABLE disciplina_turma
    ADD CONSTRAINT dt_turma_fk FOREIGN KEY ( turma_numero )
        REFERENCES turma ( numero );

ALTER TABLE escola
    ADD CONSTRAINT escola_cidade_fk FOREIGN KEY ( cidade_id )
        REFERENCES cidade ( id );

ALTER TABLE professor
    ADD CONSTRAINT professor_cidade_fk FOREIGN KEY ( cidade_id )
        REFERENCES cidade ( id );

ALTER TABLE professor
    ADD CONSTRAINT professor_matricula_fk FOREIGN KEY ( matricula_numero )
        REFERENCES matricula ( numero );

ALTER TABLE semestre
    ADD CONSTRAINT semestre_aluno_fk FOREIGN KEY ( aluno_matricula_numero )
        REFERENCES aluno ( matricula_numero );

ALTER TABLE semestre_turma
    ADD CONSTRAINT st_semestre_fk FOREIGN KEY ( semestre_id )
        REFERENCES semestre ( id );

ALTER TABLE semestre_turma
    ADD CONSTRAINT st_turma_fk FOREIGN KEY ( turma_numero )
        REFERENCES turma ( numero );

CREATE SEQUENCE avaliacao_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER avaliacao_id_trg BEFORE
    INSERT ON avaliacao
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := avaliacao_id_seq.nextval;
END;
/

CREATE SEQUENCE cidade_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER cidade_id_trg BEFORE
    INSERT ON cidade
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := cidade_id_seq.nextval;
END;
/

CREATE SEQUENCE curso_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER curso_id_trg BEFORE
    INSERT ON curso
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := curso_id_seq.nextval;
END;
/

CREATE SEQUENCE disciplina_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER disciplina_id_trg BEFORE
    INSERT ON disciplina
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := disciplina_id_seq.nextval;
END;
/

CREATE SEQUENCE escola_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER escola_id_trg BEFORE
    INSERT ON escola
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := escola_id_seq.nextval;
END;
/

CREATE SEQUENCE matricula_numero_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER matricula_numero_trg BEFORE
    INSERT ON matricula
    FOR EACH ROW
    WHEN ( new.numero IS NULL )
BEGIN
    :new.numero := matricula_numero_seq.nextval;
END;
/

CREATE SEQUENCE semestre_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER semestre_id_trg BEFORE
    INSERT ON semestre
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := semestre_id_seq.nextval;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             1
-- ALTER TABLE                             45
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           7
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          7
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
