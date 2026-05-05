WITH source AS (
    SELECT *
    FROM {{ source('raw', 'orders') }}
)

SELECT
    ordr_id AS order_id,
    cust_id AS customer_id,
    produkt_id AS product_id,
    dt_id AS date_id,
    statsus AS order_status,
    qty AS quantity,
    rev AS revenue
FROM source
WHERE
    order_id IS NOT NULL
    AND customer_id IS NOT NULL
    AND product_id IS NOT NULL
    AND date_id IS NOT NULL
    AND order_status = 'COMPLETE'
    AND quantity IS NOT NULL
    AND revenue IS NOT NULL