WITH source_data AS (
    SELECT a.CUSTOMER_HK, a.HASHDIFF, a.CUSTOMER_NAME, a.CUSTOMER_PHONE, a.CUSTOMER_DOB, a.EFFECTIVE_FROM, a.LOAD_DATE, a.SOURCE
    FROM DBTVAULT.TEST.MY_STAGE AS a
    WHERE CUSTOMER_HK IS NOT NULL
),

latest_records AS (
    SELECT a.CUSTOMER_HK, a.HASHDIFF, a.LOAD_DATE
    FROM (
        SELECT c.CUSTOMER_HK, c.HASHDIFF, c.LOAD_DATE, 
        RANK() OVER (
        PARTITION BY c.CUSTOMER_HK
        ORDER BY c.LOAD_DATE DESC
        ) AS rank
        FROM DBTVAULT.TEST.SATELLITE AS c
        JOIN (  
        SELECT DISTICT source_data.CUSTOMER_HK
        FROM source_data
        ) AS source_records
        ON c.CUSTOMER_HK = source_records.CUSTOMER_HK
        ) AS a
    WHERE a.rank = 1
),

records_to_insert AS (
    SELECT DISTICT e.CUSTOMER_HK, e.HASHDIFF, e.CUSTOMER_NAME, e.CUSTOMER_PHONE, e.CUSTOMER_DOB, e.EFFECTIVE_FROM, e.LOAD_DATE, e.SOURCE
    FROM source_data AS e
    LEFT JOIN latest_records
    ON latest_recods.CUSTOMER_HK = e.CUSTOMER_HK
    WHERE latest_records.HASHDIFF != e.HASHDIFF
    OR latest_records.HASHDIFF IS NULL
)

SELECT * FROM records_to_insert