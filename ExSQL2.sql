-- Encontre os nomes de todos os empregados que trabalham para o departamento de Engenharia Civil.
SELECT EMPREGADO.Nome
FROM EMPREGADO
JOIN DEPARTAMENTO ON EMPREGADO.Depto = DEPARTAMENTO.Numero
WHERE DEPARTAMENTO.Nome = 'Engenharia Civil';

-- Para todos os projetos localizados em “São Paulo”, listar os números dos projetos, os números dos departamentos, e o nome do gerente do departamento.
SELECT
	PROJETO.Numero,
	DEPARTAMENTO_PROJETO.Numero_Depto,
	EMPREGADO.Nome
FROM
	PROJETO
JOIN
	DEPARTAMENTO_PROJETO ON PROJETO.Numero = DEPARTAMENTO_PROJETO.Numero_Projeto
JOIN
	DEPARTAMENTO ON DEPARTAMENTO_PROJETO.Numero_Depto = DEPARTAMENTO.Numero
JOIN
	EMPREGADO ON DEPARTAMENTO.RG_Gerente = EMPREGADO.RG
WHERE
	PROJETO.Localizacao = 'São Paulo';

-- Encontre os empregados que trabalham em todos os projetos controlados pelo departamento número 3.
SELECT EMPREGADO.Nome, EMPREGADO.RG
FROM EMPREGADO
JOIN EMPREGADO_PROJETO ON EMPREGADO.RG = EMPREGADO_PROJETO.RG_Empregado
JOIN DEPARTAMENTO_PROJETO ON EMPREGADO_PROJETO.Numero_Projeto = DEPARTAMENTO_PROJETO.Numero_Projeto
JOIN PROJETO ON DEPARTAMENTO_PROJETO.Numero_Projeto = PROJETO.Numero
JOIN DEPARTAMENTO ON DEPARTAMENTO_PROJETO.Numero_Depto = DEPARTAMENTO.Numero
WHERE DEPARTAMENTO.Numero = 3

-- Faça uma lista dos números dos projetos que envolvem um empregado chamado “Fernando” como um trabalhador ou como um gerente do departamento que controla o projeto.
SELECT EMPREGADO_PROJETO.Numero_Projeto
FROM EMPREGADO
JOIN EMPREGADO_PROJETO ON EMPREGADO.RG = EMPREGADO_PROJETO.RG_Empregado
WHERE EMPREGADO.Nome = 'Fernando'
UNION
SELECT DEPARTAMENTO_PROJETO.Numero_Projeto
FROM EMPREGADO
JOIN DEPARTAMENTO ON EMPREGADO.RG = DEPARTAMENTO.RG_Gerente
JOIN DEPARTAMENTO_PROJETO ON DEPARTAMENTO.Numero = DEPARTAMENTO_PROJETO.Numero_Depto
WHERE EMPREGADO.Nome = 'Fernando';

-- Liste os nomes dos empregados que não possuem dependentes. 
SELECT EMPREGADO.Nome
FROM EMPREGADO
LEFT JOIN DEPENDENTES ON EMPREGADO.RG = DEPENDENTES.RG_Responsavel
WHERE DEPENDENTES.RG_Responsavel IS NULL;

-- Liste os nomes dos gerentes que têm pelo menos um dependente.
SELECT DISTINCT EMPREGADO.Nome
FROM EMPREGADO
JOIN DEPARTAMENTO ON EMPREGADO.RG = DEPARTAMENTO.RG_Gerente
JOIN DEPENDENTES ON EMPREGADO.RG = DEPENDENTES.RG_Responsavel;

-- Selecione o número do departamento que controla projetos localizados em Rio Claro.
SELECT DISTINCT DEPARTAMENTO_PROJETO.Numero_Depto
FROM DEPARTAMENTO_PROJETO
JOIN PROJETO ON DEPARTAMENTO_PROJETO.Numero_Projeto = PROJETO.Numero
WHERE PROJETO.Localizacao = 'Rio Claro';

--  Selecione o nome e o RG de todos os funcionários que são supervisores.
SELECT EMPREGADO.Nome, EMPREGADO.RG
FROM EMPREGADO
WHERE EMPREGADO.RG IN (
	SELECT DISTINCT EMPREGADO.RG_Supervisor
	FROM EMPREGADO
	WHERE EMPREGADO.RG_Supervisor IS NOT NULL
);

-- Selecione todos os empregados com salário maior ou igual a 2000,00. 
SELECT EMPREGADO.Nome, EMPREGADO.RG, EMPREGADO.Salario
FROM EMPREGADO
WHERE EMPREGADO.Salario >= 2000.00;

-- Selecione todos os empregados cujo nome começa com ‘J’.
SELECT EMPREGADO.Nome, EMPREGADO.RG
FROM EMPREGADO
WHERE EMPREGADO.Nome LIKE 'J%';

-- Mostre todos os empregados que têm ‘Luiz’ ou ‘Luis’ no nome.
SELECT EMPREGADO.Nome, EMPREGADO.RG
FROM EMPREGADO
WHERE EMPREGADO.Nome LIKE '%Luiz%'
   OR EMPREGADO.Nome LIKE '%Luis%';

-- Mostre todos os empregados do departamento de ‘Engenharia Civil’.
SELECT EMPREGADO.Nome, EMPREGADO.RG
FROM EMPREGADO
JOIN DEPARTAMENTO ON EMPREGADO.Depto = DEPARTAMENTO.Numero
WHERE DEPARTAMENTO.Nome = 'Engenharia Civil';

-- Mostre todos os nomes dos departamentos envolvidos com o projeto ‘Motor 3’.
SELECT DEPARTAMENTO.Nome
FROM DEPARTAMENTO
JOIN DEPARTAMENTO_PROJETO ON DEPARTAMENTO.Numero = DEPARTAMENTO_PROJETO.Numero_Depto
JOIN PROJETO ON DEPARTAMENTO_PROJETO.Numero_Projeto = PROJETO.Numero
WHERE PROJETO.Nome = 'Motor 3';

-- Liste o nome dos empregados envolvidos com o projeto ‘Financeiro 1’.
SELECT EMPREGADO.Nome
FROM EMPREGADO
JOIN EMPREGADO_PROJETO ON EMPREGADO.RG = EMPREGADO_PROJETO.RG_Empregado
JOIN PROJETO ON EMPREGADO_PROJETO.Numero_Projeto = PROJETO.Numero
WHERE PROJETO.Nome = 'Financeiro 1';

-- Mostre os funcionários cujo supervisor ganha entre 2000 e 2500.
SELECT EMPREGADO.Nome
FROM EMPREGADO
JOIN EMPREGADO SUPERVISOR ON EMPREGADO.RG_Supervisor = SUPERVISOR.RG
WHERE SUPERVISOR.Salario BETWEEN 2000.00 AND 2500.00;

-- Liste o nome dos gerentes que têm ao menos um dependente.
SELECT DISTINCT EMPREGADO.Nome
FROM EMPREGADO
JOIN EMPREGADO GERENTE ON EMPREGADO.RG = GERENTE.RG_Supervisor
JOIN DEPENDENTES ON EMPREGADO.RG = DEPENDENTES.RG_Responsavel;

-- Atualize o salário de todos os empregados que trabalham no departamento 2 para R$ 3.000,00.
UPDATE EMPREGADO
SET Salario = 3000.00
WHERE Depto = 2;

-- Fazer um comando SQL para ajustar o salário de todos os funcionários da empresa em 10%.
UPDATE EMPREGADO
SET Salario = Salario * 1.10;

-- Mostre a média salarial dos empregados da empresa.
SELECT AVG(Salario) AS Media_Salarial
FROM EMPREGADO;

-- Mostre os nomes dos empregados (em ordem alfabética)  com salário maior que a média.
SELECT EMPREGADO.Nome
FROM EMPREGADO
WHERE EMPREGADO.Salario > (SELECT AVG(Salario) FROM EMPREGADO)
ORDER BY NLSSORT(EMPREGADO.Nome, 'NLS_SORT = BINARY_AI');
