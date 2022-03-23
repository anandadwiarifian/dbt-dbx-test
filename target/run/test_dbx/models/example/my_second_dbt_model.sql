
      create or replace table ss_finance.my_second_dbt_model
    
    
    using delta
    
    
    
    
    location '/mnt/adls_ss_finance/SS Finance/test/my_second_dbt_model'
    
    as
      -- Use the `ref` function to select from other models



select *
from ss_finance.my_first_dbt_model
where emp_title = 'Engineer'