WITH source AS (
    SELECT *
    FROM {{ source('raw', 'customers') }}
)

SELECT
    cust_id AS customer_id,
    cust_name AS customer_name,
    cust_region AS customer_region
FROM source
