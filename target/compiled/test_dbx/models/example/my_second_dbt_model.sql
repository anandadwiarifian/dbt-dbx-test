-- Use the `ref` function to select from other models



select *
from ss_finance.my_first_dbt_model
where emp_title = 'Engineer'