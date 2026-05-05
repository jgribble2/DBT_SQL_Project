WITH source AS (
    SELECT *
    FROM {{ source('raw', 'orders') }}
)

SELECT
    ordr_id,
    cust_id,
    produkt_id,
    dt_id,
    statsus,
    qty,
    rev
FROM source