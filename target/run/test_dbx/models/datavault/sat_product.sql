
    insert into table test_dbt.sat_product
    select `PRODUCT_HK`, `HASHDIFF`, `PRODUCT_DESC`, `LOAD_DATETIME`, `RECORD_SOURCE` from sat_product__dbt_tmp

