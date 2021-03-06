
      create or replace table test_dbt.sat_order_product
    
    
    using delta
    
    
    
    
    location '/mnt/adls_ss_finance/SS Finance/test/sat_order_product'
    
    as
      

-- Generated by dbtvault.

WITH source_data AS (
    SELECT a.LINK_ORDER_PRODUCT_HK, a.ORDER_PRODUCT_HASHDIFF, a.QTY, a.ORDER_AMT, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM test_dbt.stg_order_product AS a
    WHERE a.LINK_ORDER_PRODUCT_HK IS NOT NULL
),



records_to_insert AS (
    SELECT DISTINCT stage.LINK_ORDER_PRODUCT_HK, stage.ORDER_PRODUCT_HASHDIFF AS HASHDIFF, stage.QTY, stage.ORDER_AMT, stage.LOAD_DATETIME, stage.RECORD_SOURCE
    FROM source_data AS stage
)

SELECT * FROM records_to_insert