# Sistema de Locação de Veículos (SQL)

Este projeto consiste na modelagem e implementação de um banco de dados relacional para uma locadora de veículos. O foco principal foi a criação da estrutura física (DDL), inserção de dados de teste (DML) e a criação de **Views** estratégicas para facilitar a geração de relatórios. Sendo o trabalho final de Banco de Dados II.

## Sobre o Projeto

O objetivo foi simular um cenário real de gestão de locadora, onde é necessário controlar:
* **Clientes:** Dados pessoais e de contato.
* **Veículos:** Marca, modelo, ano, placa e status de disponibilidade.
* **Locações:** Registro de quem alugou qual carro, datas de retirada/devolução e valores.

A atividade culminou na criação de **Views** (Visões) para abstrair consultas complexas.

## Tecnologias Utilizadas

* **MySQL Server** (8.0+)
* **MySQL Workbench** (para modelagem e execução de scripts)
* **SQL Puro** (DDL, DML, DQL)

---

## Como Executar

Para rodar este projeto na sua máquina:

1.  **Clone o repositório:**
    ```bash
    git clone (https://github.com/FelipeMadson/bd2-trabalho-final.git)
    ```

2.  **Abra seu gerenciador de Banco de Dados** (ex: MySQL Workbench, DBeaver).

3.  **Crie o Banco de Dados:**
    ```sql
    CREATE DATABASE locadora_veiculos;
    USE locadora_veiculos;
    ```

4.  **Importe o Script:**
    * Execute todo o script para criar as tabelas, inserir os dados e criar as Views.

---

## Estrutura e Views (Relatórios)

Abaixo estão listadas as **Views** desenvolvidas nesta atividade para facilitar a consulta de dados:

### 1. `vw_relatorio_clientes`
Esta view consolida os dados essenciais dos clientes para contato rápido.
* **Colunas:** Nome Completo, Email, Telefone, Cidade/Estado.
* **Uso:**
    ```sql
    SELECT * FROM vw_relatorio_clientes;
    ```

### 2. `vw_veiculos_disponiveis`
Filtra apenas os veículos que não estão locados ou em manutenção no momento.
* **Colunas:** Marca, Modelo, Ano, Cor, Valor da Diária.
* **Uso:**
    ```sql
    SELECT * FROM vw_veiculos_disponiveis ORDER BY valor_diaria ASC;
    ```

### 3. `vw_locacoes_ativas`
Relatório gerencial que mostra as locações que estão ocorrendo no momento (carros que ainda não foram devolvidos).
* **Colunas:** Nome do Cliente, Modelo do Veículo, Data de Retirada, Previsão de Entrega.
* **Uso:**
    ```sql
    SELECT * FROM vw_locacoes_ativas;
    ```

---

##  Diagrama ER (Entidade-Relacionamento)

O sistema conta com as tabelas principais:
* `tb_clientes`
* `tb_veiculos`
* `tb_locacoes`

---
