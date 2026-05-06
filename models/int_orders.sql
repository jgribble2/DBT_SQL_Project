WITH source AS (
    SELECT *
    FROM {{ source('raw', 'orders') }}
),
clean_orders AS (
    SELECT
        ordr_id AS order_id,
        cust_id AS customer_id,
        produkt_id AS product_id,
        dt_id AS date_id,
        statsus AS order_status,
        qty AS quantity,
        rev AS revenue,
        CASE
            WHEN rev >= 1000 THEN 'Large'
            WHEN rev BETWEEN 500 AND 999 THEN 'Medium'
            ELSE 'Small'
        END AS order_size
    FROM source
    WHERE
        order_id IS NOT NULL
        AND customer_id IS NOT NULL
        AND product_id IS NOT NULL
        AND date_id IS NOT NULL
        AND order_status = 'COMPLETE'
        AND quantity IS NOT NULL
        AND revenue IS NOT NULL
)        
SELECT
    customer_id,
    COUNT(*) AS customer_orders,
    SUM(revenue) AS customer_revenue,
    SUM(CASE WHEN order_size = 'Large' THEN 1 ELSE 0 END) AS large_orders,
    SUM(CASE WHEN order_size = 'Medium' THEN 1 ELSE 0 END) AS medium_orders,
    SUM(CASE WHEN order_size = 'Small' THEN 1 ELSE 0 END) AS small_orders
FROM
    clean_orders
GROUP BY
    customer_id
ORDER BY
    customer_revenue DESC