
    
  
  
    merge into test_dbt.hub_customer as DBT_INTERNAL_DEST
      using hub_customer__dbt_tmp as DBT_INTERNAL_SOURCE
      
      
    
        on DBT_INTERNAL_SOURCE.CUSTOMER_HK = DBT_INTERNAL_DEST.CUSTOMER_HK
    
  
      
      when matched then update set
         * 
    
      when not matched then insert *
