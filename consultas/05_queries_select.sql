/* 
(JOINs, Agregações, Subconsultas)
*/

USE locadora_veiculos;

-- 1. INNER JOIN: Listagem de locações com detalhes
--  Ver quem alugou, qual carro e onde retirou.
SELECT 
    l.idLocacao,
    c.nome AS Cliente,
    v.modelo AS Veiculo,
    f.nome AS FilialRetirada,
    DATE_FORMAT(l.dtRetirada, '%d/%m/%Y') as DataRetirada
FROM locacao l
INNER JOIN cliente c ON l.idCliente = c.idCliente
INNER JOIN veiculo v ON l.idVeiculo = v.idVeiculo
INNER JOIN filial f ON l.idFilialRetirada = f.idFilial;

-- 2. LEFT JOIN: Veículos e sua última locação
--  Relatório de ociosidade (mostra carros mesmo que nunca locados).
SELECT 
    v.modelo, 
    v.placa, 
    MAX(l.dtRetirada) AS UltimaVezLocado,
    CASE WHEN MAX(l.dtRetirada) IS NULL THEN 'Nunca Locado' ELSE 'Já Locado' END as StatusUso
FROM veiculo v
LEFT JOIN locacao l ON v.idVeiculo = l.idVeiculo
GROUP BY v.idVeiculo, v.modelo, v.placa;

-- 3. RIGHT JOIN: Filiais e Veículos Disponíveis
--  Auditoria de pátio (foco nas filiais para ver o que tem lá parado).
SELECT 
    f.nome AS Filial,
    v.modelo AS CarroNoPatio,
    v.placa
FROM veiculo v
RIGHT JOIN filial f ON v.idFilialAtual = f.idFilial AND v.status = 'DISPONIVEL'
ORDER BY f.nome;

-- 4. CASE: Classificação de atraso e Multas
-- Identificar rapidamente locações problemáticas.
SELECT 
    idLocacao,
    valorFinal,
    multa,
    CASE 
        WHEN multa > 0 THEN 'COM ATRASO'
        ELSE 'No Prazo'
    END AS StatusDevolucao
FROM locacao
WHERE dtDevolucao IS NOT NULL;

-- 5. AGREGAÇÃO (SUM): Faturamento por Filial
--  Analisar qual filial rende mais (Exigência do enunciado).
SELECT 
    f.nome AS Filial,
    SUM(l.valorFinal) AS FaturamentoTotal
FROM locacao l
INNER JOIN filial f ON l.idFilialDevolucao = f.idFilial
WHERE l.valorFinal IS NOT NULL
GROUP BY f.nome;

-- 6. AGREGAÇÃO (GROUP BY + COUNT): Locações por Categoria
--  Saber qual tipo de carro sai mais.
SELECT 
    cat.nome AS Categoria,
    COUNT(l.idLocacao) AS QtdLocacoes
FROM locacao l
JOIN veiculo v ON l.idVeiculo = v.idVeiculo
JOIN categoria cat ON v.idCategoria = cat.idCategoria
GROUP BY cat.nome
ORDER BY QtdLocacoes DESC;

-- 7. AGREGAÇÃO (MAX/MIN): Análise de preços
--  Maior e menor diária praticada no catálogo.
SELECT 
    MAX(valorDiariaPadrao) AS DiariaMaisCara,
    MIN(valorDiariaPadrao) AS DiariaMaisBarata,
    AVG(valorDiariaPadrao) AS MediaPreco
FROM categoria;

-- 8. SUBCONSULTA: Top 3 Clientes (Corrigida para MySQL)
--  Ranking dos melhores clientes (VIPs).
-- Nota: Tive que usar Derived Table (Subquery no FROM) para contornar a limitação do LIMIT no IN.
SELECT 
    c.nome, 
    c.cpf, 
    top.TotalGasto
FROM cliente c
INNER JOIN (
    SELECT idCliente, SUM(valorFinal) as TotalGasto
    FROM locacao
    WHERE valorFinal IS NOT NULL
    GROUP BY idCliente
    ORDER BY TotalGasto DESC
    LIMIT 3
) AS top ON c.idCliente = top.idCliente;

-- 9. VALIDAÇÃO DA PROCEDURE E FUNCTION (Testes Finais)

-- A: Verifica estado atual da locação 2 (que está em aberto)
SELECT 'ANTES DA BAIXA' as Cenario, idLocacao, dtDevolucao, valorFinal, multa 
FROM locacao WHERE idLocacao = 2;

-- B: Executar Procedure (Simulando devolução com 2 dias de atraso)
-- Locação 2 era do veiculo 6 (Compass), devolução prevista 04/11. 
-- Entregando dia 06/11 com 5200km na Filial 2.
CALL sp_registrar_devolucao(2, '2025-11-06 10:00:00', 5200, 2);

-- C: Verifica estado após a baixa (Valor deve estar calculado e data preenchida)
SELECT 'DEPOIS DA BAIXA' as Cenario, idLocacao, dtDevolucao, valorFinal, multa 
FROM locacao WHERE idLocacao = 2;

-- D: Teste isolado da Function (Cálculo de multa)
-- 5 dias de atraso x 100 reais a diária = (5 * 50) = 250 reais de multa
SELECT fn_calcular_multa(5, 100.00) AS TesteCalculoMulta;