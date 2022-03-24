{{ config(materialized='view') }}

{%- set yaml_metadata -%}
source_model: 'stg_order_product'
derived_columns:
  RECORD_SOURCE: "!1SAP"
  LOAD_DATETIME: 'CURRENT_TIMESTAMP()'
hashed_columns:
  ORDER_HK: ORDER_ID
  ORDER_HASHDIFF:
    is_hashdiff: true
    columns:
      - ORDER_DATE
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ dbtvault.stage(include_source_columns=true,
                  source_model=metadata_dict['source_model'],
                  derived_columns=metadata_dict['derived_columns'],
                  hashed_columns=metadata_dict['hashed_columns'],
                  ranked_columns=none) }}