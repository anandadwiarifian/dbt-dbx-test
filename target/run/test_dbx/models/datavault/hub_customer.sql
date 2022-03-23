
    
  
  
    merge into test_dbt.hub_customer as DBT_INTERNAL_DEST
      using hub_customer__dbt_tmp as DBT_INTERNAL_SOURCE
      
      
    
        on false
    
  
      
      when matched then update set
         * 
    
      when not matched then insert *
