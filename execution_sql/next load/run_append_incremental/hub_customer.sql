
    insert into table test_dbt.hub_customer
    select `CUSTOMER_HK`, `CUSTOMER_ID`, `LOAD_DATETIME`, `RECORD_SOURCE` from hub_customer__dbt_tmp

