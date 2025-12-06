

USE locadora_veiculos;

-- 1. Inserindo FILIAIS 
INSERT INTO filial (nome, cidade, uf) VALUES
('Matriz Centro', 'São Paulo', 'SP'),       -- ID 1
('Filial Aeroporto', 'Guarulhos', 'SP'),    -- ID 2
('Filial Barra', 'Rio de Janeiro', 'RJ');   -- ID 3

-- 2. Inserindo CATEGORIAS 
INSERT INTO categoria (nome, descricao, valorDiariaPadrao) VALUES
('Econômico', 'Carros 1.0, econômicos, ar condicionado', 100.00), -- ID 1
('Intermediário', 'Sedans confortáveis, motor 1.6 ou superior', 180.00), -- ID 2
('SUV', 'Utilitários Esportivos, espaço para família', 250.00), -- ID 3
('Luxo', 'Carros premium importados, alto desempenho', 500.00), -- ID 4
('Utilitário', 'Picapes para carga e trabalho', 220.00); -- ID 5

-- 3. Inserindo CLIENTES 
INSERT INTO cliente (nome, cpf, email, telefone) VALUES
('João Silva', '11111111111', 'joao@gmail.com', '11999990001'),       -- ID 1
('Maria Oliveira', '22222222222', 'maria@hotmail.com', '11999990002'), -- ID 2
('Carlos Souza', '33333333333', 'carlos@empresa.com', '21999990003'),  -- ID 3
('Ana Costa', '44444444444', 'ana@uol.com.br', '21999990004'),         -- ID 4
('Pedro Santos', '55555555555', 'pedro@tech.com', '31999990005'),      -- ID 5
('Lucia Ferreira', '66666666666', 'lucia@gmail.com', '31999990006'),   -- ID 6
('Roberto Lima', '77777777777', 'roberto@outlook.com', '41999990007'), -- ID 7
('Fernanda Alves', '88888888888', 'fernanda@live.com', '41999990008'), -- ID 8
('Bruno Dias', '99999999999', 'bruno@yahoo.com', '11988881111'),       -- ID 9
('Amanda Nunes', '00000000000', 'amanda@bol.com.br', '21988882222');   -- ID 10

-- 4. Inserindo FUNCIONÁRIOS 
INSERT INTO funcionario (nome, cpf, email, idFilial) VALUES
('Gerente Marcos', '12312312300', 'marcos@locadora.com', 1),
('Atendente Julia', '32132132100', 'julia@locadora.com', 2),
('Mecânico Paulo', '45645645600', 'paulo@locadora.com', 3);

-- 5. Inserindo VEÍCULOS 

INSERT INTO veiculo (placa, renavam, marca, modelo, ano, idCategoria, idFilialAtual, status) VALUES
('ABC1234', '100000001', 'Fiat', 'Mobi', 2023, 1, 1, 'DISPONIVEL'),    -- ID 1
('ABC1235', '100000002', 'VW', 'Gol', 2023, 1, 1, 'ALUGADO'),         -- ID 2 (Em uso)
('ABC1236', '100000003', 'Chevrolet', 'Onix', 2024, 1, 2, 'DISPONIVEL'), -- ID 3
('DEF1234', '200000001', 'Toyota', 'Corolla', 2024, 2, 1, 'DISPONIVEL'), -- ID 4
('DEF1235', '200000002', 'Honda', 'Civic', 2023, 2, 3, 'DISPONIVEL'),    -- ID 5
('GHI1234', '300000001', 'Jeep', 'Compass', 2024, 3, 2, 'ALUGADO'),      -- ID 6 (Em uso)
('GHI1235', '300000002', 'VW', 'T-Cross', 2023, 3, 1, 'DISPONIVEL'),     -- ID 7
('JKL1234', '400000001', 'BMW', '320i', 2024, 4, 1, 'MANUTENCAO'),       -- ID 8 (Oficina)
('MNO1234', '500000001', 'Fiat', 'Strada', 2023, 5, 3, 'DISPONIVEL'),    -- ID 9
('PQR1111', '600000001', 'Hyundai', 'HB20', 2023, 1, 1, 'DISPONIVEL'),   -- ID 10
('PQR2222', '600000002', 'Renault', 'Kwid', 2023, 1, 2, 'DISPONIVEL'),   -- ID 11
('PQR3333', '600000003', 'Nissan', 'Versa', 2023, 2, 3, 'DISPONIVEL'),   -- ID 12
('PQR4444', '600000004', 'Jeep', 'Renegade', 2024, 3, 1, 'DISPONIVEL'),  -- ID 13
('PQR5555', '600000005', 'Mercedes', 'C180', 2024, 4, 1, 'DISPONIVEL'),  -- ID 14
('PQR6666', '600000006', 'Fiat', 'Toro', 2023, 5, 2, 'ALUGADO'),         -- ID 15 (Em uso)
('PQR7777', '600000007', 'VW', 'Polo', 2024, 1, 3, 'DISPONIVEL'),        -- ID 16
('PQR8888', '600000008', 'Chevrolet', 'Cruze', 2023, 2, 1, 'DISPONIVEL'),-- ID 17
('PQR9999', '600000009', 'Toyota', 'Hilux', 2024, 5, 2, 'DISPONIVEL'),   -- ID 18
('STU1010', '600000010', 'Honda', 'HRV', 2024, 3, 3, 'DISPONIVEL'),      -- ID 19
('STU2020', '600000011', 'Audi', 'A3', 2024, 4, 1, 'DISPONIVEL');        -- ID 20

-- 6. Inserindo RESERVAS 
-- Reservas passadas (já viraram locação), futuras e canceladas
INSERT INTO reserva (idCliente, idVeiculo, idFilialRetirada, idFilialDevolucaoPrev, dtInicioPrev, dtFimPrev, statusReserva) VALUES
(1, 2, 1, 1, '2025-11-01 10:00:00', '2025-11-05 10:00:00', 'CONCLUIDA'), -- 1 (Já virou locação)
(2, 6, 2, 2, '2025-11-02 08:00:00', '2025-11-04 08:00:00', 'ATIVA'),     -- 2 (Está rodando agora)
(3, 3, 1, 2, '2025-11-10 12:00:00', '2025-11-15 12:00:00', 'CONCLUIDA'), -- 3
(4, 4, 1, 1, '2025-11-12 09:00:00', '2025-11-13 09:00:00', 'CONCLUIDA'), -- 4
(5, 5, 3, 3, '2025-11-14 14:00:00', '2025-11-16 14:00:00', 'CONCLUIDA'), -- 5
(6, 15, 2, 1, '2025-11-20 08:00:00', '2025-11-25 08:00:00', 'ATIVA'),    -- 6 (Está rodando agora)
(7, 7, 1, 1, '2025-11-22 10:00:00', '2025-11-23 10:00:00', 'CONCLUIDA'), -- 7
(8, 1, 1, 1, '2025-11-25 10:00:00', '2025-11-30 10:00:00', 'CONCLUIDA'), -- 8
(9, 2, 1, 1, '2025-12-20 08:00:00', '2025-12-25 08:00:00', 'ATIVA'),     -- 9 (Reserva futura)
(10, 20, 1, 1, '2025-12-24 12:00:00', '2025-12-26 12:00:00', 'ATIVA'),   -- 10 (Reserva futura)
(1, 8, 1, 1, '2025-11-05 10:00:00', '2025-11-06 10:00:00', 'CANCELADA'), -- 11 (Cancelou)
(2, 9, 3, 3, '2025-11-08 09:00:00', '2025-11-10 09:00:00', 'CONCLUIDA'); -- 12

-- 7. Inserindo LOCAÇÕES 

-- Locações 1, 3, 4, 5, 6, 7, 9 são FINALIZADAS (tem dtDevolucao e valorFinal).
-- Locações 2, 8, 10 são ABERTAS (dtDevolucao NULL). Os carros vinculados devem ser ALUGADO na tabela veiculo.

INSERT INTO locacao (idReserva, idCliente, idVeiculo, idFilialRetirada, dtRetirada, kmRetirada, idFilialDevolucao, dtDevolucao, kmDevolucao, valorDiaria, taxas, multa, valorFinal) VALUES
-- 1. Locação Finalizada (Reserva 1) - Cliente 1, Veiculo 2
(1, 1, 2, 1, '2025-11-01 10:05:00', 10000, 1, '2025-11-05 10:00:00', 10500, 100.00, 50.00, 0.00, 450.00),

-- 2. Locação EM ABERTO (Reserva 2) - Cliente 2, Veiculo 6 (Compass) [Status ALUGADO]
(2, 2, 6, 2, '2025-11-02 08:00:00', 5000, NULL, NULL, NULL, 250.00, 0.00, 0.00, NULL),

-- 3. Locação Finalizada (Reserva 3) - Cliente 3, Veiculo 3
(3, 3, 3, 1, '2025-11-10 12:15:00', 20000, 2, '2025-11-15 13:00:00', 20800, 100.00, 30.00, 0.00, 530.00),

-- 4. Locação Finalizada (Reserva 4) - Cliente 4, Veiculo 4
(4, 4, 4, 1, '2025-11-12 09:00:00', 15000, 1, '2025-11-13 10:00:00', 15100, 180.00, 0.00, 90.00, 270.00), -- Com atraso e multa

-- 5. Locação Finalizada (Reserva 5) - Cliente 5, Veiculo 5
(5, 5, 5, 3, '2025-11-14 14:00:00', 8000, 3, '2025-11-16 14:00:00', 8300, 180.00, 20.00, 0.00, 380.00),

-- 6. Locação Finalizada (Sem Reserva Prévia - Balcão) - Cliente 9, Veiculo 10
(NULL, 9, 10, 1, '2025-11-18 08:00:00', 1000, 1, '2025-11-19 08:00:00', 1100, 100.00, 10.00, 0.00, 110.00),

-- 7. Locação Finalizada (Reserva 7) - Cliente 7, Veiculo 7
(7, 7, 7, 1, '2025-11-22 10:00:00', 30000, 1, '2025-11-23 10:00:00', 30200, 250.00, 0.00, 0.00, 250.00),

-- 8. Locação EM ABERTO (Reserva 6) - Cliente 6, Veiculo 15 (Toro) [Status ALUGADO]
(6, 6, 15, 2, '2025-11-20 08:00:00', 12000, NULL, NULL, NULL, 220.00, 0.00, 0.00, NULL),

-- 9. Locação Finalizada (Reserva 8) - Cliente 8, Veiculo 1
(8, 8, 1, 1, '2025-11-25 10:00:00', 500, 1, '2025-11-30 10:00:00', 900, 100.00, 50.00, 0.00, 550.00),

-- 10. Locação EM ABERTO (Sem Reserva - Balcão) - Cliente 10, Veiculo 2 (Gol) [Status ALUGADO]
-- Nota: O Gol já tinha sido devolvido na locação 1, agora foi alugado de novo.
(NULL, 10, 2, 1, '2025-12-01 09:00:00', 10500, NULL, NULL, NULL, 100.00, 0.00, 0.00, NULL);