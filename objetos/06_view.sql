
USE locadora_veiculos;

-- VIEW 1: Relatório de Faturamento Mensal por Filial
CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT 
    f.nome AS Filial,
    DATE_FORMAT(l.dtDevolucao, '%Y-%m') AS MesReferencia,
    COUNT(l.idLocacao) AS QtdLocacoesFinalizadas,
    SUM(l.valorFinal) AS FaturamentoTotal
FROM locacao l
JOIN filial f ON l.idFilialDevolucao = f.idFilial
WHERE l.valorFinal IS NOT NULL -- Pega apenas locações já pagas/finalizadas
GROUP BY f.nome, MesReferencia
ORDER BY MesReferencia DESC;


-- VIEW 2: Indicadores de Utilização da Frota
CREATE OR REPLACE VIEW vw_utilizacao_frota AS
SELECT 
    c.nome AS Categoria,
    COUNT(v.idVeiculo) AS TotalVeiculos,
    SUM(CASE WHEN v.status = 'DISPONIVEL' THEN 1 ELSE 0 END) AS Disponiveis,
    SUM(CASE WHEN v.status = 'ALUGADO' THEN 1 ELSE 0 END) AS EmUso,
    SUM(CASE WHEN v.status = 'MANUTENCAO' THEN 1 ELSE 0 END) AS EmManutencao
FROM veiculo v
JOIN categoria c ON v.idCategoria = c.idCategoria
GROUP BY c.nome;