{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'raw_customer'
derived_columns:
  SOURCE: "!SAP"
hashed_columns:
  CUSTOMER_HK: "customer_id"
  CUSTOMER_HASHDIFF:
    is_hashdiff: true
    columns:
      - "first_name"
      - "last_name"
      - "email"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

WITH staging AS (
{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}
)

SELECT 
  *,
  TO_DATE({{ dbt_date.today() }}) AS LOAD_DATE
FROM staging