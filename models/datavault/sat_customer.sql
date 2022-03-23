{% set hash_key = "CUSTOMER_HK" %}
{% set attributes = ["CUSTOMER_ID"] %}

WITH source_data AS (
    SELECT 
        a.{{hash_key}},
        a.HASHDIFF,
        a.CUSTOMER_NAME, a.CUSTOMER_PHONE, a.CUSTOMER_DOB, a.EFFECTIVE_FROM,
        a.LOAD_DATETIME,
        a.RECORD_SOURCE
    FROM DBTVAULT.TEST.MY_STAGE AS a
    WHERE {{hash_key}} IS NOT NULL
),

latest_records AS (
    SELECT a.{{hash_key}}, a.HASHDIFF, a.LOAD_DATETIME
    FROM (
        SELECT c.{{hash_key}}, c.HASHDIFF, c.LOAD_DATETIME, 
        RANK() OVER (
        PARTITION BY c.{{hash_key}}
        ORDER BY c.LOAD_DATETIME DESC
        ) AS rank
        FROM DBTVAULT.TEST.SATELLITE AS c
        JOIN (  
        SELECT DISTICT source_data.{{hash_key}}
        FROM source_data
        ) AS source_records
        ON c.{{hash_key}} = source_records.{{hash_key}}
        ) AS a
    WHERE a.rank = 1
),

records_to_insert AS (
    SELECT DISTICT e.{{hash_key}}, e.HASHDIFF, e.CUSTOMER_NAME, e.CUSTOMER_PHONE, e.CUSTOMER_DOB, e.EFFECTIVE_FROM, e.LOAD_DATETIME, e.RECORD_SOURCE
    FROM source_data AS e
    LEFT JOIN latest_records
    ON latest_recods.{{hash_key}} = e.{{hash_key}}
    WHERE latest_records.HASHDIFF != e.HASHDIFF
    OR latest_records.HASHDIFF IS NULL
)

SELECT * FROM records_to_insert