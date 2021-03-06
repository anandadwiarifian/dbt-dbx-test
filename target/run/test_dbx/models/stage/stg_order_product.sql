create or replace view test_dbt.stg_order_product
  
  as
    

-- Generated by dbtvault.



WITH source_data AS (

    SELECT

    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QTY,
    ORDER_AMT

    FROM test_dbt.raw_order_product
),

derived_columns AS (

    SELECT

    ORDER_ID,
    ORDER_DATE,
    QTY,
    ORDER_AMT,
    '1SAP' AS RECORD_SOURCE,
    CURRENT_TIMESTAMP() AS LOAD_DATETIME,
    CUSTOMER_ID AS CUSTOMER_ID,
    PRODUCT_ID AS PRODUCT_ID

    FROM source_data
),

hashed_columns AS (

    SELECT

    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    PRODUCT_ID,
    QTY,
    ORDER_AMT,
    RECORD_SOURCE,
    LOAD_DATETIME,

    SHA2(NULLIF(UPPER(TRIM(CAST(ORDER_ID AS STRING))), ''), 256) AS ORDER_HK,
    SHA2(NULLIF(UPPER(TRIM(CAST(CUSTOMER_ID AS STRING))), ''), 256) AS CUSTOMER_HK,
    SHA2(NULLIF(UPPER(TRIM(CAST(PRODUCT_ID AS STRING))), ''), 256) AS PRODUCT_HK,
    SHA2(NULLIF(CONCAT_WS('||',
        IFNULL(NULLIF(UPPER(TRIM(CAST(ORDER_ID AS STRING))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST(PRODUCT_ID AS STRING))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST(CUSTOMER_ID AS STRING))), ''), '^^')
    ), '^^||^^||^^'), 256) AS LINK_ORDER_PRODUCT_HK,
    SHA2(CONCAT_WS('||',
        IFNULL(NULLIF(UPPER(TRIM(CAST(ORDER_DATE AS STRING))), ''), '^^')
    ), 256) AS ORDER_HASHDIFF,
    SHA2(CONCAT_WS('||',
        IFNULL(NULLIF(UPPER(TRIM(CAST(ORDER_AMT AS STRING))), ''), '^^'),
        IFNULL(NULLIF(UPPER(TRIM(CAST(QTY AS STRING))), ''), '^^')
    ), 256) AS ORDER_PRODUCT_HASHDIFF

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    ORDER_ID,
    ORDER_DATE,
    QTY,
    ORDER_AMT,
    RECORD_SOURCE,
    LOAD_DATETIME,
    CUSTOMER_ID,
    PRODUCT_ID,
    ORDER_HK,
    CUSTOMER_HK,
    PRODUCT_HK,
    LINK_ORDER_PRODUCT_HK,
    ORDER_HASHDIFF,
    ORDER_PRODUCT_HASHDIFF

    FROM hashed_columns
)

SELECT * FROM columns_to_select
