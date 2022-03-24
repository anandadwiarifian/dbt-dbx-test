SELECT
    product_id AS PRODUCT_ID,
    product_desc AS PRODUCT_DESC
FROM 
    {{ source('test_dbt', 'product') }}