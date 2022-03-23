{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_customer'
derived_columns:
  RECORD_SOURCE: "!SAP"
hashed_columns:
  CUSTOMER_HK: "CUSTOMER_ID"
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "FIRST_NAME"
      - "LAST_NAME"
      - "EMAIL"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

SELECT 
  *,
  TO_DATE({{ dbt_date.today() }}) AS LOAD_DATE
FROM (
{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
)