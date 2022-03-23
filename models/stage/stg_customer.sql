create
or replace view test_dbt.stg_customer as WITH source_data AS (
  SELECT
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL
  FROM
    test_dbt.raw_customer
),
derived_columns AS (
  SELECT
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    'SAP' AS RECORD_SOURCE
  FROM
    source_data
),
hashed_columns AS (
  SELECT
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    RECORD_SOURCE,
    SHA2(
      COALESCE(TRIM(CAST(CUSTOMER_ID AS STRING)), '^^'),
      256
    ) AS CUSTOMER_HK,
    SHA2(
      CONCAT_WS(
        '||',
        COALESCE(CAST(FIRST_NAME AS STRING), '^^'),
        COALESCE(CAST(LAST_NAME AS STRING), '^^'),
        COALESCE(CAST(EMAIL AS STRING), '^^')
      ),
      256
    ) AS CUSTOMER_HASHDIFF
  FROM
    derived_columns
),
columns_to_select AS (
  SELECT
    CUSTOMER_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    RECORD_SOURCE,
    CUSTOMER_HK,
    CUSTOMER_HASHDIFF
  FROM
    hashed_columns
)
SELECT
  *,
  CURRENT_TIMESTAMP() AS LOAD_DATETIME
FROM
  columns_to_select