create or replace view test_dbt.raw_customer
  
  as
    
SELECT
    customer_id AS CUSTOMER_ID,
    first_name AS FIRST_NAME,
    last_name AS LAST_NAME,
    email AS EMAIL 
FROM 
    test_dbt.customer
