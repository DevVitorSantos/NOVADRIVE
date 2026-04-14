# 🚗 Nova Drive Motors — Pipeline de Engenharia de Dados

> Projeto de aprendizado e evolução em Engenharia de Dados, cobrindo todo o ciclo: ingestão, orquestração, armazenamento em nuvem e visualização de dados.

---
![Pipeline IA](https://seucafezinho.com.br/wp-content/uploads/2026/04/projeto-Engenharia-de-dados-BI.jpg)

## 📌 Visão Geral

Este projeto simula um pipeline de dados completo para uma empresa fictícia de venda de veículos chamada **Nova Drive Motors**. O objetivo foi aplicar na prática conceitos fundamentais de Engenharia de Dados, desde a extração de dados de um banco relacional até a construção de um dashboard analítico.

---

## 🏗️ Arquitetura do Projeto

```
PostgreSQL (Fonte)
      │
      ▼
Apache Airflow (Orquestração)
  [EC2 + Ubuntu + Docker na AWS]
      │
      ▼
Snowflake (Data Warehouse)
  [Raw Layer → Analytics Layer]
      │
      ▼
Looker Studio / BI (Visualização)
```

A arquitetura é dividida em 4 camadas principais:

| Camada | Tecnologia | Função |
|--------|-----------|--------|
| **Fonte** | PostgreSQL | Banco de dados transacional com dados de vendas |
| **Orquestração** | Apache Airflow (AWS EC2 + Docker) | Agendamento e execução das pipelines |
| **Armazenamento** | Snowflake | Data Warehouse em nuvem (Raw + Analytics) |
| **Visualização** | Looker Studio | Dashboard analítico de vendas |

---

## ⚙️ Tecnologias Utilizadas

- **PostgreSQL** — banco de dados relacional de origem
- **Apache Airflow** — orquestração dos DAGs de ingestão
- **Amazon Web Services (AWS)** — infraestrutura em nuvem (EC2)
- **Ubuntu + Docker** — ambiente de execução do Airflow
- **Snowflake** — Data Warehouse com separação de camadas (Raw/Analytics)
- **Looker Studio** — criação do dashboard final

---

## 🔄 Pipeline de Dados (Airflow DAG)
![Airflow](https://seucafezinho.com.br/wp-content/uploads/2026/04/airflow-to-snowflake.jpg)

O DAG `postgres_to_snowflake_2` realiza a ingestão incremental dos dados do PostgreSQL para o Snowflake. Para cada tabela, são executadas duas tasks em sequência:

1. **`get_max_id_<tabela>`** — consulta o maior ID já carregado no Snowflake (controle de incrementalidade)
2. **`load_data_<tabela>`** — carrega os registros novos do PostgreSQL para o Snowflake

### Tabelas ingeridas:
![Tabelas](https://seucafezinho.com.br/wp-content/uploads/2026/04/schema.jpg)

- `concessionarias`
- `estados`
- `vendedores`
- `veiculos`
- `vendas`
- `cidades`
- `clientes`

---

## 📊 Dashboard — Nova Drive Motors
![Dashboard](https://seucafezinho.com.br/wp-content/uploads/2026/04/dashboard.jpg)

O dashboard foi construído no **Looker Studio** conectado ao Snowflake e apresenta:

- **Total Faturado:** R$ 458,8 milhões
- **Produtos Vendidos:** 1.331
- **Mapa interativo** com distribuição geográfica das vendas por cidade/estado
- **Ranking de estados** por faturamento (São Paulo lidera com ~25% do total)
- **Filtros dinâmicos** por Estado e Cidade

---

## 📁 Estrutura do Repositório

```
📦 NOVADRIVE
 ┣ 📂 macros/              # Macros reutilizáveis do dbt
 ┣ 📂 models/              # Modelos de transformação (camadas Raw e Analytics)
 ┣ 📂 seeds/               # Dados estáticos carregados via dbt seed
 ┣ 📂 snapshots/           # Snapshots para captura de mudanças (SCD Type 2)
 ┣ 📂 tests/               # Testes de qualidade de dados
 ┣ 📄 dbt_project.yml      # Configuração principal do projeto dbt
 ┣ 📄 .gitignore
 ┗ 📄 README.md
```

---

## 📚 Aprendizados

Este projeto me permitiu praticar e consolidar os seguintes conceitos:

- ✅ Ingestão incremental de dados com controle por ID
- ✅ Criação e orquestração de DAGs no Apache Airflow
- ✅ Configuração de ambiente com Docker na AWS (EC2)
- ✅ Modelagem e carregamento de dados no Snowflake
- ✅ Construção de dashboards analíticos no Looker Studio
- ✅ Boas práticas de pipeline: idempotência, modularidade e reuso

---

## 🎯 Próximos Passos

- [ ] Adicionar testes de qualidade de dados com **Great Expectations** ou **dbt tests**
- [ ] Implementar camada de transformação com **dbt**
- [ ] Configurar alertas de falha no Airflow via e-mail/Slack
- [ ] Adicionar suporte a carga histórica (backfill)

---

## 👨‍💻 Autor

Desenvolvido como projeto de aprendizado e evolução na carreira de **Engenharia de Dados**.

---

> *"A melhor forma de aprender Engenharia de Dados é construindo pipelines reais."*
