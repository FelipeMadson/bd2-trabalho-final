
 -- Lógica de negócio no banco (Cálculo de multa e baixa de locação)


USE locadora_veiculos;


DELIMITER //

-- 1. FUNCTION: fn_calcular_multa
-- Calcula o valor da multa baseado nos dias de atraso e valor da diária.
-- Regra: 50% do valor da diária por cada dia de atraso.

DROP FUNCTION IF EXISTS fn_calcular_multa //

CREATE FUNCTION fn_calcular_multa(diasAtraso INT, valorDiaria DECIMAL(10,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE valorMulta DECIMAL(10,2);

    -- Se não houve atraso (dias <= 0), a multa é zero
    IF diasAtraso <= 0 THEN
        SET valorMulta = 0.00;
    ELSE
        -- Cálculo: Dias de Atraso * (Metade da Diária)
        SET valorMulta = diasAtraso * (valorDiaria * 0.5);
    END IF;

    RETURN valorMulta;
END //

DROP PROCEDURE IF EXISTS sp_registrar_devolucao //

CREATE PROCEDURE sp_registrar_devolucao(
    IN p_idLocacao INT,
    IN p_dtDevolucao DATETIME,
    IN p_kmDevolucao INT,
    IN p_idFilialDevolucao INT
)
BEGIN
    -- Declaração de variáveis para armazenar dados atuais
    DECLARE v_dtFimPrev DATETIME;
    DECLARE v_valorDiaria DECIMAL(10,2);
    DECLARE v_dtRetirada DATETIME;
    DECLARE v_taxas DECIMAL(10,2);
    DECLARE v_idVeiculo INT;
    
    -- Variáveis para cálculos
    DECLARE v_diasLocados INT;
    DECLARE v_diasAtraso INT;
    DECLARE v_multa DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);

    -- 1. Buscar informações da locação e da reserva
    -- Usamos LEFT JOIN pois pode ser uma locação de balcão (sem reserva prévia)
    SELECT 
        l.valorDiaria, 
        l.dtRetirada, 
        l.taxas, 
        l.idVeiculo, 
        r.dtFimPrev 
    INTO 
        v_valorDiaria, 
        v_dtRetirada, 
        v_taxas, 
        v_idVeiculo, 
        v_dtFimPrev
    FROM locacao l
    LEFT JOIN reserva r ON l.idReserva = r.idReserva
    WHERE l.idLocacao = p_idLocacao;

    -- 2. Calcular dias locados (Duração real)
    -- DATEDIFF retorna a diferença em dias
    SET v_diasLocados = DATEDIFF(p_dtDevolucao, v_dtRetirada);
    
    -- Regra de negócio: Se devolver no mesmo dia ou menos de 24h, cobra 1 diária mínima
    IF v_diasLocados <= 0 THEN 
        SET v_diasLocados = 1; 
    END IF;

    -- 3. Calcular atraso
    -- Se não tiver reserva (v_dtFimPrev é NULL), assumimos que não há atraso
    IF v_dtFimPrev IS NULL THEN
        SET v_diasAtraso = 0;
    ELSE
        SET v_diasAtraso = DATEDIFF(p_dtDevolucao, v_dtFimPrev);
    END IF;

    -- 4. Calcular Multa (Chamando a FUNCTION criada acima)
    SET v_multa = fn_calcular_multa(v_diasAtraso, v_valorDiaria);

    -- 5. Calcular Valor Final
    -- Fórmula: (Dias x Diária) + Taxas Iniciais + Multa
    SET v_total = (v_diasLocados * v_valorDiaria) + v_taxas + v_multa;

    -- 6. Atualizar a tabela LOCACAO (Fechando o contrato)
    UPDATE locacao 
    SET dtDevolucao = p_dtDevolucao,
        kmDevolucao = p_kmDevolucao,
        idFilialDevolucao = p_idFilialDevolucao,
        multa = v_multa,
        valorFinal = v_total
    WHERE idLocacao = p_idLocacao;

    -- 7. Atualizar a tabela VEICULO (Liberando para próximo aluguel)
    UPDATE veiculo 
    SET status = 'DISPONIVEL', 
        idFilialAtual = p_idFilialDevolucao 
    WHERE idVeiculo = v_idVeiculo;
    
END //

-- Restaurando o delimitador padrão
DELIMITER ;