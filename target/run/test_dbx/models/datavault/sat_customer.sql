
    
  
  
    merge into test_dbt.sat_customer as DBT_INTERNAL_DEST
      using sat_customer__dbt_tmp as DBT_INTERNAL_SOURCE
      
      
    
        on false
    
  
      
      when matched then update set
         * 
    
      when not matched then insert *
