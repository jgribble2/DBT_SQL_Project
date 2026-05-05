WITH source AS (
    SELECT *
    FROM {{ source('raw', 'dates') }}
)

SELECT
    date_id AS date_id,
    date_year AS date_year,
    date_month AS date_month,
    date_day AS date_day
FROM source