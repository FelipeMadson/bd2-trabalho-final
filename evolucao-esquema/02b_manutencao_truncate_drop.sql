
USE locadora_veiculos;

-- Criando tabela auxiliar de logs
CREATE TABLE IF NOT EXISTS log_sistema_temp (
    idLog INT PRIMARY KEY AUTO_INCREMENT,
    evento VARCHAR(100),
    dataEvento DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Povoando com dados "lixo"
INSERT INTO log_sistema_temp (evento) VALUES ('Erro de login'), ('Tentativa de acesso'), ('Backup realizado');

-- Executando a limpeza total (TRUNCATE)
TRUNCATE TABLE log_sistema_temp;

-- Criando uma view temporária
CREATE OR REPLACE VIEW vw_relatorio_antigo AS
SELECT nome, cpf FROM cliente;

-- Removendo o objeto do banco (DROP) pois ele foi substituído por relatórios mais novos
DROP VIEW vw_relatorio_antigo;