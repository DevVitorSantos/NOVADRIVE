{{ config(materialized='table') }}

SELECT
    con.concessionaria_id AS id,                -- ID único da concessionária
    con.nome_concessionaria AS concessionaria, -- Nome da concessionária
    cid.nome_cidade AS cidade,                 -- Cidade da concessionária
    est.nome_estado AS estado,                 -- Estado da concessionária
    COUNT(v.venda_id) AS quantidade,           -- Total de vendas realizadas
    SUM(v.valor_venda) AS total,               -- Receita total
    AVG(v.valor_venda) AS valor_medio          -- Valor médio por venda
FROM {{ ref('fct_vendas') }} v
JOIN {{ ref('dim_concessionarias') }} con ON v.concessionaria_id = con.concessionaria_id
JOIN {{ ref('dim_cidades') }} cid ON con.cidade_id = cid.cidade_id
JOIN {{ ref('dim_estados') }} est ON cid.estado_id = est.estado_id
GROUP BY
    con.concessionaria_id,
    con.nome_concessionaria,
    cid.nome_cidade,
    est.nome_estado
ORDER BY
    total DESC                                 -- Ordena por maior faturamento
