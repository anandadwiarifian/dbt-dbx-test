
    insert into table test_dbt.sat_customer
    select `CUSTOMER_HK`, `HASHDIFF`, `FIRST_NAME`, `LAST_NAME`, `EMAIL`, `LOAD_DATETIME`, `RECORD_SOURCE` from sat_customer__dbt_tmp

