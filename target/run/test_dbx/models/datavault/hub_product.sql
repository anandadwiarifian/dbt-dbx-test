
    insert into table test_dbt.hub_product
    select `PRODUCT_HK`, `PRODUCT_ID`, `LOAD_DATETIME`, `RECORD_SOURCE` from hub_product__dbt_tmp

