-- Criação da tabela DEPARTAMENTO sem restrições de integridade
CREATE TABLE DEPARTAMENTO (
    NOME VARCHAR2(50),
    NUMERO NUMBER(2) PRIMARY KEY,
    RG_GERENTE NUMBER(8)
);

-- Criação da tabela EMPREGADO sem restrições de integridade
CREATE TABLE EMPREGADO (
    NOME VARCHAR2(50),
    RG NUMBER(8) PRIMARY KEY,
    CIC NUMBER(8) UNIQUE,
    DEPTO NUMBER(2),
    RG_SUPERVISOR NUMBER(8),
    SALARIO NUMBER(10, 2)
);

-- Criação da tabela PROJETO
CREATE TABLE PROJETO (
    NOME VARCHAR2(50),
    NUMERO NUMBER(2) PRIMARY KEY,
    LOCALIZACAO VARCHAR2(50)
);

-- Criação da tabela DEPENDENTES sem restrições de integridade
CREATE TABLE DEPENDENTES (
    RG_RESPONSAVEL NUMBER(8),
    NOME_DEPENDENTE VARCHAR2(50),
    NASCIMENTO DATE,
    RELACAO VARCHAR2(10),
    SEXO VARCHAR2(10)
);

-- Criação da tabela DEPARTAMENTO_PROJETO sem restrições de integridade
CREATE TABLE DEPARTAMENTO_PROJETO (
    NUMERO_DEPTO NUMBER(2),
    NUMERO_PROJETO NUMBER(2),
    PRIMARY KEY (NUMERO_DEPTO, NUMERO_PROJETO)
);

-- Criação da tabela EMPREGADO_PROJETO sem restrições de integridade
CREATE TABLE EMPREGADO_PROJETO (
    RG_EMPREGADO NUMBER(8),
    NUMERO_PROJETO NUMBER(2),
    HORAS NUMBER(4),
    PRIMARY KEY (RG_EMPREGADO, NUMERO_PROJETO)
);

-- Inserção de dados na tabela DEPARTAMENTO
INSERT INTO DEPARTAMENTO VALUES (
    'Contabilidade',
    1,
    10101010
);

INSERT INTO DEPARTAMENTO VALUES (
    'Engenharia Civil',
    2,
    30303030
);

INSERT INTO DEPARTAMENTO VALUES (
    'Engenharia Mecânica',
    3,
    20202020
);

-- Inserção de dados na tabela EMPREGADO
INSERT INTO EMPREGADO VALUES (
    'João Luiz',
    10101010,
    11111111,
    1,
    NULL,
    3000.00
);

INSERT INTO EMPREGADO VALUES (
    'Fernando',
    20202020,
    22222222,
    2,
    10101010,
    2500.00
);

INSERT INTO EMPREGADO VALUES (
    'Ricardo',
    30303030,
    33333333,
    2,
    10101010,
    2300.00
);

INSERT INTO EMPREGADO VALUES (
    'Jorge',
    40404040,
    44444444,
    2,
    20202020,
    4200.00
);

INSERT INTO EMPREGADO VALUES (
    'Renato',
    50505050,
    55555555,
    3,
    20202020,
    1300.00
);

-- Inserção de dados na tabela PROJETO
INSERT INTO PROJETO VALUES (
    'Financeiro 1',
    5,
    'São Paulo'
);

INSERT INTO PROJETO VALUES (
    'Motor 3',
    10,
    'Rio Claro'
);

INSERT INTO PROJETO VALUES (
    'Prédio Central',
    20,
    'Campinas'
);

-- Inserção de dados na tabela DEPENDENTES
INSERT INTO DEPENDENTES VALUES (
    10101010,
    'Jorge',
    TO_DATE('27/12/1986', 'DD/MM/YYYY'),
    'Filho',
    'Masculino'
);

INSERT INTO DEPENDENTES VALUES (
    10101010,
    'Luiz',
    TO_DATE('18/11/1979', 'DD/MM/YYYY'),
    'Filho',
    'Masculino'
);

INSERT INTO DEPENDENTES VALUES (
    20202020,
    'Fernanda',
    TO_DATE('14/02/1969', 'DD/MM/YYYY'),
    'Cônjuge',
    'Feminino'
);

INSERT INTO DEPENDENTES VALUES (
    20202020,
    'Ângelo',
    TO_DATE('10/02/1995', 'DD/MM/YYYY'),
    'Filho',
    'Masculino'
);

INSERT INTO DEPENDENTES VALUES (
    30303030,
    'Adreia',
    TO_DATE('01/05/1990', 'DD/MM/YYYY'),
    'Filho',
    'Feminino'
);

-- Inserção de dados na tabela DEPARTAMENTO_PROJETO
INSERT INTO DEPARTAMENTO_PROJETO VALUES (
    2,
    5
);

INSERT INTO DEPARTAMENTO_PROJETO VALUES (
    2,
    10
);

INSERT INTO DEPARTAMENTO_PROJETO VALUES (
    2,
    20
);

-- Inserção de dados na tabela EMPREGADO_PROJETO
INSERT INTO EMPREGADO_PROJETO VALUES (
    20202020,
    5,
    10
);

INSERT INTO EMPREGADO_PROJETO VALUES (
    20202020,
    10,
    25
);

INSERT INTO EMPREGADO_PROJETO VALUES (
    30303030,
    5,
    35
);

INSERT INTO EMPREGADO_PROJETO VALUES (
    40404040,
    20,
    50
);

INSERT INTO EMPREGADO_PROJETO VALUES (
    50505050,
    20,
    35
);

-- Agora, adicionando as restrições de integridade referencial (chaves estrangeiras)

-- Adicionando a chave estrangeira na tabela EMPREGADO para DEPARTAMENTO
ALTER TABLE EMPREGADO
    ADD CONSTRAINT FK_EMPREGADO_DEPARTAMENTO FOREIGN KEY (
        DEPTO
    )
        REFERENCES DEPARTAMENTO(
            NUMERO
        );

-- Adicionando a chave estrangeira na tabela EMPREGADO para EMPREGADO (Supervisor)
ALTER TABLE EMPREGADO
    ADD CONSTRAINT FK_EMPREGADO_SUPERVISOR FOREIGN KEY (
        RG_SUPERVISOR
    )
        REFERENCES EMPREGADO(
            RG
        );

-- Adicionando a chave estrangeira na tabela DEPENDENTES para EMPREGADO
ALTER TABLE DEPENDENTES
    ADD CONSTRAINT FK_DEPENDENTES_RESPONSAVEL FOREIGN KEY (
        RG_RESPONSAVEL
    )
        REFERENCES EMPREGADO(
            RG
        );

-- Adicionando a chave estrangeira na tabela DEPARTAMENTO para EMPREGADO (Gerente)
ALTER TABLE DEPARTAMENTO
    ADD CONSTRAINT FK_DEPARTAMENTO_GERENTE FOREIGN KEY (
        RG_GERENTE
    )
        REFERENCES EMPREGADO(
            RG
        );

-- Adicionando a chave estrangeira na tabela DEPARTAMENTO_PROJETO para DEPARTAMENTO
ALTER TABLE DEPARTAMENTO_PROJETO
    ADD CONSTRAINT FK_DEPARTAMENTO_PROJETO_DEPARTAMENTO FOREIGN KEY (
        NUMERO_DEPTO
    )
        REFERENCES DEPARTAMENTO(
            NUMERO
        );

-- Adicionando a chave estrangeira na tabela DEPARTAMENTO_PROJETO para PROJETO
ALTER TABLE DEPARTAMENTO_PROJETO
    ADD CONSTRAINT FK_DEPARTAMENTO_PROJETO_PROJETO FOREIGN KEY (
        NUMERO_PROJETO
    )
        REFERENCES PROJETO(
            NUMERO
        );

-- Adicionando a chave estrangeira na tabela EMPREGADO_PROJETO para EMPREGADO
ALTER TABLE EMPREGADO_PROJETO
    ADD CONSTRAINT FK_EMPREGADO_PROJETO_EMPREGADO FOREIGN KEY (
        RG_EMPREGADO
    )
        REFERENCES EMPREGADO(
            RG
        );

-- Adicionando a chave estrangeira na tabela EMPREGADO_PROJETO para PROJETO
ALTER TABLE EMPREGADO_PROJETO
    ADD CONSTRAINT FK_EMPREGADO_PROJETO_PROJETO FOREIGN KEY (
        NUMERO_PROJETO
    )
        REFERENCES PROJETO(
            NUMERO
        );