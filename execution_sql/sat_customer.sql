
      create or replace table test_dbt.sat_customer
    
    
    using delta
    
    
    
    
    location '/mnt/adls_ss_finance/SS Finance/test/sat_customer'
    
    as
      

-- Generated by dbtvault.

WITH source_data AS (
    SELECT a.CUSTOMER_HK, a.CUSTOMER_HASHDIFF, a.FIRST_NAME, a.LAST_NAME, a.EMAIL, a.LOAD_DATETIME, a.RECORD_SOURCE
    FROM test_dbt.stg_customer AS a
    WHERE a.CUSTOMER_HK IS NOT NULL
),



records_to_insert AS (
    SELECT DISTINCT stage.CUSTOMER_HK, stage.CUSTOMER_HASHDIFF AS HASHDIFF, stage.FIRST_NAME, stage.LAST_NAME, stage.EMAIL, stage.LOAD_DATETIME, stage.RECORD_SOURCE
    FROM source_data AS stage
)

SELECT * FROM records_to_insert