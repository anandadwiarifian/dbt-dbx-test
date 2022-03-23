{% set hash_key = "CUSTOMER_HK" %}
{% set business_key = "CUSTOMER_ID" %}

WITH row_rank_1 AS (
    SELECT {{hash_key}}, {{business_key}}, LOAD_DATETIME, RECORD_SOURCE,
           ROW_NUMBER() OVER(
               PARTITION BY {{hash_key}}
               ORDER BY LOAD_DATETIME
           ) AS row_number
    FROM {{ source('stg_layer', 'stg_customer') }}
    WHERE {{hash_key}} IS NOT NULL
),
row_rank_2 AS (
    SELECT 
        *
    FROM row_rank_1
    WHERE row_number = 1
),
records_to_insert AS (
    SELECT a.{{hash_key}}, a.{{business_key}}, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM row_rank_2 AS a
    {% if is_incremental() %}

    LEFT JOIN {{ source('stg_layer', 'stg_customer') }} AS d
    ON a.{{hash_key}} = d.{{hash_key}}
    WHERE d.{{hash_key}} IS NULL

    {% endif %}
)

SELECT * FROM records_to_insert