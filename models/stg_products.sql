WITH source AS (
    SELECT *
    FROM {{ source('raw', 'products') }}
)

SELECT
    product_id AS product_id,
    product_name AS product_name,
    product_category AS product_category
FROM source