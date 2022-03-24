SELECT
    o.order_id AS ORDER_ID,
    o.order_date AS ORDER_DATE,
    o.customer_id AS CUSTOMER_ID,
    op.product_id AS PRODUCT_ID,
    op.qty AS QTY,
    op.order_amt AS ORDER_AMT
FROM 
    test_dbt.order_product op
    FULL OUTER JOIN test_dbt.order o
    ON op.order_id = o.order_id