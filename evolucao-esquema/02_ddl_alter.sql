
USE locadora_veiculos;

-- 1. Alteração na tabela CLIENTE
-- Motivo: Percebi durante os testes que alguns e-mails corporativos são muito longos.
-- Decidi aumentar o tamanho do campo de 150 para 200 caracteres para evitar truncamento.
ALTER TABLE cliente MODIFY COLUMN email VARCHAR(200) NOT NULL;

-- 2. Alteração na tabela VEICULO
-- Motivo: O sistema precisava registrar pequenos detalhes do carro (arranhões, amassados)
-- antes da locação. Adicionei uma coluna de observações do tipo TEXT.
ALTER TABLE veiculo ADD COLUMN observacoes TEXT NULL AFTER status;

-- 3. Alteração na tabela FILIAL
-- Motivo: Adicionei um campo para registrar o telefone fixo da filial, que esqueci no modelo inicial.
ALTER TABLE filial ADD COLUMN telefoneContato VARCHAR(20) NULL;