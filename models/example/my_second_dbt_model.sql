
-- Use the `ref` function to select from other models

{{ config(
    materialized='table',
    file_format='delta',
    location_root='/mnt/adls_ss_finance/SS Finance/test'
    ) 
}}

select *
from {{ ref('my_first_dbt_model') }}
where id = 1
