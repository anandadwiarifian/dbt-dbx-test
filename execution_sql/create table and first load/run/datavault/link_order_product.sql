
      create or replace table test_dbt.link_order_product
    
    
    using delta
    
    
    
    
    location '/mnt/adls_ss_finance/SS Finance/test/link_order_product'
    
    as
      

-- Generated by dbtvault.

WITH row_rank_1 AS (
    SELECT *
    FROM
    (
    SELECT rr.LINK_ORDER_PRODUCT_HK, rr.ORDER_ID, rr.PRODUCT_ID, rr.CUSTOMER_ID, rr.LOAD_DATETIME, rr.RECORD_SOURCE,
           ROW_NUMBER() OVER(
               PARTITION BY rr.LINK_ORDER_PRODUCT_HK
               ORDER BY rr.LOAD_DATETIME
           ) AS row_number
    FROM test_dbt.stg_order_product AS rr
    WHERE rr.LINK_ORDER_PRODUCT_HK IS NOT NULL
    AND rr.ORDER_ID IS NOT NULL
    AND rr.PRODUCT_ID IS NOT NULL
    AND rr.CUSTOMER_ID IS NOT NULL
    ) l
    WHERE l.row_number = 1
),

records_to_insert AS (
    SELECT a.LINK_ORDER_PRODUCT_HK, a.ORDER_ID, a.PRODUCT_ID, a.CUSTOMER_ID, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM row_rank_1 AS a
)

SELECT * FROM records_to_insert