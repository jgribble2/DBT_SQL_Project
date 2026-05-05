WITH orders AS (
    SELECT *
    FROM {{ source('raw', 'orders') }}
),
customers AS (
    SELECT *
    FROM {{ source('raw', 'customers') }}
),
products AS (
    SELECT *
    FROM {{ source('raw', 'products') }}
),
dates AS (
    SELECT *
    FROM {{ source('raw', 'dates') }}
)

SELECT
    *
FROM
    orders AS o
LEFT JOIN
    customers AS c
    ON o.cust_id = c.cust_id
LEFT JOIN
    products AS p
    ON o.produkt_id = p.product_id
LEFT JOIN
    dates AS d
    ON o.dt_id = d.date_id
WHERE
    o.ordr_id IS NOT NULL
    AND o.cust_id IS NOT NULL
    AND o.produkt_id IS NOT NULL
    AND o.dt_id IS NOT NULL
    AND o.statsus = 'COMPLETE'
    AND o.qty IS NOT NULL
    AND o.rev IS NOT NULL