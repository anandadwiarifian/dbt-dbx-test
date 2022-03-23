{{ config(materialized='view') }}
SELECT
    customer_id AS CUSTOMER_ID,
    first_name AS FIRST_NAME,
    last_name AS LAST_NAME,
    email AS EMAIL 
FROM 
    {{ source('test_dbt', 'customer') }}