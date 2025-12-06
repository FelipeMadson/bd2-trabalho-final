
CREATE DATABASE IF NOT EXISTS locadora_veiculos;
USE locadora_veiculos;

-- 1. Tabela FILIAL 
CREATE TABLE filial (
    idFilial INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(80) NOT NULL,
    uf CHAR(2) NOT NULL
);

-- 2. Tabela CATEGORIA 
CREATE TABLE categoria (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(255),
    valorDiariaPadrao DECIMAL(10,2) NOT NULL CHECK (valorDiariaPadrao > 0)
);

-- 3. Tabela CLIENTE
CREATE TABLE cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_cliente_nome (nome)
);

-- 4. Tabela FUNCIONARIO
CREATE TABLE funcionario (
    idFunc INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    email VARCHAR(100),
    idFilial INT NOT NULL,
    FOREIGN KEY (idFilial) REFERENCES filial(idFilial)
);

-- 5. Tabela VEICULO
CREATE TABLE veiculo (
    idVeiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa CHAR(7) NOT NULL UNIQUE,
    renavam VARCHAR(20) NOT NULL UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    idCategoria INT NOT NULL,
    idFilialAtual INT NOT NULL,
    status ENUM('DISPONIVEL', 'ALUGADO', 'MANUTENCAO') DEFAULT 'DISPONIVEL',
    FOREIGN KEY (idCategoria) REFERENCES categoria(idCategoria),
    FOREIGN KEY (idFilialAtual) REFERENCES filial(idFilial),
    INDEX idx_veiculo_placa (placa)
);

-- 6. Tabela RESERVA
CREATE TABLE reserva (
    idReserva INT PRIMARY KEY AUTO_INCREMENT,
    idCliente INT NOT NULL,
    idVeiculo INT NOT NULL,
    idFilialRetirada INT NOT NULL,
    idFilialDevolucaoPrev INT NOT NULL,
    dtInicioPrev DATETIME NOT NULL,
    dtFimPrev DATETIME NOT NULL,
    statusReserva ENUM('ATIVA', 'CONCLUIDA', 'CANCELADA') DEFAULT 'ATIVA',
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idVeiculo) REFERENCES veiculo(idVeiculo),
    FOREIGN KEY (idFilialRetirada) REFERENCES filial(idFilial),
    FOREIGN KEY (idFilialDevolucaoPrev) REFERENCES filial(idFilial)
);

-- 7. Tabela LOCACAO
CREATE TABLE locacao (
    idLocacao INT PRIMARY KEY AUTO_INCREMENT,
    idReserva INT UNIQUE, -- 1:1 com reserva (opcional, pode ser null se locar no balcão)
    idCliente INT NOT NULL,
    idVeiculo INT NOT NULL,
    idFilialRetirada INT NOT NULL,
    dtRetirada DATETIME NOT NULL,
    kmRetirada INT NOT NULL,
    idFilialDevolucao INT, -- Preenchido na devolução
    dtDevolucao DATETIME,   -- Preenchido na devolução
    kmDevolucao INT,        -- Preenchido na devolução
    valorDiaria DECIMAL(10,2) NOT NULL, -- Congela o valor no momento da locação
    taxas DECIMAL(10,2) DEFAULT 0.00,
    multa DECIMAL(10,2) DEFAULT 0.00,
    valorFinal DECIMAL(10,2), -- Calculado no fim
    FOREIGN KEY (idReserva) REFERENCES reserva(idReserva),
    FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
    FOREIGN KEY (idVeiculo) REFERENCES veiculo(idVeiculo),
    FOREIGN KEY (idFilialRetirada) REFERENCES filial(idFilial),
    FOREIGN KEY (idFilialDevolucao) REFERENCES filial(idFilial)
);

-- Tabela de Logs (Truncate)
CREATE TABLE log_sistema (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255),
    dataLog DATETIME DEFAULT CURRENT_TIMESTAMP
);