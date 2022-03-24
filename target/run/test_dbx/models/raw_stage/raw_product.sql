create or replace view test_dbt.raw_product
  
  as
    SELECT
    product_id AS PRODUCT_ID,
    product_desc AS PRODUCT_DESC
FROM 
    test_dbt.product
