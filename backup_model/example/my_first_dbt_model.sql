
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(
    materialized='table',
    file_format='delta',
    location_root='/mnt/adls_ss_finance/SS Finance/test'
    ) 
}}

-- with source_data as (

--     select 1 as id
--     union all
--     select null as id

-- )

-- select *
-- from source_data

SELECT
    *
FROM
    ss_finance.bronze_loan_stats
WHERE
    loan_amnt >= 10000

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
