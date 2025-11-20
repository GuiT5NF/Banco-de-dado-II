# 📈 Análise de Mercado & Big Data Financeiro

![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white) ![Data Science](https://img.shields.io/badge/Data%20Science-Anal%C3%ADtico-orange?style=for-the-badge) ![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-green?style=for-the-badge)

## 📖 Sobre o Projeto

Este projeto consiste na modelagem e implementação de um banco de dados relacional robusto voltado para o **Mercado Financeiro**. O objetivo é simular um ambiente de *Big Data*, capaz de armazenar histórico de cotações, perfis de empresas e indicadores econômicos, processando esses dados diretamente no SGBD para gerar insights de valor e garantir a segurança da informação.

A arquitetura foca em **Análise de Risco** (via Stored Procedures) e **Auditoria de Dados** (via Triggers).

---

## ⚙️ Funcionalidades Principais

### 1. Auditoria e Rastreabilidade (Triggers)
Para garantir a integridade e o rastreamento dos dados inseridos no sistema, foi implementada uma estratégia de *Change Data Capture* (CDC) simplificada.

**Tabela de Log:**
Estrutura responsável por armazenar o histórico de inserções para auditoria.

```sql
CREATE TABLE log_alteracoes (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    tabela_modificada VARCHAR(50),
    descricao_mudanca TEXT,
    data_hora_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Trigger trg_after_insert_cotacoes_historicos: Este gatilho é disparado automaticamente após cada INSERT na tabela de cotações. Ele captura os dados críticos e grava um registro detalhado na tabela de log.

**Código do Trigger**

```sql
DELIMITER $$

CREATE TRIGGER trg_after_insert_cotacoes_historicos
AFTER INSERT ON cotacoes_historicos
FOR EACH ROW
BEGIN
    INSERT INTO log_alteracoes (tabela_modificada, descricao_mudanca)
    VALUES (
        'cotacoes_historicos',
        CONCAT(
            'Nova cotação inserida com ID ', NEW.id_cotacoes, '. ',
            'Empresa ID: ', NEW.empresas_id_empresas, ', ',
            'Data: ', NEW.data_cotacao, ', ',
            'Fechamento: ', NEW.fechamento, ', ',
            'Volume: ', NEW.volume, '.'
        )
    );
END$$

DELIMITER ;
```

### 2. Motor Analítico de Risco (Stored Procedures)
Em vez de extrair milhões de linhas para processar na aplicação, utilizamos o poder do SQL para realizar cálculos estatísticos complexos diretamente no banco.

Procedure sp_analise_risco_volatilidade: Esta rotina calcula a instabilidade de um ativo em um período determinado.

Conceito: O risco é calculado através do Coeficiente de Variação.

Lógica: Dividimos a volatilidade (Desvio Padrão) pelo preço médio. Isso normaliza o risco em uma porcentagem, permitindo comparar a instabilidade de ações baratas (ex: R$ 5,00) com ações caras (ex: R$ 100,00) na mesma escala.

```sql
DELIMITER $$

CREATE PROCEDURE sp_analise_risco_volatilidade(
    IN p_data_inicio DATE,
    IN p_data_fim DATE
)
BEGIN
    SELECT 
        e.ticker,
        ROUND(STDDEV(ch.fechamento), 2) AS volatilidade_preco,
        ROUND(AVG(ch.fechamento), 2) AS preco_medio,
        -- Coeficiente de Variação (CV) normaliza o risco em porcentagem
        ROUND((STDDEV(ch.fechamento) / AVG(ch.fechamento)) * 100, 2) AS risco_relativo_pct
    FROM cotacoes_historicos ch
    JOIN empresas e ON ch.empresas_id_empresas = e.id_empresas
    WHERE ch.data_cotacao BETWEEN p_data_inicio AND p_data_fim
    GROUP BY e.ticker
    ORDER BY risco_relativo_pct DESC; -- Ordena do maior risco para o menor
END $$

DELIMITER ;
```
## 🚀 Como Executar

### 1. Configuração: Importe o script SQL principal para o seu servidor MySQL 8.0+
### 2. Teste de Auditoria:

```sql
-- Insira uma nova cotação e verifique a tabela de logs
INSERT INTO cotacoes_historicos (...) VALUES (...);
SELECT * FROM log_alteracoes;
```
### 3.Análise de Risco:

```sql
-- Chame a procedure definindo o período de análise
CALL sp_analise_risco_volatilidade('2025-08-01', '2025-09-10');
```


<p align="center"> Desenvolvido com foco em Engenharia de Dados e Análise Financeira. </p>
