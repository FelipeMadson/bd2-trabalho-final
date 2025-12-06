
USE locadora_veiculos;

-- 1. UPDATE: Correção de Cadastro
UPDATE cliente 
SET telefone = '11977778888' 
WHERE idCliente = 1;


-- 2. UPDATE: Cancelamento de Reserva (Lógica de Negócio)
UPDATE reserva 
SET statusReserva = 'CANCELADA' 
WHERE idReserva = 9;


-- 3. DELETE: Remoção de Veículo

-- Inserindo veículo teste
INSERT INTO veiculo (placa, renavam, marca, modelo, ano, idCategoria, idFilialAtual) 
VALUES ('ZZZ9999', '999999999', 'Teste', 'Para Deletar', 2020, 1, 1);

-- Executando a exclusão física
DELETE FROM veiculo 
WHERE placa = 'ZZZ9999';